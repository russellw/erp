#!/usr/bin/env python3
"""
Test script to verify PostgreSQL database connection for ERP system.
"""

import psycopg2
import sys
import os

def test_database_connection():
    """Test connection to the ERP PostgreSQL database."""
    
    # Database connection parameters
    db_config = {
        'host': os.getenv('DB_HOST', 'localhost'),
        'port': os.getenv('DB_PORT', '5432'),
        'database': os.getenv('DB_NAME', 'erp'),
        'user': os.getenv('DB_USER', 'erp'),
        'password': os.getenv('DB_PASSWORD', 'pass')
    }
    
    try:
        print(f"Attempting to connect to database '{db_config['database']}' on {db_config['host']}:{db_config['port']}")
        
        # Attempt connection
        conn = psycopg2.connect(**db_config)
        cursor = conn.cursor()
        
        # Test basic query
        cursor.execute("SELECT version();")
        version = cursor.fetchone()
        
        print("✅ Database connection successful!")
        print(f"PostgreSQL version: {version[0]}")
        
        # Check if database exists and get basic info
        cursor.execute("SELECT current_database(), current_user;")
        db_info = cursor.fetchone()
        print(f"Connected to database: {db_info[0]}")
        print(f"Connected as user: {db_info[1]}")
        
        cursor.close()
        conn.close()
        
        return True
        
    except psycopg2.OperationalError as e:
        print("❌ Database connection failed!")
        print(f"Error: {e}")
        print("\nTroubleshooting:")
        print("- Ensure PostgreSQL is running on localhost:5432")
        print("- Verify the 'erp' database exists")
        print("- Check username/password credentials")
        return False
        
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        return False

if __name__ == "__main__":
    success = test_database_connection()
    sys.exit(0 if success else 1)