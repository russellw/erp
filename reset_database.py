#!/usr/bin/env python3
"""
Database reset script for ERP system development.
Safely deletes and recreates the database with schema and sample data.

This script includes safety checks to prevent accidental use on production databases.
It will exit if the database contains significant data that suggests production usage.
"""

import psycopg2
import sys
import os
from pathlib import Path
import argparse

def get_db_config():
    """Get database configuration from environment variables."""
    return {
        'host': os.getenv('DB_HOST', 'localhost'),
        'port': os.getenv('DB_PORT', '5432'),
        'database': os.getenv('DB_NAME', 'erp'),
        'user': os.getenv('DB_USER', 'erp'),
        'password': os.getenv('DB_PASSWORD', 'pass'),
        'admin_database': os.getenv('ADMIN_DB', 'postgres')
    }

def test_connection(db_config):
    """Test database connection."""
    try:
        conn = psycopg2.connect(**db_config)
        conn.close()
        return True
    except psycopg2.OperationalError:
        return False

def check_production_safety(db_config):
    """
    Check if database contains production-like data.
    Returns True if safe to proceed, False if potentially production.
    """
    try:
        print("🔍 Checking database safety...")
        conn = psycopg2.connect(**db_config)
        cursor = conn.cursor()
        
        # Count total number of tables
        cursor.execute("""
            SELECT COUNT(*) FROM information_schema.tables 
            WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
        """)
        table_count = cursor.fetchone()[0]
        
        # If no tables exist, it's safe
        if table_count == 0:
            print("   ✅ Database is empty - safe to proceed")
            cursor.close()
            conn.close()
            return True
        
        # Check for large amounts of data in key tables
        production_indicators = []
        
        # Check if tables exist and count records
        table_checks = [
            ('users', 20, 'user accounts'),
            ('customers', 50, 'customer records'),
            ('sales_orders', 100, 'sales orders'),
            ('invoices', 100, 'invoices'),
            ('products', 200, 'products'),
            ('journal_entries', 200, 'journal entries'),
            ('employees', 50, 'employee records')
        ]
        
        for table_name, threshold, description in table_checks:
            try:
                cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
                count = cursor.fetchone()[0]
                print(f"   📊 {table_name}: {count} records")
                
                if count > threshold:
                    production_indicators.append(f"{count} {description} (threshold: {threshold})")
            except psycopg2.Error:
                # Table doesn't exist, skip
                pass
        
        # Check for recent activity (data modified in last 30 days)
        recent_activity_tables = ['users', 'sales_orders', 'invoices', 'customers']
        recent_activity_count = 0
        
        for table_name in recent_activity_tables:
            try:
                cursor.execute(f"""
                    SELECT COUNT(*) FROM {table_name} 
                    WHERE updated_at > CURRENT_DATE - INTERVAL '30 days'
                    OR created_at > CURRENT_DATE - INTERVAL '30 days'
                """)
                count = cursor.fetchone()[0]
                if count > 0:
                    recent_activity_count += count
                    print(f"   📅 {table_name}: {count} records with recent activity")
            except psycopg2.Error:
                # Column doesn't exist or table doesn't exist, skip
                pass
        
        cursor.close()
        conn.close()
        
        # Evaluate safety
        if production_indicators:
            print("\n🚨 PRODUCTION DATABASE DETECTED!")
            print("The following indicators suggest this is a production database:")
            for indicator in production_indicators:
                print(f"   • {indicator}")
            
            if recent_activity_count > 10:
                print(f"   • {recent_activity_count} records with recent activity (last 30 days)")
            
            print("\n❌ Refusing to proceed - this appears to be a production database")
            print("   To override this safety check, use --force flag (NOT recommended)")
            return False
        
        if recent_activity_count > 10:
            print(f"\n⚠️  Warning: {recent_activity_count} records show recent activity")
            print("   This might be an active development database")
        
        print("   ✅ Database appears safe for reset")
        return True
        
    except psycopg2.Error as e:
        print(f"❌ Error checking database safety: {e}")
        return False

def drop_database(db_config):
    """Drop the ERP database completely."""
    try:
        print(f"🗑️  Dropping database '{db_config['database']}'...")
        
        # Connect to admin database to drop the target database
        admin_config = db_config.copy()
        admin_config['database'] = admin_config['admin_database']
        
        conn = psycopg2.connect(**admin_config)
        conn.autocommit = True
        cursor = conn.cursor()
        
        # Terminate all connections to the target database
        cursor.execute(f"""
            SELECT pg_terminate_backend(pid)
            FROM pg_stat_activity
            WHERE datname = '{db_config['database']}' AND pid <> pg_backend_pid()
        """)
        
        # Drop the database
        cursor.execute(f'DROP DATABASE IF EXISTS "{db_config["database"]}"')
        print(f"   ✅ Database '{db_config['database']}' dropped")
        
        cursor.close()
        conn.close()
        return True
        
    except psycopg2.Error as e:
        print(f"❌ Error dropping database: {e}")
        return False

