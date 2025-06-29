#!/usr/bin/env python3
"""
Database initialization script for ERP system.
Reads schema.sql and executes it to create the database structure.
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
        'password': os.getenv('DB_PASSWORD', 'pass')
    }

def test_connection(db_config):
    """Test database connection before proceeding."""
    try:
        print(f"Testing connection to database '{db_config['database']}' on {db_config['host']}:{db_config['port']}")
        conn = psycopg2.connect(**db_config)
        conn.close()
        print("✅ Database connection successful")
        return True
    except psycopg2.OperationalError as e:
        print(f"❌ Database connection failed: {e}")
        print("\nTroubleshooting:")
        print("- Ensure PostgreSQL is running")
        print(f"- Verify the '{db_config['database']}' database exists")
        print("- Check username/password credentials")
        return False

def read_schema_file(schema_path):
    """Read the SQL schema file."""
    try:
        with open(schema_path, 'r', encoding='utf-8') as file:
            return file.read()
    except FileNotFoundError:
        print(f"❌ Schema file not found: {schema_path}")
        return None
    except Exception as e:
        print(f"❌ Error reading schema file: {e}")
        return None

def execute_schema(db_config, schema_sql, drop_existing=False):
    """Execute the schema SQL to create database structure."""
    try:
        conn = psycopg2.connect(**db_config)
        conn.autocommit = True
        cursor = conn.cursor()
        
        if drop_existing:
            print("⚠️  Dropping existing tables...")
            # Get all tables in current schema
            cursor.execute("""
                SELECT tablename FROM pg_tables 
                WHERE schemaname = 'public' 
                ORDER BY tablename
            """)
            tables = cursor.fetchall()
            
            if tables:
                # Drop tables with CASCADE to handle dependencies
                table_names = [table[0] for table in tables]
                drop_sql = f"DROP TABLE IF EXISTS {', '.join(table_names)} CASCADE"
                cursor.execute(drop_sql)
                print(f"   Dropped {len(tables)} existing tables")
        
        print("🔧 Executing schema...")
        
        # Split schema into individual statements
        statements = [stmt.strip() for stmt in schema_sql.split(';') if stmt.strip()]
        
        for i, statement in enumerate(statements, 1):
            try:
                cursor.execute(statement)
                if statement.upper().startswith('CREATE TABLE'):
                    table_name = statement.split()[2].strip()
                    print(f"   Created table: {table_name}")
                elif statement.upper().startswith('CREATE INDEX'):
                    index_name = statement.split()[2].strip()
                    print(f"   Created index: {index_name}")
                elif statement.upper().startswith('CREATE EXTENSION'):
                    ext_name = statement.split()[3].strip().strip('"')
                    print(f"   Enabled extension: {ext_name}")
            except psycopg2.Error as e:
                print(f"❌ Error executing statement {i}: {e}")
                print(f"   Statement: {statement[:100]}...")
                raise
        
        cursor.close()
        conn.close()
        
        print("✅ Database schema initialized successfully!")
        return True
        
    except psycopg2.Error as e:
        print(f"❌ Database error: {e}")
        return False
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        return False

def create_default_data(db_config):
    """Insert basic default data for system initialization."""
    try:
        conn = psycopg2.connect(**db_config)
        cursor = conn.cursor()
        
        print("📝 Inserting default data...")
        
        # Default roles
        cursor.execute("""
            INSERT INTO roles (name, description) 
            VALUES 
                ('admin', 'System Administrator'),
                ('manager', 'Department Manager'),
                ('employee', 'Regular Employee'),
                ('accountant', 'Accounting Staff'),
                ('sales', 'Sales Representative')
            ON CONFLICT (name) DO NOTHING
        """)
        
        # Default admin user (password: admin123 - should be changed!)
        cursor.execute("""
            INSERT INTO users (username, email, password_hash, first_name, last_name)
            VALUES ('admin', 'admin@erp.local', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj5QvzW1HEmy', 'System', 'Administrator')
            ON CONFLICT (username) DO NOTHING
        """)
        
        # Assign admin role to admin user
        cursor.execute("""
            INSERT INTO user_roles (user_id, role_id)
            SELECT u.id, r.id 
            FROM users u, roles r 
            WHERE u.username = 'admin' AND r.name = 'admin'
            ON CONFLICT DO NOTHING
        """)
        
        # Default company
        cursor.execute("""
            INSERT INTO companies (name, address, city, country, email)
            VALUES ('Default Company', '123 Business St', 'Business City', 'USA', 'info@company.com')
        """)
        
        # Basic chart of accounts
        cursor.execute("""
            INSERT INTO accounts (account_number, name, account_type, company_id)
            SELECT '1000', 'Cash', 'asset', c.id FROM companies c WHERE c.name = 'Default Company'
            UNION ALL
            SELECT '1200', 'Accounts Receivable', 'asset', c.id FROM companies c WHERE c.name = 'Default Company'
            UNION ALL
            SELECT '1500', 'Inventory', 'asset', c.id FROM companies c WHERE c.name = 'Default Company'
            UNION ALL
            SELECT '2000', 'Accounts Payable', 'liability', c.id FROM companies c WHERE c.name = 'Default Company'
            UNION ALL
            SELECT '3000', 'Owner Equity', 'equity', c.id FROM companies c WHERE c.name = 'Default Company'
            UNION ALL
            SELECT '4000', 'Sales Revenue', 'revenue', c.id FROM companies c WHERE c.name = 'Default Company'
            UNION ALL
            SELECT '5000', 'Cost of Goods Sold', 'expense', c.id FROM companies c WHERE c.name = 'Default Company'
        """)
        
        conn.commit()
        cursor.close()
        conn.close()
        
        print("✅ Default data inserted successfully!")
        return True
        
    except psycopg2.Error as e:
        print(f"❌ Error inserting default data: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description='Initialize ERP database from schema')
    parser.add_argument('--schema', default='schema.sql', help='Path to schema file (default: schema.sql)')
    parser.add_argument('--drop', action='store_true', help='Drop existing tables before creating new ones')
    parser.add_argument('--no-seed', action='store_true', help='Skip inserting default seed data')
    parser.add_argument('--test-only', action='store_true', help='Only test database connection')
    
    args = parser.parse_args()
    
    # Get database configuration
    db_config = get_db_config()
    
    print("🗄️  ERP Database Initialization")
    print("=" * 40)
    print(f"Host: {db_config['host']}:{db_config['port']}")
    print(f"Database: {db_config['database']}")
    print(f"User: {db_config['user']}")
    print(f"Schema file: {args.schema}")
    print("=" * 40)
    
    # Test connection
    if not test_connection(db_config):
        sys.exit(1)
    
    if args.test_only:
        print("✅ Connection test completed successfully")
        sys.exit(0)
    
    # Read schema file
    schema_path = Path(args.schema)
    if not schema_path.exists():
        print(f"❌ Schema file not found: {schema_path}")
        sys.exit(1)
    
    schema_sql = read_schema_file(schema_path)
    if not schema_sql:
        sys.exit(1)
    
    # Execute schema
    if not execute_schema(db_config, schema_sql, args.drop):
        sys.exit(1)
    
    # Insert default data
    if not args.no_seed:
        if not create_default_data(db_config):
            print("⚠️  Schema created but default data insertion failed")
            sys.exit(1)
    
    print("\n🎉 Database initialization completed successfully!")
    print("\nNext steps:")
    print("1. Change the default admin password")
    print("2. Configure your company information")
    print("3. Set up additional users and roles")

if __name__ == "__main__":
    main()