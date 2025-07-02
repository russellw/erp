#!/usr/bin/env python3
"""
ERP Database Statistics Analyzer
Analyzes and reports comprehensive statistics about the ERP database contents.
"""

import psycopg2
import psycopg2.extras
from datetime import datetime
import json
from collections import defaultdict
import sys

# Database configuration
DB_CONFIG = {
    'host': 'localhost',
    'port': 5432,
    'database': 'erp',
    'user': 'erp',
    'password': 'pass'
}

def connect_to_database():
    """Connect to the PostgreSQL database."""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        return conn
    except psycopg2.Error as e:
        print(f"❌ Error connecting to database: {e}")
        sys.exit(1)

def get_table_stats(conn):
    """Get basic table statistics (row counts, size)."""
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    
    # Get all tables in the public schema
    cursor.execute("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_type = 'BASE TABLE'
        ORDER BY table_name
    """)
    tables = [row['table_name'] for row in cursor.fetchall()]
    
    table_stats = {}
    total_rows = 0
    
    print("📊 TABLE STATISTICS")
    print("=" * 80)
    print(f"{'Table Name':<30} {'Rows':<10} {'Size':<15} {'Description'}")
    print("-" * 80)
    
    for table in tables:
        # Get row count
        cursor.execute(f"SELECT COUNT(*) FROM {table}")
        row_count = cursor.fetchone()[0]
        total_rows += row_count
        
        # Get table size
        cursor.execute(f"""
            SELECT pg_size_pretty(pg_total_relation_size('{table}')) as size
        """)
        size = cursor.fetchone()[0]
        
        # Get table comment/description
        cursor.execute(f"""
            SELECT obj_description(oid) as description
            FROM pg_class 
            WHERE relname = '{table}'
        """)
        desc_result = cursor.fetchone()
        description = desc_result[0] if desc_result and desc_result[0] else ""
        
        table_stats[table] = {
            'rows': row_count,
            'size': size,
            'description': description
        }
        
        print(f"{table:<30} {row_count:<10} {size:<15} {description}")
    
    print("-" * 80)
    print(f"{'TOTAL TABLES: ' + str(len(tables)):<30} {total_rows:<10}")
    print()
    
    cursor.close()
    return table_stats

def get_business_module_stats(conn):
    """Get statistics grouped by business modules."""
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    
    modules = {
        'User Management': ['users', 'roles', 'user_roles'],
        'Company Structure': ['companies', 'departments'],
        'Customer Management': ['customers', 'customer_contacts', 'customer_territories'],
        'CRM': ['leads', 'opportunities', 'campaigns', 'activities', 'lead_sources', 'territories', 'territory_assignments'],
        'Sales': ['sales_orders', 'sales_order_items'],
        'Purchasing': ['suppliers', 'purchase_orders', 'purchase_order_items'],
        'Financial': ['accounts', 'invoices', 'invoice_items', 'payments', 'journal_entries', 'journal_entry_lines'],
        'Inventory': ['products', 'product_categories', 'warehouses', 'inventory', 'stock_movements'],
        'HR Management': ['employees', 'job_positions', 'time_entries', 'leave_types', 'leave_balances', 'leave_requests', 'pay_periods', 'payroll_runs', 'payroll_items', 'performance_reviews', 'employee_benefits', 'benefit_types'],
        'Training': ['training_programs', 'training_sessions', 'training_enrollments', 'skills', 'employee_skills'],
        'Manufacturing': ['bom_headers', 'bom_items', 'work_centers', 'routings', 'routing_operations', 'production_orders', 'work_orders', 'mrp_runs', 'mrp_requirements', 'quality_standards', 'quality_inspections'],
        'Equipment': ['equipment', 'maintenance_schedules', 'maintenance_records'],
        'Project Management': ['projects', 'project_phases', 'project_tasks', 'task_dependencies', 'project_resources', 'resource_capacity', 'project_time_entries', 'project_expenses', 'project_invoices', 'project_templates', 'project_template_tasks'],
        'Asset Management': ['asset_categories', 'fixed_assets', 'depreciation_schedules', 'asset_transfers', 'asset_valuations', 'asset_maintenance'],
        'Budgeting': ['budget_periods', 'budget_categories', 'budget_lines', 'budget_revisions', 'financial_forecasts', 'forecast_lines'],
        'Reporting & KPIs': ['reports', 'kpis', 'kpi_values'],
        'Document Management': ['document_categories', 'documents', 'document_permissions'],
        'Workflow': ['workflows', 'workflow_steps', 'workflow_instances', 'workflow_step_instances'],
        'System': ['system_settings', 'user_notifications', 'api_keys', 'integration_logs', 'audit_logs', 'currencies', 'exchange_rates', 'company_currencies']
    }
    
    print("🏢 BUSINESS MODULE STATISTICS")
    print("=" * 80)
    
    module_totals = {}
    for module, tables in modules.items():
        total_records = 0
        active_tables = 0
        
        for table in tables:
            cursor.execute(f"""
                SELECT COUNT(*) FROM information_schema.tables 
                WHERE table_name = '{table}' AND table_schema = 'public'
            """)
            if cursor.fetchone()[0] > 0:  # Table exists
                cursor.execute(f"SELECT COUNT(*) FROM {table}")
                count = cursor.fetchone()[0]
                total_records += count
                if count > 0:
                    active_tables += 1
        
        module_totals[module] = {
            'total_records': total_records,
            'active_tables': active_tables,
            'total_tables': len(tables)
        }
        
        print(f"{module:<25} {total_records:>8} records  {active_tables:>2}/{len(tables):>2} tables with data")
    
    print()
    cursor.close()
    return module_totals

def get_data_quality_stats(conn):
    """Analyze data quality and relationships."""
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    
    print("🔍 DATA QUALITY ANALYSIS")
    print("=" * 80)
    
    # Check for orphaned records (foreign key violations)
    quality_stats = {}
    
    # Users and roles
    if table_has_data(cursor, 'users') and table_has_data(cursor, 'user_roles'):
        cursor.execute("SELECT COUNT(*) FROM users")
        user_count = cursor.fetchone()[0]
        cursor.execute("SELECT COUNT(DISTINCT user_id) FROM user_roles")
        users_with_roles = cursor.fetchone()[0]
        print(f"Users: {user_count} total, {users_with_roles} have roles assigned")
    
    # Employees and departments
    if table_has_data(cursor, 'employees') and table_has_data(cursor, 'departments'):
        cursor.execute("SELECT COUNT(*) FROM employees WHERE department_id IS NOT NULL")
        employees_with_dept = cursor.fetchone()[0]
        cursor.execute("SELECT COUNT(*) FROM employees")
        total_employees = cursor.fetchone()[0]
        print(f"Employees: {total_employees} total, {employees_with_dept} assigned to departments")
    
    # Sales orders and items
    if table_has_data(cursor, 'sales_orders') and table_has_data(cursor, 'sales_order_items'):
        cursor.execute("SELECT COUNT(*) FROM sales_orders")
        orders = cursor.fetchone()[0]
        cursor.execute("SELECT COUNT(*) FROM sales_order_items")
        items = cursor.fetchone()[0]
        cursor.execute("SELECT AVG(item_count) FROM (SELECT COUNT(*) as item_count FROM sales_order_items GROUP BY sales_order_id) sub")
        avg_items = cursor.fetchone()[0] or 0
        print(f"Sales Orders: {orders} orders, {items} line items, {avg_items:.1f} avg items per order")
    
    # Invoices and payments
    if table_has_data(cursor, 'invoices'):
        cursor.execute("SELECT status, COUNT(*) FROM invoices GROUP BY status ORDER BY status")
        invoice_statuses = cursor.fetchall()
        print("Invoice Status Distribution:")
        for status, count in invoice_statuses:
            print(f"  {status}: {count}")
    
    print()
    cursor.close()
    return quality_stats

def get_financial_summary(conn):
    """Get financial data summary."""
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    
    print("💰 FINANCIAL SUMMARY")
    print("=" * 80)
    
    # Sales orders summary
    if table_has_data(cursor, 'sales_orders'):
        cursor.execute("""
            SELECT 
                status,
                COUNT(*) as count,
                SUM(total_amount) as total_value
            FROM sales_orders 
            GROUP BY status 
            ORDER BY status
        """)
        print("Sales Orders by Status:")
        total_sales = 0
        for row in cursor.fetchall():
            print(f"  {row['status']}: {row['count']} orders, ${row['total_value']:,.2f}")
            total_sales += row['total_value'] or 0
        print(f"  TOTAL SALES VALUE: ${total_sales:,.2f}")
        print()
    
    # Invoice summary
    if table_has_data(cursor, 'invoices'):
        cursor.execute("""
            SELECT 
                status,
                COUNT(*) as count,
                SUM(total_amount) as total_value
            FROM invoices 
            GROUP BY status 
            ORDER BY status
        """)
        print("Invoices by Status:")
        total_invoiced = 0
        for row in cursor.fetchall():
            print(f"  {row['status']}: {row['count']} invoices, ${row['total_value']:,.2f}")
            total_invoiced += row['total_value'] or 0
        print(f"  TOTAL INVOICED: ${total_invoiced:,.2f}")
        print()
    
    # Payments summary
    if table_has_data(cursor, 'payments'):
        cursor.execute("SELECT COUNT(*), SUM(amount) FROM payments")
        payment_count, payment_total = cursor.fetchone()
        print(f"Payments: {payment_count} payments totaling ${payment_total:,.2f}")
        print()
    
    cursor.close()

def get_operational_summary(conn):
    """Get operational data summary."""
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    
    print("⚙️ OPERATIONAL SUMMARY")
    print("=" * 80)
    
    # Product inventory
    if table_has_data(cursor, 'products') and table_has_data(cursor, 'inventory'):
        cursor.execute("SELECT COUNT(*) FROM products")
        product_count = cursor.fetchone()[0]
        cursor.execute("SELECT COUNT(*) FROM inventory WHERE quantity_on_hand > 0")
        stocked_products = cursor.fetchone()[0]
        cursor.execute("SELECT SUM(quantity_on_hand) FROM inventory")
        total_inventory = cursor.fetchone()[0] or 0
        print(f"Products: {product_count} total, {stocked_products} in stock, {total_inventory:,.0f} total units")
    
    # Production orders
    if table_has_data(cursor, 'production_orders'):
        cursor.execute("SELECT status, COUNT(*) FROM production_orders GROUP BY status ORDER BY status")
        print("Production Orders by Status:")
        for status, count in cursor.fetchall():
            print(f"  {status}: {count}")
    
    # Projects
    if table_has_data(cursor, 'projects'):
        cursor.execute("SELECT status, COUNT(*) FROM projects GROUP BY status ORDER BY status")
        print("Projects by Status:")
        for status, count in cursor.fetchall():
            print(f"  {status}: {count}")
    
    print()
    cursor.close()

def get_user_activity_summary(conn):
    """Get user and activity summary."""
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    
    print("👥 USER & ACTIVITY SUMMARY")
    print("=" * 80)
    
    # User counts
    if table_has_data(cursor, 'users'):
        cursor.execute("SELECT COUNT(*) FROM users WHERE is_active = true")
        active_users = cursor.fetchone()[0]
        cursor.execute("SELECT COUNT(*) FROM users")
        total_users = cursor.fetchone()[0]
        print(f"Users: {active_users} active / {total_users} total")
    
    # Employee counts
    if table_has_data(cursor, 'employees'):
        cursor.execute("SELECT COUNT(*) FROM employees WHERE is_active = true")
        active_employees = cursor.fetchone()[0]
        cursor.execute("SELECT COUNT(*) FROM employees")
        total_employees = cursor.fetchone()[0]
        print(f"Employees: {active_employees} active / {total_employees} total")
    
    # Recent activities
    if table_has_data(cursor, 'activities'):
        cursor.execute("SELECT activity_type, COUNT(*) FROM activities GROUP BY activity_type ORDER BY COUNT(*) DESC")
        print("Activities by Type:")
        for activity_type, count in cursor.fetchall():
            print(f"  {activity_type}: {count}")
    
    print()
    cursor.close()

def table_has_data(cursor, table_name):
    """Check if a table exists and has data."""
    try:
        cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
        return cursor.fetchone()[0] > 0
    except:
        return False

def generate_json_report(table_stats, module_stats):
    """Generate a JSON report of all statistics."""
    report = {
        'generated_at': datetime.now().isoformat(),
        'database': DB_CONFIG['database'],
        'summary': {
            'total_tables': len(table_stats),
            'total_records': sum(stats['rows'] for stats in table_stats.values()),
            'non_empty_tables': len([t for t in table_stats.values() if t['rows'] > 0])
        },
        'table_statistics': table_stats,
        'module_statistics': module_stats
    }
    
    with open('/mnt/c/erp/database_stats_report.json', 'w') as f:
        json.dump(report, f, indent=2, default=str)
    
    print(f"📄 Detailed JSON report saved to: database_stats_report.json")

def main():
    """Main function to run all statistics analysis."""
    print("🔍 ERP DATABASE STATISTICS ANALYZER")
    print("=" * 80)
    print(f"Database: {DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}")
    print(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print()
    
    # Connect to database
    conn = connect_to_database()
    
    try:
        # Run all analysis functions
        table_stats = get_table_stats(conn)
        module_stats = get_business_module_stats(conn)
        get_data_quality_stats(conn)
        get_financial_summary(conn)
        get_operational_summary(conn)
        get_user_activity_summary(conn)
        
        # Generate JSON report
        generate_json_report(table_stats, module_stats)
        
        print("✅ Database analysis completed successfully!")
        
    except Exception as e:
        print(f"❌ Error during analysis: {e}")
        sys.exit(1)
    finally:
        conn.close()

if __name__ == "__main__":
    main()