def create_database(db_config):
    """Create a fresh ERP database."""
    try:
        print(f"🏗️  Creating database '{db_config['database']}'...")
        
        # Connect to admin database to create the target database
        admin_config = db_config.copy()
        admin_config['database'] = admin_config['admin_database']
        
        conn = psycopg2.connect(**admin_config)
        conn.autocommit = True
        cursor = conn.cursor()
        
        # Create the database
        cursor.execute(f'CREATE DATABASE "{db_config["database"]}" OWNER "{db_config["user"]}"')
        print(f"   ✅ Database '{db_config['database']}' created")
        
        cursor.close()
        conn.close()
        return True
        
    except psycopg2.Error as e:
        print(f"❌ Error creating database: {e}")
        return False

def execute_sql_file(db_config, file_path, description):
    """Execute a SQL file against the database."""
    try:
        print(f"📄 Executing {description} from {file_path}...")
        
        with open(file_path, 'r', encoding='utf-8') as file:
            sql_content = file.read()
        
        conn = psycopg2.connect(**db_config)
        cursor = conn.cursor()
        
        # Execute the SQL content
        cursor.execute(sql_content)
        conn.commit()
        
        cursor.close()
        conn.close()
        
        print(f"   ✅ {description} executed successfully")
        return True
        
    except FileNotFoundError:
        print(f"❌ File not found: {file_path}")
        return False
    except psycopg2.Error as e:
        print(f"❌ Database error executing {description}: {e}")
        return False
    except Exception as e:
        print(f"❌ Error executing {description}: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(
        description='Reset ERP database with schema and sample data',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Safety Features:
  This script includes safety checks to prevent accidental use on production databases.
  It will refuse to run if the database contains significant data.
  
  Production indicators:
    • More than 20 user accounts
    • More than 50 customers
    • More than 100 sales orders/invoices
    • More than 200 products
    • Recent activity in the last 30 days

Examples:
  python reset_database.py                    # Safe reset with all checks
  python reset_database.py --dry-run          # Check what would be done
  python reset_database.py --force            # Override safety checks (dangerous)
  python reset_database.py --schema-only      # Only create schema, no sample data
        """
    )
    
    parser.add_argument('--schema', default='schema.sql', 
                       help='Path to schema file (default: schema.sql)')
    parser.add_argument('--sample-data', default='sample_data.sql',
                       help='Path to sample data file (default: sample_data.sql)')
    parser.add_argument('--force', action='store_true',
                       help='Override production safety checks (DANGEROUS)')
    parser.add_argument('--dry-run', action='store_true',
                       help='Show what would be done without making changes')
    parser.add_argument('--schema-only', action='store_true',
                       help='Only create schema, skip sample data')
    
    args = parser.parse_args()
    
    # Get database configuration
    db_config = get_db_config()
    
    print("🔄 ERP Database Reset Tool")
    print("=" * 50)
    print(f"Host: {db_config['host']}:{db_config['port']}")
    print(f"Database: {db_config['database']}")
    print(f"User: {db_config['user']}")
    print(f"Schema file: {args.schema}")
    if not args.schema_only:
        print(f"Sample data file: {args.sample_data}")
    print("=" * 50)
    
    if args.dry_run:
        print("\n🔍 DRY RUN MODE - No changes will be made")
        print("\nWould perform the following actions:")
        print("1. Check database safety")
        print(f"2. Drop database '{db_config['database']}'")
        print(f"3. Create database '{db_config['database']}'")
        print(f"4. Execute schema from '{args.schema}'")
        if not args.schema_only:
            print(f"5. Load sample data from '{args.sample_data}'")
        return
    
    # Check if database exists
    database_exists = test_connection(db_config)
    
    if database_exists:
        # Perform safety checks
        if not args.force:
            if not check_production_safety(db_config):
                print("\n💡 If you're certain this is a development database,")
                print("   you can override this check with --force flag")
                sys.exit(1)
        else:
            print("⚠️  WARNING: Safety checks bypassed with --force flag")
        
        # Confirm destruction
        print(f"\n⚠️  This will COMPLETELY DELETE the '{db_config['database']}' database!")
        response = input("Type 'YES' to confirm: ")
        if response != 'YES':
            print("Operation cancelled")
            sys.exit(0)
    
    # Verify required files exist
    schema_path = Path(args.schema)
    if not schema_path.exists():
        print(f"❌ Schema file not found: {schema_path}")
        sys.exit(1)
    
    if not args.schema_only:
        sample_data_path = Path(args.sample_data)
        if not sample_data_path.exists():
            print(f"❌ Sample data file not found: {sample_data_path}")
            sys.exit(1)
    
    print("\n🚀 Starting database reset...")
    
    # Step 1: Drop existing database
    if database_exists:
        if not drop_database(db_config):
            sys.exit(1)
    
    # Step 2: Create fresh database
    if not create_database(db_config):
        sys.exit(1)
    
    # Step 3: Execute schema
    if not execute_sql_file(db_config, args.schema, "database schema"):
        sys.exit(1)
    
    # Step 4: Load sample data (if requested)
    if not args.schema_only:
        if not execute_sql_file(db_config, args.sample_data, "sample data"):
            print("⚠️  Schema created but sample data loading failed")
            sys.exit(1)
    
    print("\n🎉 Database reset completed successfully!")
    print("\nDatabase is ready for development with:")
    print("• Complete ERP schema structure")
    if not args.schema_only:
        print("• Comprehensive sample data")
        print("• Test users and sample business scenarios")
    
    print(f"\nDatabase: {db_config['host']}:{db_config['port']}/{db_config['database']}")
    if not args.schema_only:
        print("Default admin login: admin / admin123 (please change!)")

if __name__ == "__main__":
    main()