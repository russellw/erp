-- Sample Data for ERP System
-- This file provides comprehensive test data for all major entities

-- Start transaction
BEGIN;

-- Clear existing data (in dependency order)
-- Note: This comprehensive cleanup covers all new tables
TRUNCATE TABLE integration_logs CASCADE;
TRUNCATE TABLE api_keys CASCADE;
TRUNCATE TABLE user_notifications CASCADE;
TRUNCATE TABLE system_settings CASCADE;
TRUNCATE TABLE exchange_rates CASCADE;
TRUNCATE TABLE company_currencies CASCADE;
TRUNCATE TABLE workflow_step_instances CASCADE;
TRUNCATE TABLE workflow_instances CASCADE;
TRUNCATE TABLE workflow_steps CASCADE;
TRUNCATE TABLE workflows CASCADE;
TRUNCATE TABLE document_permissions CASCADE;
TRUNCATE TABLE documents CASCADE;
TRUNCATE TABLE document_categories CASCADE;
TRUNCATE TABLE kpi_values CASCADE;
TRUNCATE TABLE kpis CASCADE;
TRUNCATE TABLE report_schedules CASCADE;
TRUNCATE TABLE reports CASCADE;
TRUNCATE TABLE forecast_lines CASCADE;
TRUNCATE TABLE financial_forecasts CASCADE;
TRUNCATE TABLE budget_revisions CASCADE;
TRUNCATE TABLE budget_lines CASCADE;
TRUNCATE TABLE budget_categories CASCADE;
TRUNCATE TABLE budget_periods CASCADE;
TRUNCATE TABLE asset_valuations CASCADE;
TRUNCATE TABLE asset_transfers CASCADE;
TRUNCATE TABLE asset_maintenance CASCADE;
TRUNCATE TABLE depreciation_schedules CASCADE;
TRUNCATE TABLE fixed_assets CASCADE;
TRUNCATE TABLE asset_categories CASCADE;
TRUNCATE TABLE project_template_tasks CASCADE;
TRUNCATE TABLE project_templates CASCADE;
TRUNCATE TABLE employee_skills CASCADE;
TRUNCATE TABLE skills CASCADE;
TRUNCATE TABLE resource_capacity CASCADE;
TRUNCATE TABLE project_invoices CASCADE;
TRUNCATE TABLE project_expenses CASCADE;
TRUNCATE TABLE project_time_entries CASCADE;
TRUNCATE TABLE project_resources CASCADE;
TRUNCATE TABLE task_dependencies CASCADE;
TRUNCATE TABLE project_tasks CASCADE;
TRUNCATE TABLE project_phases CASCADE;
TRUNCATE TABLE projects CASCADE;
TRUNCATE TABLE maintenance_records CASCADE;
TRUNCATE TABLE maintenance_schedules CASCADE;
TRUNCATE TABLE equipment CASCADE;
TRUNCATE TABLE quality_inspections CASCADE;
TRUNCATE TABLE quality_standards CASCADE;
TRUNCATE TABLE mrp_requirements CASCADE;
TRUNCATE TABLE mrp_runs CASCADE;
TRUNCATE TABLE work_orders CASCADE;
TRUNCATE TABLE production_orders CASCADE;
TRUNCATE TABLE routing_operations CASCADE;
TRUNCATE TABLE routings CASCADE;
TRUNCATE TABLE work_centers CASCADE;
TRUNCATE TABLE bom_items CASCADE;
TRUNCATE TABLE bom_headers CASCADE;
TRUNCATE TABLE training_enrollments CASCADE;
TRUNCATE TABLE training_sessions CASCADE;
TRUNCATE TABLE training_programs CASCADE;
TRUNCATE TABLE performance_reviews CASCADE;
TRUNCATE TABLE performance_review_cycles CASCADE;
TRUNCATE TABLE payroll_items CASCADE;
TRUNCATE TABLE payroll_runs CASCADE;
TRUNCATE TABLE pay_periods CASCADE;
TRUNCATE TABLE leave_requests CASCADE;
TRUNCATE TABLE leave_balances CASCADE;
TRUNCATE TABLE leave_types CASCADE;
TRUNCATE TABLE time_entries CASCADE;
TRUNCATE TABLE employee_benefits CASCADE;
TRUNCATE TABLE benefit_types CASCADE;
TRUNCATE TABLE job_positions CASCADE;
TRUNCATE TABLE customer_territories CASCADE;
TRUNCATE TABLE territory_assignments CASCADE;
TRUNCATE TABLE territories CASCADE;
TRUNCATE TABLE customer_contacts CASCADE;
TRUNCATE TABLE activity_participants CASCADE;
TRUNCATE TABLE activities CASCADE;
TRUNCATE TABLE campaign_members CASCADE;
TRUNCATE TABLE campaigns CASCADE;
TRUNCATE TABLE opportunity_products CASCADE;
TRUNCATE TABLE opportunities CASCADE;
TRUNCATE TABLE leads CASCADE;
TRUNCATE TABLE lead_sources CASCADE;
TRUNCATE TABLE journal_entry_lines CASCADE;
TRUNCATE TABLE journal_entries CASCADE;
TRUNCATE TABLE accounts CASCADE;
TRUNCATE TABLE payments CASCADE;
TRUNCATE TABLE invoice_items CASCADE;
TRUNCATE TABLE invoices CASCADE;
TRUNCATE TABLE sales_order_items CASCADE;
TRUNCATE TABLE sales_orders CASCADE;
TRUNCATE TABLE purchase_order_items CASCADE;
TRUNCATE TABLE purchase_orders CASCADE;
TRUNCATE TABLE inventory CASCADE;
TRUNCATE TABLE products CASCADE;
TRUNCATE TABLE product_categories CASCADE;
TRUNCATE TABLE warehouses CASCADE;
TRUNCATE TABLE suppliers CASCADE;
TRUNCATE TABLE customers CASCADE;
TRUNCATE TABLE employees CASCADE;
TRUNCATE TABLE user_roles CASCADE;
TRUNCATE TABLE departments CASCADE;
TRUNCATE TABLE users CASCADE;
TRUNCATE TABLE roles CASCADE;
TRUNCATE TABLE companies CASCADE;
TRUNCATE TABLE currencies CASCADE;
TRUNCATE TABLE locales CASCADE;

-- Insert Companies
INSERT INTO companies (id, name, tax_id, registration_number, address, city, state, postal_code, country, phone, email, website) VALUES
('550e8400-e29b-41d4-a716-446655440000', 'TechFlow Solutions Inc.', 'TF123456789', 'REG2024001', '1234 Innovation Drive', 'San Francisco', 'CA', '94105', 'USA', '+1-555-0123', 'info@techflow.com', 'https://techflow.com'),
('550e8400-e29b-41d4-a716-446655440001', 'Global Manufacturing Corp', 'GM987654321', 'REG2024002', '5678 Industrial Blvd', 'Detroit', 'MI', '48201', 'USA', '+1-555-0456', 'contact@globalmfg.com', 'https://globalmfg.com');

-- Insert Roles
INSERT INTO roles (id, name, description) VALUES
('550e8400-e29b-41d4-a716-446655440010', 'admin', 'System Administrator'),
('550e8400-e29b-41d4-a716-446655440011', 'manager', 'Department Manager'),
('550e8400-e29b-41d4-a716-446655440012', 'employee', 'Regular Employee'),
('550e8400-e29b-41d4-a716-446655440013', 'sales', 'Sales Representative'),
('550e8400-e29b-41d4-a716-446655440014', 'accountant', 'Accounting Staff');

-- Insert Users (password hash for 'password' using bcrypt)
INSERT INTO users (id, username, email, password_hash, first_name, last_name, is_active) VALUES
('550e8400-e29b-41d4-a716-446655440020', 'admin', 'admin@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'System', 'Administrator', true),
('550e8400-e29b-41d4-a716-446655440021', 'jsmith', 'john.smith@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'John', 'Smith', true),
('550e8400-e29b-41d4-a716-446655440022', 'mjohnson', 'mary.johnson@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'Mary', 'Johnson', true),
('550e8400-e29b-41d4-a716-446655440023', 'rbrown', 'robert.brown@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'Robert', 'Brown', true),
('550e8400-e29b-41d4-a716-446655440024', 'sdavis', 'sarah.davis@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'Sarah', 'Davis', true);

-- Insert additional users for comprehensive testing
INSERT INTO users (id, username, email, password_hash, first_name, last_name, is_active) VALUES
('550e8400-e29b-41d4-a716-446655440025', 'awilson', 'alex.wilson@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'Alex', 'Wilson', true),
('550e8400-e29b-41d4-a716-446655440026', 'lgarcia', 'lisa.garcia@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'Lisa', 'Garcia', true),
('550e8400-e29b-41d4-a716-446655440027', 'dlee', 'david.lee@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'David', 'Lee', true),
('550e8400-e29b-41d4-a716-446655440028', 'ktaylor', 'karen.taylor@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'Karen', 'Taylor', true),
('550e8400-e29b-41d4-a716-446655440029', 'mclark', 'mike.clark@techflow.com', '$2a$10$rN7VcU8vKbklfmNkdOjuR.kTvqL8yGQJI8z.FnMdXnXhFGtXCqxHy', 'Mike', 'Clark', true);

-- Assign user roles
INSERT INTO user_roles (user_id, role_id) VALUES
('550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440010'), -- admin -> admin role
('550e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440011'), -- jsmith -> manager
('550e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440013'), -- mjohnson -> sales
('550e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440014'), -- rbrown -> accountant
('550e8400-e29b-41d4-a716-446655440024', '550e8400-e29b-41d4-a716-446655440012'), -- sdavis -> employee
('550e8400-e29b-41d4-a716-446655440025', '550e8400-e29b-41d4-a716-446655440012'), -- awilson -> employee
('550e8400-e29b-41d4-a716-446655440026', '550e8400-e29b-41d4-a716-446655440011'), -- lgarcia -> manager
('550e8400-e29b-41d4-a716-446655440027', '550e8400-e29b-41d4-a716-446655440012'), -- dlee -> employee
('550e8400-e29b-41d4-a716-446655440028', '550e8400-e29b-41d4-a716-446655440014'), -- ktaylor -> accountant
('550e8400-e29b-41d4-a716-446655440029', '550e8400-e29b-41d4-a716-446655440013'); -- mclark -> sales

-- Insert Departments
INSERT INTO departments (id, company_id, name, description, manager_id) VALUES
('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440000', 'Sales', 'Sales and Customer Relations', '550e8400-e29b-41d4-a716-446655440022'),
('550e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440000', 'Finance', 'Accounting and Finance', '550e8400-e29b-41d4-a716-446655440023'),
('550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440000', 'Operations', 'Operations and Logistics', '550e8400-e29b-41d4-a716-446655440021');

-- Insert Warehouses
INSERT INTO warehouses (id, company_id, name, address, city, state, postal_code, country, is_active) VALUES
('550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440000', 'Main Warehouse', '1500 Storage Ave', 'Oakland', 'CA', '94601', 'USA', true),
('550e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440000', 'East Coast Distribution', '2000 Logistics Pkwy', 'Newark', 'NJ', '07102', 'USA', true);

-- Insert Product Categories
INSERT INTO product_categories (id, company_id, name, description) VALUES
('550e8400-e29b-41d4-a716-446655440050', '550e8400-e29b-41d4-a716-446655440000', 'Electronics', 'Electronic devices and components'),
('550e8400-e29b-41d4-a716-446655440051', '550e8400-e29b-41d4-a716-446655440000', 'Software', 'Software products and licenses'),
('550e8400-e29b-41d4-a716-446655440052', '550e8400-e29b-41d4-a716-446655440000', 'Accessories', 'Hardware accessories and peripherals'),
('550e8400-e29b-41d4-a716-446655440053', '550e8400-e29b-41d4-a716-446655440000', 'Services', 'Professional and support services');

-- Insert Products
INSERT INTO products (id, company_id, sku, name, description, category_id, unit_of_measure, unit_price, cost_price, weight, dimensions, is_active, track_inventory, minimum_stock, maximum_stock) VALUES
('550e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655440000', 'LAPTOP-001', 'TechFlow Pro Laptop', 'High-performance business laptop with 16GB RAM and 512GB SSD', '550e8400-e29b-41d4-a716-446655440050', 'each', 1299.99, 950.00, 2.1, '35.7 x 24.7 x 1.9 cm', true, true, 5, 50),
('550e8400-e29b-41d4-a716-446655440061', '550e8400-e29b-41d4-a716-446655440000', 'MOUSE-001', 'Wireless Precision Mouse', 'Ergonomic wireless mouse with precision tracking', '550e8400-e29b-41d4-a716-446655440052', 'each', 49.99, 25.00, 0.15, '12.5 x 7.8 x 4.2 cm', true, true, 20, 200),
('550e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440000', 'KB-001', 'Mechanical Keyboard', 'Professional mechanical keyboard with backlight', '550e8400-e29b-41d4-a716-446655440052', 'each', 129.99, 75.00, 1.2, '44 x 16 x 3.5 cm', true, true, 10, 100),
('550e8400-e29b-41d4-a716-446655440063', '550e8400-e29b-41d4-a716-446655440000', 'SW-OFFICE', 'Office Suite License', 'Annual license for office productivity suite', '550e8400-e29b-41d4-a716-446655440051', 'license', 199.99, 50.00, 0, 'Digital', true, false, 0, null),
('550e8400-e29b-41d4-a716-446655440064', '550e8400-e29b-41d4-a716-446655440000', 'MONITOR-001', '27" 4K Monitor', 'Professional 27-inch 4K display with USB-C connectivity', '550e8400-e29b-41d4-a716-446655440050', 'each', 449.99, 320.00, 6.8, '61.4 x 36.6 x 5.5 cm', true, true, 3, 30),
('550e8400-e29b-41d4-a716-446655440065', '550e8400-e29b-41d4-a716-446655440000', 'SUPPORT-HR', 'Technical Support (Hourly)', 'Professional technical support services', '550e8400-e29b-41d4-a716-446655440053', 'hour', 125.00, 75.00, 0, 'Service', true, false, 0, null);

-- Insert Inventory Levels
INSERT INTO inventory (id, warehouse_id, product_id, quantity_on_hand, quantity_reserved, last_updated) VALUES
('550e8400-e29b-41d4-a716-446655440070', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440060', 25, 5, CURRENT_TIMESTAMP), -- Laptops in Main Warehouse
('550e8400-e29b-41d4-a716-446655440071', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440061', 150, 20, CURRENT_TIMESTAMP), -- Mice in Main Warehouse
('550e8400-e29b-41d4-a716-446655440072', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440062', 45, 5, CURRENT_TIMESTAMP), -- Keyboards in Main Warehouse
('550e8400-e29b-41d4-a716-446655440073', '550e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440064', 12, 2, CURRENT_TIMESTAMP), -- Monitors in East Coast
('550e8400-e29b-41d4-a716-446655440074', '550e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440061', 80, 10, CURRENT_TIMESTAMP); -- Mice in East Coast

-- Insert Customers
INSERT INTO customers (id, company_id, customer_code, name, email, phone, tax_id, billing_address, shipping_address, city, state, postal_code, country, credit_limit, payment_terms, is_active) VALUES
('550e8400-e29b-41d4-a716-446655440080', '550e8400-e29b-41d4-a716-446655440000', 'CUST-001', 'Acme Corporation', 'procurement@acme.com', '+1-555-1000', 'TAX123456', '100 Business Park Dr', '100 Business Park Dr', 'Austin', 'TX', '78701', 'USA', 50000.00, 30, true),
('550e8400-e29b-41d4-a716-446655440081', '550e8400-e29b-41d4-a716-446655440000', 'CUST-002', 'TechStart Ltd', 'orders@techstart.io', '+1-555-2000', 'TAX789012', '200 Innovation Way', '200 Innovation Way', 'Seattle', 'WA', '98101', 'USA', 25000.00, 15, true),
('550e8400-e29b-41d4-a716-446655440082', '550e8400-e29b-41d4-a716-446655440000', 'CUST-003', 'Global Solutions Inc', 'purchasing@globalsol.com', '+1-555-3000', 'TAX345678', '300 Enterprise Blvd', '300 Enterprise Blvd', 'New York', 'NY', '10001', 'USA', 75000.00, 45, true),
('550e8400-e29b-41d4-a716-446655440083', '550e8400-e29b-41d4-a716-446655440000', 'CUST-004', 'Innovation Hub', 'supplies@innohub.com', '+1-555-4000', 'TAX901234', '400 Research Circle', '400 Research Circle', 'Boston', 'MA', '02101', 'USA', 30000.00, 30, true),
('550e8400-e29b-41d4-a716-446655440084', '550e8400-e29b-41d4-a716-446655440000', 'CUST-005', 'Digital Dynamics', 'procurement@digitaldyn.com', '+1-555-5000', 'TAX567890', '500 Tech Plaza', '500 Tech Plaza', 'Denver', 'CO', '80201', 'USA', 40000.00, 30, true);

-- Insert Suppliers
INSERT INTO suppliers (id, company_id, supplier_code, name, email, phone, tax_id, address, city, state, postal_code, country, payment_terms, is_active) VALUES
('550e8400-e29b-41d4-a716-446655440090', '550e8400-e29b-41d4-a716-446655440000', 'SUPP-001', 'ComputerTech Wholesale', 'orders@computertech.com', '+1-555-6000', 'SUP123456', '1000 Distribution Center Dr', 'Los Angeles', 'CA', '90001', 'USA', 30, true),
('550e8400-e29b-41d4-a716-446655440091', '550e8400-e29b-41d4-a716-446655440000', 'SUPP-002', 'Electronics Supply Co', 'sales@electronicsupply.com', '+1-555-7000', 'SUP789012', '2000 Industrial Way', 'Phoenix', 'AZ', '85001', 'USA', 45, true),
('550e8400-e29b-41d4-a716-446655440092', '550e8400-e29b-41d4-a716-446655440000', 'SUPP-003', 'Software Licensing Corp', 'licensing@swlicensing.com', '+1-555-8000', 'SUP345678', '3000 Software Park', 'Redmond', 'WA', '98052', 'USA', 15, true);

-- Insert Sales Orders
INSERT INTO sales_orders (id, company_id, order_number, customer_id, salesperson_id, order_date, required_date, promised_date, status, subtotal, tax_amount, shipping_amount, total_amount, notes) VALUES
('550e8400-e29b-41d4-a716-446655440100', '550e8400-e29b-41d4-a716-446655440000', 'SO-2024-001', '550e8400-e29b-41d4-a716-446655440080', '550e8400-e29b-41d4-a716-446655440022', '2024-01-15', '2024-02-01', '2024-01-30', 'confirmed', 2649.97, 212.00, 50.00, 2911.97, 'Bulk order for new office setup'),
('550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440000', 'SO-2024-002', '550e8400-e29b-41d4-a716-446655440081', '550e8400-e29b-41d4-a716-446655440022', '2024-01-18', '2024-02-15', '2024-02-10', 'processing', 1849.96, 147.00, 75.00, 2071.96, 'Startup equipment package'),
('550e8400-e29b-41d4-a716-446655440102', '550e8400-e29b-41d4-a716-446655440000', 'SO-2024-003', '550e8400-e29b-41d4-a716-446655440082', '550e8400-e29b-41d4-a716-446655440022', '2024-01-20', '2024-02-05', '2024-02-03', 'shipped', 3899.94, 312.00, 100.00, 4311.94, 'Corporate expansion order'),
('550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440000', 'SO-2024-004', '550e8400-e29b-41d4-a716-446655440083', '550e8400-e29b-41d4-a716-446655440022', '2024-01-22', '2024-02-20', null, 'draft', 999.98, 80.00, 25.00, 1104.98, 'Research lab equipment');

-- Insert Sales Order Line Items
INSERT INTO sales_order_items (id, sales_order_id, product_id, quantity, unit_price) VALUES
-- SO-2024-001 items
('550e8400-e29b-41d4-a716-446655440110', '550e8400-e29b-41d4-a716-446655440100', '550e8400-e29b-41d4-a716-446655440060', 2, 1299.99),
('550e8400-e29b-41d4-a716-446655440111', '550e8400-e29b-41d4-a716-446655440100', '550e8400-e29b-41d4-a716-446655440061', 1, 49.99),
-- SO-2024-002 items
('550e8400-e29b-41d4-a716-446655440112', '550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440060', 1, 1299.99),
('550e8400-e29b-41d4-a716-446655440113', '550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440062', 2, 129.99),
('550e8400-e29b-41d4-a716-446655440114', '550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440061', 6, 49.99),
-- SO-2024-003 items
('550e8400-e29b-41d4-a716-446655440115', '550e8400-e29b-41d4-a716-446655440102', '550e8400-e29b-41d4-a716-446655440060', 3, 1299.99),
-- SO-2024-004 items
('550e8400-e29b-41d4-a716-446655440116', '550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440064', 2, 449.99),
('550e8400-e29b-41d4-a716-446655440117', '550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440061', 2, 49.99);

-- Insert Invoices
INSERT INTO invoices (id, company_id, invoice_number, customer_id, sales_order_id, invoice_date, due_date, status, subtotal, tax_amount, total_amount, paid_amount, notes) VALUES
('550e8400-e29b-41d4-a716-446655440120', '550e8400-e29b-41d4-a716-446655440000', 'INV-2024-001', '550e8400-e29b-41d4-a716-446655440080', '550e8400-e29b-41d4-a716-446655440100', '2024-01-30', '2024-03-01', 'paid', 2649.97, 212.00, 2861.97, 2861.97, 'Paid in full'),
('550e8400-e29b-41d4-a716-446655440121', '550e8400-e29b-41d4-a716-446655440000', 'INV-2024-002', '550e8400-e29b-41d4-a716-446655440081', '550e8400-e29b-41d4-a716-446655440101', '2024-02-10', '2024-02-25', 'partial', 1849.96, 147.00, 1996.96, 1000.00, 'Partial payment received'),
('550e8400-e29b-41d4-a716-446655440122', '550e8400-e29b-41d4-a716-446655440000', 'INV-2024-003', '550e8400-e29b-41d4-a716-446655440082', '550e8400-e29b-41d4-a716-446655440102', '2024-02-03', '2024-03-20', 'sent', 3899.97, 312.00, 4211.97, 0.00, 'Invoice sent to customer'),
('550e8400-e29b-41d4-a716-446655440123', '550e8400-e29b-41d4-a716-446655440000', 'INV-2024-004', '550e8400-e29b-41d4-a716-446655440083', null, '2024-01-10', '2024-01-25', 'overdue', 625.00, 50.00, 675.00, 0.00, 'Support services - overdue payment');

-- Insert Invoice Line Items
INSERT INTO invoice_items (id, invoice_id, product_id, quantity, unit_price, description) VALUES
-- INV-2024-001 items (matches SO-2024-001)
('550e8400-e29b-41d4-a716-446655440130', '550e8400-e29b-41d4-a716-446655440120', '550e8400-e29b-41d4-a716-446655440060', 2, 1299.99, 'TechFlow Pro Laptop'),
('550e8400-e29b-41d4-a716-446655440131', '550e8400-e29b-41d4-a716-446655440120', '550e8400-e29b-41d4-a716-446655440061', 1, 49.99, 'Wireless Precision Mouse'),
-- INV-2024-002 items (matches SO-2024-002)
('550e8400-e29b-41d4-a716-446655440132', '550e8400-e29b-41d4-a716-446655440121', '550e8400-e29b-41d4-a716-446655440060', 1, 1299.99, 'Developer Laptop'),
('550e8400-e29b-41d4-a716-446655440133', '550e8400-e29b-41d4-a716-446655440121', '550e8400-e29b-41d4-a716-446655440062', 2, 129.99, 'Mechanical Keyboards'),
('550e8400-e29b-41d4-a716-446655440134', '550e8400-e29b-41d4-a716-446655440121', '550e8400-e29b-41d4-a716-446655440061', 6, 49.99, 'Team Mice'),
-- INV-2024-003 items (matches SO-2024-003)
('550e8400-e29b-41d4-a716-446655440135', '550e8400-e29b-41d4-a716-446655440122', '550e8400-e29b-41d4-a716-446655440060', 3, 1299.99, 'Corporate Laptops'),
-- INV-2024-004 items (service invoice)
('550e8400-e29b-41d4-a716-446655440136', '550e8400-e29b-41d4-a716-446655440123', '550e8400-e29b-41d4-a716-446655440065', 5, 125.00, 'Technical Support Services');

-- Insert Stock Movements (sample inventory transactions)
INSERT INTO stock_movements (id, warehouse_id, product_id, movement_type, quantity, reference_number, notes, moved_at, created_by) VALUES
('550e8400-e29b-41d4-a716-446655440140', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440060', 'receipt', 30, 'PO-2024-001', 'Initial stock receipt', '2024-01-01', '550e8400-e29b-41d4-a716-446655440020'),
('550e8400-e29b-41d4-a716-446655440141', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440061', 'receipt', 200, 'PO-2024-002', 'Mouse inventory replenishment', '2024-01-02', '550e8400-e29b-41d4-a716-446655440020'),
('550e8400-e29b-41d4-a716-446655440142', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440060', 'shipment', -2, 'SO-2024-001', 'Shipped to Acme Corporation', '2024-01-30', '550e8400-e29b-41d4-a716-446655440022'),
('550e8400-e29b-41d4-a716-446655440143', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440061', 'shipment', -1, 'SO-2024-001', 'Shipped to Acme Corporation', '2024-01-30', '550e8400-e29b-41d4-a716-446655440022'),
('550e8400-e29b-41d4-a716-446655440144', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440062', 'receipt', 50, 'PO-2024-003', 'Keyboard stock receipt', '2024-01-15', '550e8400-e29b-41d4-a716-446655440020'),
('550e8400-e29b-41d4-a716-446655440145', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440060', 'shipment', -3, 'SO-2024-003', 'Shipped to Global Solutions', '2024-02-03', '550e8400-e29b-41d4-a716-446655440022');

-- ==============================================
-- COMPREHENSIVE SAMPLE DATA FOR NEW ERP MODULES
-- ==============================================

-- Currencies and Localization
INSERT INTO currencies (id, code, name, symbol, decimal_places, is_active) VALUES
('550e8400-e29b-41d4-a716-446655441000', 'USD', 'US Dollar', '$', 2, true),
('550e8400-e29b-41d4-a716-446655441001', 'EUR', 'Euro', '€', 2, true),
('550e8400-e29b-41d4-a716-446655441002', 'GBP', 'British Pound', '£', 2, true),
('550e8400-e29b-41d4-a716-446655441003', 'CAD', 'Canadian Dollar', 'C$', 2, true);

INSERT INTO locales (id, code, name, language, country, date_format, time_format, number_format, is_active) VALUES
('550e8400-e29b-41d4-a716-446655441010', 'en_US', 'English (United States)', 'English', 'United States', 'MM/dd/yyyy', '12-hour', '1,234.56', true),
('550e8400-e29b-41d4-a716-446655441011', 'en_GB', 'English (United Kingdom)', 'English', 'United Kingdom', 'dd/MM/yyyy', '24-hour', '1,234.56', true),
('550e8400-e29b-41d4-a716-446655441012', 'fr_FR', 'French (France)', 'French', 'France', 'dd/MM/yyyy', '24-hour', '1 234,56', true),
('550e8400-e29b-41d4-a716-446655441013', 'de_DE', 'German (Germany)', 'German', 'Germany', 'dd.MM.yyyy', '24-hour', '1.234,56', true);

INSERT INTO company_currencies (id, company_id, currency_id, is_base_currency, is_active) VALUES
('550e8400-e29b-41d4-a716-446655441020', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655441000', true, true),
('550e8400-e29b-41d4-a716-446655441021', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655441001', false, true);

INSERT INTO exchange_rates (id, from_currency_id, to_currency_id, rate, effective_date, source) VALUES
('550e8400-e29b-41d4-a716-446655441030', '550e8400-e29b-41d4-a716-446655441000', '550e8400-e29b-41d4-a716-446655441001', 0.85, '2024-01-01', 'Bank Rate'),
('550e8400-e29b-41d4-a716-446655441031', '550e8400-e29b-41d4-a716-446655441001', '550e8400-e29b-41d4-a716-446655441000', 1.18, '2024-01-01', 'Bank Rate'),
('550e8400-e29b-41d4-a716-446655441032', '550e8400-e29b-41d4-a716-446655441000', '550e8400-e29b-41d4-a716-446655441002', 0.79, '2024-01-01', 'Bank Rate');

-- Chart of Accounts
INSERT INTO accounts (id, company_id, account_number, name, account_type, is_active) VALUES
('550e8400-e29b-41d4-a716-446655441100', '550e8400-e29b-41d4-a716-446655440000', '1000', 'Cash', 'asset', true),
('550e8400-e29b-41d4-a716-446655441101', '550e8400-e29b-41d4-a716-446655440000', '1200', 'Accounts Receivable', 'asset', true),
('550e8400-e29b-41d4-a716-446655441102', '550e8400-e29b-41d4-a716-446655440000', '1500', 'Inventory', 'asset', true),
('550e8400-e29b-41d4-a716-446655441103', '550e8400-e29b-41d4-a716-446655440000', '1700', 'Equipment', 'asset', true),
('550e8400-e29b-41d4-a716-446655441104', '550e8400-e29b-41d4-a716-446655440000', '2000', 'Accounts Payable', 'liability', true),
('550e8400-e29b-41d4-a716-446655441105', '550e8400-e29b-41d4-a716-446655440000', '3000', 'Owner Equity', 'equity', true),
('550e8400-e29b-41d4-a716-446655441106', '550e8400-e29b-41d4-a716-446655440000', '4000', 'Sales Revenue', 'revenue', true),
('550e8400-e29b-41d4-a716-446655441107', '550e8400-e29b-41d4-a716-446655440000', '5000', 'Cost of Goods Sold', 'expense', true),
('550e8400-e29b-41d4-a716-446655441108', '550e8400-e29b-41d4-a716-446655440000', '6000', 'Operating Expenses', 'expense', true),
('550e8400-e29b-41d4-a716-446655441109', '550e8400-e29b-41d4-a716-446655440000', '6100', 'Salaries Expense', 'expense', true);

-- Journal Entries
INSERT INTO journal_entries (id, company_id, entry_number, entry_date, description, reference, total_debit, total_credit, created_by) VALUES
('550e8400-e29b-41d4-a716-446655441200', '550e8400-e29b-41d4-a716-446655440000', 'JE-2024-001', '2024-01-01', 'Opening balance', 'OPENING', 100000.00, 100000.00, '550e8400-e29b-41d4-a716-446655440020'),
('550e8400-e29b-41d4-a716-446655441201', '550e8400-e29b-41d4-a716-446655440000', 'JE-2024-002', '2024-01-30', 'Sales invoice posting', 'INV-2024-001', 2861.97, 2861.97, '550e8400-e29b-41d4-a716-446655440023');

INSERT INTO journal_entry_lines (id, journal_entry_id, account_id, description, debit_amount, credit_amount) VALUES
('550e8400-e29b-41d4-a716-446655441210', '550e8400-e29b-41d4-a716-446655441200', '550e8400-e29b-41d4-a716-446655441100', 'Opening cash balance', 50000.00, 0.00),
('550e8400-e29b-41d4-a716-446655441211', '550e8400-e29b-41d4-a716-446655441200', '550e8400-e29b-41d4-a716-446655441102', 'Opening inventory', 30000.00, 0.00),
('550e8400-e29b-41d4-a716-446655441212', '550e8400-e29b-41d4-a716-446655441200', '550e8400-e29b-41d4-a716-446655441103', 'Equipment', 20000.00, 0.00),
('550e8400-e29b-41d4-a716-446655441213', '550e8400-e29b-41d4-a716-446655441200', '550e8400-e29b-41d4-a716-446655441105', 'Owner equity', 0.00, 100000.00),
('550e8400-e29b-41d4-a716-446655441214', '550e8400-e29b-41d4-a716-446655441201', '550e8400-e29b-41d4-a716-446655441101', 'A/R - Acme Corp', 2861.97, 0.00),
('550e8400-e29b-41d4-a716-446655441215', '550e8400-e29b-41d4-a716-446655441201', '550e8400-e29b-41d4-a716-446655441106', 'Sales revenue', 0.00, 2649.97),
('550e8400-e29b-41d4-a716-446655441216', '550e8400-e29b-41d4-a716-446655441201', '550e8400-e29b-41d4-a716-446655441104', 'Sales tax payable', 0.00, 212.00);

-- Employee Data
INSERT INTO employees (id, company_id, user_id, employee_number, department_id, job_title, hire_date, salary, hourly_rate, employment_type, manager_id, work_location, phone, emergency_contact_name, emergency_contact_phone, is_active) VALUES
('550e8400-e29b-41d4-a716-446655441300', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440021', 'EMP-001', '550e8400-e29b-41d4-a716-446655440032', 'Operations Manager', '2023-01-15', 95000.00, null, 'full_time', null, 'San Francisco HQ', '+1-555-0100', 'Jane Smith', '+1-555-0101', true),
('550e8400-e29b-41d4-a716-446655441301', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440022', 'EMP-002', '550e8400-e29b-41d4-a716-446655440030', 'Sales Manager', '2023-02-01', 85000.00, null, 'full_time', null, 'San Francisco HQ', '+1-555-0102', 'Tom Johnson', '+1-555-0103', true),
('550e8400-e29b-41d4-a716-446655441302', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440023', 'EMP-003', '550e8400-e29b-41d4-a716-446655440031', 'Finance Manager', '2023-03-01', 90000.00, null, 'full_time', null, 'San Francisco HQ', '+1-555-0104', 'Linda Brown', '+1-555-0105', true),
('550e8400-e29b-41d4-a716-446655441303', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440024', 'EMP-004', '550e8400-e29b-41d4-a716-446655440032', 'Operations Specialist', '2023-04-15', 65000.00, null, 'full_time', '550e8400-e29b-41d4-a716-446655441300', 'San Francisco HQ', '+1-555-0106', 'Steve Davis', '+1-555-0107', true),
('550e8400-e29b-41d4-a716-446655441304', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440025', 'EMP-005', '550e8400-e29b-41d4-a716-446655440032', 'Warehouse Associate', '2023-05-01', null, 22.50, 'full_time', '550e8400-e29b-41d4-a716-446655441300', 'Oakland Warehouse', '+1-555-0108', 'Amy Wilson', '+1-555-0109', true),
('550e8400-e29b-41d4-a716-446655441305', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440026', 'EMP-006', '550e8400-e29b-41d4-a716-446655440030', 'Marketing Manager', '2023-06-01', 80000.00, null, 'full_time', '550e8400-e29b-41d4-a716-446655441301', 'San Francisco HQ', '+1-555-0110', 'Carlos Garcia', '+1-555-0111', true),
('550e8400-e29b-41d4-a716-446655441306', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440027', 'EMP-007', '550e8400-e29b-41d4-a716-446655440032', 'IT Specialist', '2023-07-01', 75000.00, null, 'full_time', '550e8400-e29b-41d4-a716-446655441300', 'San Francisco HQ', '+1-555-0112', 'Helen Lee', '+1-555-0113', true),
('550e8400-e29b-41d4-a716-446655441307', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440028', 'EMP-008', '550e8400-e29b-41d4-a716-446655440031', 'Accountant', '2023-08-01', 68000.00, null, 'full_time', '550e8400-e29b-41d4-a716-446655441302', 'San Francisco HQ', '+1-555-0114', 'Bob Taylor', '+1-555-0115', true),
('550e8400-e29b-41d4-a716-446655441308', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440029', 'EMP-009', '550e8400-e29b-41d4-a716-446655440030', 'Sales Representative', '2023-09-01', 55000.00, null, 'full_time', '550e8400-e29b-41d4-a716-446655441301', 'San Francisco HQ', '+1-555-0116', 'Nancy Clark', '+1-555-0117', true);

-- CRM Data - Lead Sources
INSERT INTO lead_sources (id, company_id, name, description, is_active) VALUES
('550e8400-e29b-41d4-a716-446655441400', '550e8400-e29b-41d4-a716-446655440000', 'Website', 'Company website inquiries', true),
('550e8400-e29b-41d4-a716-446655441401', '550e8400-e29b-41d4-a716-446655440000', 'Trade Show', 'Technology trade shows and conferences', true),
('550e8400-e29b-41d4-a716-446655441402', '550e8400-e29b-41d4-a716-446655440000', 'Referral', 'Customer and partner referrals', true),
('550e8400-e29b-41d4-a716-446655441403', '550e8400-e29b-41d4-a716-446655440000', 'Cold Outreach', 'Cold calling and email campaigns', true),
('550e8400-e29b-41d4-a716-446655441404', '550e8400-e29b-41d4-a716-446655440000', 'Social Media', 'LinkedIn and social media platforms', true);

-- Lead Data
INSERT INTO leads (id, company_id, lead_number, first_name, last_name, company_name, title, email, phone, mobile, website, address, city, state, postal_code, country, lead_source_id, status, rating, assigned_to, estimated_value, notes) VALUES
('550e8400-e29b-41d4-a716-446655441500', '550e8400-e29b-41d4-a716-446655440000', 'LEAD-001', 'Jennifer', 'Wong', 'DataCorp Solutions', 'IT Director', 'j.wong@datacorp.com', '+1-555-2001', '+1-555-2002', 'https://datacorp.com', '789 Data Street', 'Palo Alto', 'CA', '94301', 'USA', '550e8400-e29b-41d4-a716-446655441400', 'qualified', 'hot', '550e8400-e29b-41d4-a716-446655441308', 25000.00, 'Interested in bulk laptop purchase for Q2'),
('550e8400-e29b-41d4-a716-446655441501', '550e8400-e29b-41d4-a716-446655440000', 'LEAD-002', 'Michael', 'Chen', 'StartupTech Inc', 'CEO', 'm.chen@startuptech.io', '+1-555-2003', '+1-555-2004', 'https://startuptech.io', '456 Innovation Ave', 'Mountain View', 'CA', '94041', 'USA', '550e8400-e29b-41d4-a716-446655441401', 'contacted', 'warm', '550e8400-e29b-41d4-a716-446655441308', 15000.00, 'Met at TechCrunch conference, follow up needed'),
('550e8400-e29b-41d4-a716-446655441502', '550e8400-e29b-41d4-a716-446655440000', 'LEAD-003', 'Sarah', 'Anderson', 'CloudFirst Ltd', 'CTO', 's.anderson@cloudfirst.com', '+1-555-2005', null, 'https://cloudfirst.com', '123 Cloud Plaza', 'San Jose', 'CA', '95110', 'USA', '550e8400-e29b-41d4-a716-446655441402', 'new', 'cold', '550e8400-e29b-41d4-a716-446655441301', 8000.00, 'Referral from existing customer'),
('550e8400-e29b-41d4-a716-446655441503', '550e8400-e29b-41d4-a716-446655440000', 'LEAD-004', 'Robert', 'Kim', 'DevOps Masters', 'DevOps Lead', 'r.kim@devopsmasters.com', '+1-555-2007', '+1-555-2008', null, '890 DevOps Way', 'Fremont', 'CA', '94536', 'USA', '550e8400-e29b-41d4-a716-446655441404', 'qualified', 'warm', '550e8400-e29b-41d4-a716-446655441308', 12000.00, 'Looking for monitoring solutions');

-- Opportunities Data
INSERT INTO opportunities (id, company_id, opportunity_number, name, customer_id, lead_id, assigned_to, stage, probability, amount, expected_close_date, lead_source_id, competitor, next_step, description, is_active) VALUES
('550e8400-e29b-41d4-a716-446655441600', '550e8400-e29b-41d4-a716-446655440000', 'OPP-001', 'Acme Corp Expansion', '550e8400-e29b-41d4-a716-446655440080', null, '550e8400-e29b-41d4-a716-446655441301', 'proposal', 75.00, 45000.00, '2024-03-15', '550e8400-e29b-41d4-a716-446655441402', 'CompTech Solutions', 'Send formal proposal', 'Office expansion requiring 30 additional workstations', true),
('550e8400-e29b-41d4-a716-446655441601', '550e8400-e29b-41d4-a716-446655440000', 'OPP-002', 'TechStart Development Lab', '550e8400-e29b-41d4-a716-446655440081', null, '550e8400-e29b-41d4-a716-446655441308', 'negotiation', 85.00, 32000.00, '2024-02-28', '550e8400-e29b-41d4-a716-446655441400', null, 'Finalize pricing and terms', 'Development environment setup for new team', true),
('550e8400-e29b-41d4-a716-446655441602', '550e8400-e29b-41d4-a716-446655440000', 'OPP-003', 'DataCorp Q2 Refresh', null, '550e8400-e29b-41d4-a716-446655441500', '550e8400-e29b-41d4-a716-446655441308', 'qualification', 60.00, 25000.00, '2024-04-30', '550e8400-e29b-41d4-a716-446655441400', 'Dell Technologies', 'Schedule technical demo', 'Quarterly hardware refresh program', true),
('550e8400-e29b-41d4-a716-446655441603', '550e8400-e29b-41d4-a716-446655440000', 'OPP-004', 'Innovation Hub Pilot', '550e8400-e29b-41d4-a716-446655440083', null, '550e8400-e29b-41d4-a716-446655441301', 'prospecting', 40.00, 18000.00, '2024-05-15', '550e8400-e29b-41d4-a716-446655441401', 'HP Enterprise', 'Initial needs assessment meeting', 'Pilot program for research lab equipment', true);

-- Opportunity Products
INSERT INTO opportunity_products (id, opportunity_id, product_id, quantity, unit_price, discount_percent) VALUES
('550e8400-e29b-41d4-a716-446655441700', '550e8400-e29b-41d4-a716-446655441600', '550e8400-e29b-41d4-a716-446655440060', 30, 1200.00, 5.00),
('550e8400-e29b-41d4-a716-446655441701', '550e8400-e29b-41d4-a716-446655441600', '550e8400-e29b-41d4-a716-446655440064', 15, 450.00, 0.00),
('550e8400-e29b-41d4-a716-446655441702', '550e8400-e29b-41d4-a716-446655441601', '550e8400-e29b-41d4-a716-446655440060', 20, 1200.00, 10.00),
('550e8400-e29b-41d4-a716-446655441703', '550e8400-e29b-41d4-a716-446655441601', '550e8400-e29b-41d4-a716-446655440062', 25, 800.00, 0.00);

-- Marketing Campaigns
INSERT INTO campaigns (id, company_id, name, campaign_type, status, start_date, end_date, budget, actual_cost, target_audience, description, expected_response_rate, actual_response_rate, expected_revenue, actual_revenue, owner_id) VALUES
('550e8400-e29b-41d4-a716-446655441800', '550e8400-e29b-41d4-a716-446655440000', 'Q1 2024 Product Launch', 'email', 'completed', '2024-01-01', '2024-01-31', 5000.00, 4750.00, 'Technology decision makers', 'Launch campaign for new laptop line', 3.50, 4.20, 75000.00, 78000.00, '550e8400-e29b-41d4-a716-446655441301'),
('550e8400-e29b-41d4-a716-446655441801', '550e8400-e29b-41d4-a716-446655440000', 'Spring Trade Show Circuit', 'trade_show', 'active', '2024-03-01', '2024-05-31', 25000.00, 15000.00, 'Enterprise IT professionals', 'Presence at major technology trade shows', 5.00, null, 150000.00, 0.00, '550e8400-e29b-41d4-a716-446655441308'),
('550e8400-e29b-41d4-a716-446655441802', '550e8400-e29b-41d4-a716-446655440000', 'LinkedIn Lead Generation', 'social_media', 'active', '2024-02-01', '2024-04-30', 8000.00, 3200.00, 'IT managers and CTOs', 'Targeted LinkedIn advertising campaign', 2.80, 3.10, 40000.00, 42000.00, '550e8400-e29b-41d4-a716-446655441301'),
('550e8400-e29b-41d4-a716-446655441803', '550e8400-e29b-41d4-a716-446655440000', 'Customer Referral Program', 'other', 'planning', '2024-04-01', '2024-12-31', 12000.00, 0.00, 'Existing customers', 'Incentive program for customer referrals', 8.00, null, 80000.00, 0.00, '550e8400-e29b-41d4-a716-446655441308');

-- Campaign Members
INSERT INTO campaign_members (id, campaign_id, lead_id, customer_id, status, response_date, notes) VALUES
('550e8400-e29b-41d4-a716-446655441900', '550e8400-e29b-41d4-a716-446655441800', '550e8400-e29b-41d4-a716-446655441500', null, 'responded', '2024-01-15', 'Requested product demo'),
('550e8400-e29b-41d4-a716-446655441901', '550e8400-e29b-41d4-a716-446655441800', '550e8400-e29b-41d4-a716-446655441501', null, 'clicked', '2024-01-10', 'Visited pricing page'),
('550e8400-e29b-41d4-a716-446655441902', '550e8400-e29b-41d4-a716-446655441800', null, '550e8400-e29b-41d4-a716-446655440080', 'opened', '2024-01-08', 'Existing customer engagement'),
('550e8400-e29b-41d4-a716-446655441903', '550e8400-e29b-41d4-a716-446655441802', '550e8400-e29b-41d4-a716-446655441502', null, 'clicked', '2024-02-20', 'LinkedIn ad engagement'),
('550e8400-e29b-41d4-a716-446655441904', '550e8400-e29b-41d4-a716-446655441802', '550e8400-e29b-41d4-a716-446655441503', null, 'responded', '2024-02-25', 'Inquired about enterprise solutions');

-- Sales Territories
INSERT INTO territories (id, company_id, name, description, manager_id, is_active) VALUES
('550e8400-e29b-41d4-a716-446655442000', '550e8400-e29b-41d4-a716-446655440000', 'West Coast', 'California, Oregon, Washington', '550e8400-e29b-41d4-a716-446655441301', true),
('550e8400-e29b-41d4-a716-446655442001', '550e8400-e29b-41d4-a716-446655440000', 'East Coast', 'New York, Massachusetts, Connecticut', '550e8400-e29b-41d4-a716-446655441301', true),
('550e8400-e29b-41d4-a716-446655442002', '550e8400-e29b-41d4-a716-446655440000', 'Central', 'Texas, Colorado, Illinois', '550e8400-e29b-41d4-a716-446655441301', true);

INSERT INTO territory_assignments (territory_id, salesperson_id, start_date, is_active) VALUES
('550e8400-e29b-41d4-a716-446655442000', '550e8400-e29b-41d4-a716-446655441308', '2023-09-01', true),
('550e8400-e29b-41d4-a716-446655442001', '550e8400-e29b-41d4-a716-446655441301', '2023-02-01', true);

INSERT INTO customer_territories (customer_id, territory_id, assigned_date) VALUES
('550e8400-e29b-41d4-a716-446655440080', '550e8400-e29b-41d4-a716-446655442002', '2024-01-01'),
('550e8400-e29b-41d4-a716-446655440081', '550e8400-e29b-41d4-a716-446655442000', '2024-01-01'),
('550e8400-e29b-41d4-a716-446655440082', '550e8400-e29b-41d4-a716-446655442001', '2024-01-01');

-- Customer Contacts
INSERT INTO customer_contacts (id, customer_id, first_name, last_name, title, email, phone, mobile, is_primary, is_active) VALUES
('550e8400-e29b-41d4-a716-446655442100', '550e8400-e29b-41d4-a716-446655440080', 'James', 'Wilson', 'Procurement Manager', 'j.wilson@acme.com', '+1-555-1001', '+1-555-1002', true, true),
('550e8400-e29b-41d4-a716-446655442101', '550e8400-e29b-41d4-a716-446655440080', 'Emma', 'Davis', 'IT Coordinator', 'e.davis@acme.com', '+1-555-1003', null, false, true),
('550e8400-e29b-41d4-a716-446655442102', '550e8400-e29b-41d4-a716-446655440081', 'Ryan', 'Martinez', 'Office Manager', 'r.martinez@techstart.io', '+1-555-2010', '+1-555-2011', true, true),
('550e8400-e29b-41d4-a716-446655442103', '550e8400-e29b-41d4-a716-446655440082', 'Amanda', 'Thompson', 'VP Technology', 'a.thompson@globalsol.com', '+1-555-3001', '+1-555-3002', true, true);

-- Activities (Sales Activities)
INSERT INTO activities (id, company_id, subject, activity_type, description, status, priority, assigned_to, related_to_type, related_to_id, start_date, end_date, duration_minutes, location, created_by) VALUES
('550e8400-e29b-41d4-a716-446655442200', '550e8400-e29b-41d4-a716-446655440000', 'Follow-up call with DataCorp', 'call', 'Discuss technical requirements for Q2 refresh', 'completed', 'high', '550e8400-e29b-41d4-a716-446655441308', 'lead', '550e8400-e29b-41d4-a716-446655441500', '2024-01-25 10:00:00', '2024-01-25 10:30:00', 30, 'Phone', '550e8400-e29b-41d4-a716-446655440022'),
('550e8400-e29b-41d4-a716-446655442201', '550e8400-e29b-41d4-a716-446655440000', 'Proposal presentation for Acme', 'meeting', 'Present expansion proposal to procurement team', 'planned', 'high', '550e8400-e29b-41d4-a716-446655441301', 'opportunity', '550e8400-e29b-41d4-a716-446655441600', '2024-03-05 14:00:00', '2024-03-05 15:30:00', 90, 'Acme Corp Office', '550e8400-e29b-41d4-a716-446655440021'),
('550e8400-e29b-41d4-a716-446655442202', '550e8400-e29b-41d4-a716-446655440000', 'Send pricing information', 'email', 'Email detailed pricing for development lab setup', 'completed', 'normal', '550e8400-e29b-41d4-a716-446655441308', 'opportunity', '550e8400-e29b-41d4-a716-446655441601', '2024-02-10 09:00:00', null, null, 'Email', '550e8400-e29b-41d4-a716-446655440022'),
('550e8400-e29b-41d4-a716-446655442203', '550e8400-e29b-41d4-a716-446655440000', 'Product demo for Innovation Hub', 'meeting', 'Demonstrate laptop and monitor capabilities', 'planned', 'normal', '550e8400-e29b-41d4-a716-446655441301', 'opportunity', '550e8400-e29b-41d4-a716-446655441603', '2024-04-15 11:00:00', '2024-04-15 12:00:00', 60, 'Innovation Hub Office', '550e8400-e29b-41d4-a716-446655440021');

-- HR Management Sample Data

-- Job Positions
INSERT INTO job_positions (id, company_id, title, description, department_id, salary_min, salary_max, required_skills, is_active) VALUES
('550e8400-e29b-41d4-a716-446655442300', '550e8400-e29b-41d4-a716-446655440000', 'Operations Manager', 'Oversee daily operations and logistics', '550e8400-e29b-41d4-a716-446655440032', 85000.00, 110000.00, '{"leadership", "logistics", "project_management"}', true),
('550e8400-e29b-41d4-a716-446655442301', '550e8400-e29b-41d4-a716-446655440000', 'Sales Representative', 'Drive sales growth and customer relationships', '550e8400-e29b-41d4-a716-446655440030', 45000.00, 75000.00, '{"sales", "communication", "crm"}', true),
('550e8400-e29b-41d4-a716-446655442302', '550e8400-e29b-41d4-a716-446655440000', 'Accountant', 'Manage financial records and reporting', '550e8400-e29b-41d4-a716-446655440031', 55000.00, 80000.00, '{"accounting", "excel", "gaap"}', true),
('550e8400-e29b-41d4-a716-446655442303', '550e8400-e29b-41d4-a716-446655440000', 'Warehouse Associate', 'Handle inventory and shipping operations', '550e8400-e29b-41d4-a716-446655440032', 35000.00, 50000.00, '{"inventory", "forklift", "safety"}', true);

-- Benefit Types
INSERT INTO benefit_types (id, company_id, name, description, category, is_active) VALUES
('550e8400-e29b-41d4-a716-446655442400', '550e8400-e29b-41d4-a716-446655440000', 'Health Insurance Premium', 'Medical insurance coverage', 'health', true),
('550e8400-e29b-41d4-a716-446655442401', '550e8400-e29b-41d4-a716-446655440000', 'Dental Insurance', 'Dental coverage plan', 'dental', true),
('550e8400-e29b-41d4-a716-446655442402', '550e8400-e29b-41d4-a716-446655440000', '401(k) Plan', 'Retirement savings plan', 'retirement', true),
('550e8400-e29b-41d4-a716-446655442403', '550e8400-e29b-41d4-a716-446655440000', 'Life Insurance', 'Life insurance coverage', 'life', true),
('550e8400-e29b-41d4-a716-446655442404', '550e8400-e29b-41d4-a716-446655440000', 'Vision Insurance', 'Eye care coverage', 'vision', true);

-- Employee Benefits
INSERT INTO employee_benefits (id, employee_id, benefit_type_id, enrollment_date, employee_contribution, employer_contribution, coverage_level, is_active) VALUES
('550e8400-e29b-41d4-a716-446655442500', '550e8400-e29b-41d4-a716-446655441300', '550e8400-e29b-41d4-a716-446655442400', '2023-01-15', 150.00, 800.00, 'family', true),
('550e8400-e29b-41d4-a716-446655442501', '550e8400-e29b-41d4-a716-446655441300', '550e8400-e29b-41d4-a716-446655442401', '2023-01-15', 25.00, 50.00, 'family', true),
('550e8400-e29b-41d4-a716-446655442502', '550e8400-e29b-41d4-a716-446655441300', '550e8400-e29b-41d4-a716-446655442402', '2023-01-15', 285.00, 285.00, 'standard', true),
('550e8400-e29b-41d4-a716-446655442503', '550e8400-e29b-41d4-a716-446655441301', '550e8400-e29b-41d4-a716-446655442400', '2023-02-01', 120.00, 600.00, 'individual', true),
('550e8400-e29b-41d4-a716-446655442504', '550e8400-e29b-41d4-a716-446655441302', '550e8400-e29b-41d4-a716-446655442400', '2023-03-01', 150.00, 800.00, 'family', true);

-- Leave Types
INSERT INTO leave_types (id, company_id, name, description, max_days_per_year, carryover_allowed, max_carryover_days, is_paid, requires_approval, is_active) VALUES
('550e8400-e29b-41d4-a716-446655442600', '550e8400-e29b-41d4-a716-446655440000', 'Vacation', 'Annual vacation time', 20, true, 5, true, true, true),
('550e8400-e29b-41d4-a716-446655442601', '550e8400-e29b-41d4-a716-446655440000', 'Sick Leave', 'Medical leave for illness', 10, false, 0, true, false, true),
('550e8400-e29b-41d4-a716-446655442602', '550e8400-e29b-41d4-a716-446655440000', 'Personal Days', 'Personal time off', 5, false, 0, true, true, true),
('550e8400-e29b-41d4-a716-446655442603', '550e8400-e29b-41d4-a716-446655440000', 'Bereavement', 'Time off for family loss', 3, false, 0, true, true, true);

-- Leave Balances (current year)
INSERT INTO leave_balances (id, employee_id, leave_type_id, year, allocated_days, used_days, pending_days) VALUES
('550e8400-e29b-41d4-a716-446655442700', '550e8400-e29b-41d4-a716-446655441300', '550e8400-e29b-41d4-a716-446655442600', 2024, 20.00, 5.00, 0.00),
('550e8400-e29b-41d4-a716-446655442701', '550e8400-e29b-41d4-a716-446655441300', '550e8400-e29b-41d4-a716-446655442601', 2024, 10.00, 2.00, 0.00),
('550e8400-e29b-41d4-a716-446655442702', '550e8400-e29b-41d4-a716-446655441301', '550e8400-e29b-41d4-a716-446655442600', 2024, 20.00, 3.00, 2.00),
('550e8400-e29b-41d4-a716-446655442703', '550e8400-e29b-41d4-a716-446655441302', '550e8400-e29b-41d4-a716-446655442600', 2024, 20.00, 8.00, 0.00),
('550e8400-e29b-41d4-a716-446655442704', '550e8400-e29b-41d4-a716-446655441303', '550e8400-e29b-41d4-a716-446655442600', 2024, 15.00, 1.00, 3.00);

-- Leave Requests
INSERT INTO leave_requests (id, employee_id, leave_type_id, start_date, end_date, days_requested, reason, status, approved_by, approved_at, notes) VALUES
('550e8400-e29b-41d4-a716-446655442800', '550e8400-e29b-41d4-a716-446655441300', '550e8400-e29b-41d4-a716-446655442600', '2024-03-15', '2024-03-16', 2.00, 'Family vacation', 'pending', null, null, 'Weekend trip with family'),
('550e8400-e29b-41d4-a716-446655442801', '550e8400-e29b-41d4-a716-446655441301', '550e8400-e29b-41d4-a716-446655442601', '2024-02-20', '2024-02-20', 1.00, 'Doctor appointment', 'approved', '550e8400-e29b-41d4-a716-446655441300', '2024-02-18 14:30:00', 'Annual check-up'),
('550e8400-e29b-41d4-a716-446655442802', '550e8400-e29b-41d4-a716-446655441302', '550e8400-e29b-41d4-a716-446655442600', '2024-04-01', '2024-04-03', 3.00, 'Spring break', 'pending', null, null, 'Family time during school break');

-- Pay Periods
INSERT INTO pay_periods (id, company_id, period_type, start_date, end_date, pay_date, status) VALUES
('550e8400-e29b-41d4-a716-446655442900', '550e8400-e29b-41d4-a716-446655440000', 'biweekly', '2024-01-01', '2024-01-14', '2024-01-19', 'completed'),
('550e8400-e29b-41d4-a716-446655442901', '550e8400-e29b-41d4-a716-446655440000', 'biweekly', '2024-01-15', '2024-01-28', '2024-02-02', 'completed'),
('550e8400-e29b-41d4-a716-446655442902', '550e8400-e29b-41d4-a716-446655440000', 'biweekly', '2024-01-29', '2024-02-11', '2024-02-16', 'processing'),
('550e8400-e29b-41d4-a716-446655442903', '550e8400-e29b-41d4-a716-446655440000', 'biweekly', '2024-02-12', '2024-02-25', '2024-03-01', 'open');

-- Payroll Runs
INSERT INTO payroll_runs (id, company_id, pay_period_id, run_date, status, total_gross_pay, total_deductions, total_net_pay, processed_by) VALUES
('550e8400-e29b-41d4-a716-446655443000', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655442900', '2024-01-18', 'processed', 28654.32, 8596.30, 20058.02, '550e8400-e29b-41d4-a716-446655440021'),
('550e8400-e29b-41d4-a716-446655443001', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655442901', '2024-02-01', 'processed', 28654.32, 8596.30, 20058.02, '550e8400-e29b-41d4-a716-446655440021');

-- Payroll Items (sample for first payroll run)
INSERT INTO payroll_items (id, payroll_run_id, employee_id, regular_hours, overtime_hours, regular_pay, overtime_pay, gross_pay, federal_tax, state_tax, social_security, medicare, health_insurance, retirement_401k, total_deductions) VALUES
('550e8400-e29b-41d4-a716-446655443100', '550e8400-e29b-41d4-a716-446655443000', '550e8400-e29b-41d4-a716-446655441300', 80.00, 2.00, 3653.85, 109.62, 3763.47, 452.42, 150.54, 233.33, 54.57, 150.00, 188.00, 1228.86),
('550e8400-e29b-41d4-a716-446655443101', '550e8400-e29b-41d4-a716-446655443000', '550e8400-e29b-41d4-a716-446655441301', 80.00, 0.00, 3269.23, 0.00, 3269.23, 392.31, 130.77, 202.69, 47.40, 120.00, 163.46, 1056.63),
('550e8400-e29b-41d4-a716-446655443102', '550e8400-e29b-41d4-a716-446655443000', '550e8400-e29b-41d4-a716-446655441302', 80.00, 0.00, 3461.54, 0.00, 3461.54, 415.38, 138.46, 214.62, 50.19, 150.00, 173.08, 1141.73),
('550e8400-e29b-41d4-a716-446655443103', '550e8400-e29b-41d4-a716-446655443000', '550e8400-e29b-41d4-a716-446655441304', 80.00, 0.00, 1800.00, 0.00, 1800.00, 216.00, 72.00, 111.60, 26.10, 0.00, 90.00, 515.70);

-- Time Entries
INSERT INTO time_entries (id, employee_id, date, clock_in, clock_out, break_minutes, regular_hours, overtime_hours, status, approved_by, approved_at) VALUES
('550e8400-e29b-41d4-a716-446655443200', '550e8400-e29b-41d4-a716-446655441303', '2024-02-15', '2024-02-15 08:00:00', '2024-02-15 17:00:00', 60, 8.00, 0.00, 'approved', '550e8400-e29b-41d4-a716-446655441300', '2024-02-16 09:00:00'),
('550e8400-e29b-41d4-a716-446655443201', '550e8400-e29b-41d4-a716-446655441304', '2024-02-15', '2024-02-15 07:30:00', '2024-02-15 16:30:00', 60, 8.00, 0.00, 'approved', '550e8400-e29b-41d4-a716-446655441300', '2024-02-16 09:00:00'),
('550e8400-e29b-41d4-a716-446655443202', '550e8400-e29b-41d4-a716-446655441306', '2024-02-15', '2024-02-15 09:00:00', '2024-02-15 18:30:00', 30, 8.00, 1.00, 'submitted', null, null),
('550e8400-e29b-41d4-a716-446655443203', '550e8400-e29b-41d4-a716-446655441307', '2024-02-15', '2024-02-15 08:30:00', '2024-02-15 17:30:00', 60, 8.00, 0.00, 'approved', '550e8400-e29b-41d4-a716-446655441302', '2024-02-16 10:00:00');

-- Performance Management
INSERT INTO performance_review_cycles (id, company_id, name, start_date, end_date, review_period_start, review_period_end, status) VALUES
('550e8400-e29b-41d4-a716-446655443300', '550e8400-e29b-41d4-a716-446655440000', '2023 Annual Review', '2024-01-01', '2024-03-31', '2023-01-01', '2023-12-31', 'active'),
('550e8400-e29b-41d4-a716-446655443301', '550e8400-e29b-41d4-a716-446655440000', 'Q1 2024 Check-in', '2024-04-01', '2024-04-30', '2024-01-01', '2024-03-31', 'planning');

INSERT INTO performance_reviews (id, review_cycle_id, employee_id, reviewer_id, self_assessment, manager_assessment, goals_achieved, areas_for_improvement, overall_rating, salary_recommendation, promotion_recommendation, status) VALUES
('550e8400-e29b-41d4-a716-446655443400', '550e8400-e29b-41d4-a716-446655443300', '550e8400-e29b-41d4-a716-446655441303', '550e8400-e29b-41d4-a716-446655441300', 'Successfully managed daily operations and improved warehouse efficiency by 15%.', 'Sarah consistently exceeds expectations in process improvement and team leadership.', 'Implemented new inventory tracking system, reduced shipping errors by 25%', 'Continue developing leadership skills, consider management training', 4, 70000.00, false, 'completed'),
('550e8400-e29b-41d4-a716-446655443401', '550e8400-e29b-41d4-a716-446655443300', '550e8400-e29b-41d4-a716-446655441307', '550e8400-e29b-41d4-a716-446655441302', 'Maintained accurate financial records and supported month-end close process.', 'Karen shows strong attention to detail and good understanding of accounting principles.', 'Successfully automated several reporting processes, completed CPA continuing education', 'Expand knowledge of advanced accounting software, improve presentation skills', 3, 72000.00, false, 'reviewed');

-- Training Programs
INSERT INTO training_programs (id, company_id, name, description, duration_hours, cost_per_person, max_participants, is_mandatory, is_active) VALUES
('550e8400-e29b-41d4-a716-446655443500', '550e8400-e29b-41d4-a716-446655440000', 'New Employee Orientation', 'Comprehensive onboarding program for new hires', 16, 0.00, 10, true, true),
('550e8400-e29b-41d4-a716-446655443501', '550e8400-e29b-41d4-a716-446655440000', 'Safety Training', 'Workplace safety and emergency procedures', 4, 150.00, 20, true, true),
('550e8400-e29b-41d4-a716-446655443502', '550e8400-e29b-41d4-a716-446655440000', 'Leadership Development', 'Management and leadership skills training', 24, 1200.00, 8, false, true),
('550e8400-e29b-41d4-a716-446655443503', '550e8400-e29b-41d4-a716-446655440000', 'Excel Advanced', 'Advanced Excel skills for data analysis', 8, 300.00, 12, false, true);

INSERT INTO training_sessions (id, training_program_id, instructor_name, start_date, end_date, location, max_participants, status) VALUES
('550e8400-e29b-41d4-a716-446655443600', '550e8400-e29b-41d4-a716-446655443500', 'HR Team', '2024-03-01', '2024-03-02', 'Conference Room A', 10, 'scheduled'),
('550e8400-e29b-41d4-a716-446655443601', '550e8400-e29b-41d4-a716-446655443501', 'Safety Specialists Inc', '2024-02-15', '2024-02-15', 'Main Warehouse', 20, 'completed'),
('550e8400-e29b-41d4-a716-446655443602', '550e8400-e29b-41d4-a716-446655443502', 'Leadership Experts LLC', '2024-04-10', '2024-04-12', 'Offsite Training Center', 8, 'scheduled');

INSERT INTO training_enrollments (training_session_id, employee_id, enrollment_date, completion_date, status, score, certificate_issued) VALUES
('550e8400-e29b-41d4-a716-446655443601', '550e8400-e29b-41d4-a716-446655441304', '2024-02-10', '2024-02-15', 'completed', 95.50, true),
('550e8400-e29b-41d4-a716-446655443601', '550e8400-e29b-41d4-a716-446655441303', '2024-02-10', '2024-02-15', 'completed', 88.00, true),
('550e8400-e29b-41d4-a716-446655443600', '550e8400-e29b-41d4-a716-446655441304', '2024-02-25', null, 'enrolled', null, false);

-- Manufacturing Data

-- Work Centers
INSERT INTO work_centers (id, company_id, code, name, description, capacity_per_hour, efficiency_percentage, setup_time_minutes, hourly_rate, is_active) VALUES
('550e8400-e29b-41d4-a716-446655443700', '550e8400-e29b-41d4-a716-446655440000', 'ASSEMBLY-01', 'Main Assembly Line', 'Primary laptop assembly station', 5.00, 95.00, 30, 75.00, true),
('550e8400-e29b-41d4-a716-446655443701', '550e8400-e29b-41d4-a716-446655440000', 'TESTING-01', 'Quality Testing Station', 'Final product testing and validation', 8.00, 98.00, 15, 85.00, true),
('550e8400-e29b-41d4-a716-446655443702', '550e8400-e29b-41d4-a716-446655440000', 'PACKAGING-01', 'Packaging Station', 'Product packaging and shipping prep', 12.00, 90.00, 10, 45.00, true),
('550e8400-e29b-41d4-a716-446655443703', '550e8400-e29b-41d4-a716-446655440000', 'CONFIG-01', 'Configuration Center', 'Software installation and configuration', 6.00, 92.00, 20, 95.00, true);

-- BOM Headers
INSERT INTO bom_headers (id, company_id, product_id, version, is_active, effective_date, created_by) VALUES
('550e8400-e29b-41d4-a716-446655443800', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440060', '1.0', true, '2024-01-01', '550e8400-e29b-41d4-a716-446655440023'),
('550e8400-e29b-41d4-a716-446655443801', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440064', '1.0', true, '2024-01-01', '550e8400-e29b-41d4-a716-446655440023');

-- BOM Items (components for laptop)
INSERT INTO bom_items (id, bom_header_id, component_product_id, quantity, unit_of_measure, scrap_percentage, operation_sequence, notes) VALUES
('550e8400-e29b-41d4-a716-446655443900', '550e8400-e29b-41d4-a716-446655443800', '550e8400-e29b-41d4-a716-446655440061', 1.0000, 'each', 2.00, 10, 'Include wireless mouse with laptop'),
('550e8400-e29b-41d4-a716-446655443901', '550e8400-e29b-41d4-a716-446655443800', '550e8400-e29b-41d4-a716-446655440062', 1.0000, 'each', 1.00, 20, 'Optional keyboard upgrade'),
('550e8400-e29b-41d4-a716-446655443902', '550e8400-e29b-41d4-a716-446655443801', '550e8400-e29b-41d4-a716-446655440061', 1.0000, 'each', 1.00, 10, 'Monitor includes mouse');

-- Routings
INSERT INTO routings (id, company_id, product_id, version, is_active, effective_date) VALUES
('550e8400-e29b-41d4-a716-446655444000', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440060', '1.0', true, '2024-01-01'),
('550e8400-e29b-41d4-a716-446655444001', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440064', '1.0', true, '2024-01-01');

-- Routing Operations
INSERT INTO routing_operations (id, routing_id, operation_number, work_center_id, operation_description, setup_time_minutes, run_time_minutes, move_time_minutes, queue_time_minutes, is_subcontracted) VALUES
('550e8400-e29b-41d4-a716-446655444100', '550e8400-e29b-41d4-a716-446655444000', 10, '550e8400-e29b-41d4-a716-446655443700', 'Hardware assembly', 30, 45, 5, 15, false),
('550e8400-e29b-41d4-a716-446655444101', '550e8400-e29b-41d4-a716-446655444000', 20, '550e8400-e29b-41d4-a716-446655443703', 'Software configuration', 20, 30, 5, 10, false),
('550e8400-e29b-41d4-a716-446655444102', '550e8400-e29b-41d4-a716-446655444000', 30, '550e8400-e29b-41d4-a716-446655443701', 'Quality testing', 15, 25, 5, 5, false),
('550e8400-e29b-41d4-a716-446655444103', '550e8400-e29b-41d4-a716-446655444000', 40, '550e8400-e29b-41d4-a716-446655443702', 'Final packaging', 10, 15, 5, 5, false);

-- Production Orders
INSERT INTO production_orders (id, company_id, order_number, product_id, bom_header_id, routing_id, quantity_to_produce, quantity_produced, planned_start_date, planned_end_date, status, priority, sales_order_id, created_by) VALUES
('550e8400-e29b-41d4-a716-446655444200', '550e8400-e29b-41d4-a716-446655440000', 'PO-2024-001', '550e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655443800', '550e8400-e29b-41d4-a716-446655444000', 50.0000, 25.0000, '2024-02-01', '2024-02-15', 'in_progress', 3, '550e8400-e29b-41d4-a716-446655440100', '550e8400-e29b-41d4-a716-446655441300'),
('550e8400-e29b-41d4-a716-446655444201', '550e8400-e29b-41d4-a716-446655440000', 'PO-2024-002', '550e8400-e29b-41d4-a716-446655440064', '550e8400-e29b-41d4-a716-446655443801', '550e8400-e29b-41d4-a716-446655444001', 30.0000, 0.0000, '2024-02-20', '2024-03-05', 'planned', 2, null, '550e8400-e29b-41d4-a716-446655441300');

-- Work Orders
INSERT INTO work_orders (id, production_order_id, routing_operation_id, operation_number, work_center_id, planned_quantity, actual_quantity, planned_start_date, planned_end_date, status, assigned_to) VALUES
('550e8400-e29b-41d4-a716-446655444300', '550e8400-e29b-41d4-a716-446655444200', '550e8400-e29b-41d4-a716-446655444100', 10, '550e8400-e29b-41d4-a716-446655443700', 50.0000, 25.0000, '2024-02-01 08:00:00', '2024-02-05 17:00:00', 'completed', '550e8400-e29b-41d4-a716-446655441303'),
('550e8400-e29b-41d4-a716-446655444301', '550e8400-e29b-41d4-a716-446655444200', '550e8400-e29b-41d4-a716-446655444101', 20, '550e8400-e29b-41d4-a716-446655443703', 25.0000, 25.0000, '2024-02-06 08:00:00', '2024-02-08 17:00:00', 'completed', '550e8400-e29b-41d4-a716-446655441306'),
('550e8400-e29b-41d4-a716-446655444302', '550e8400-e29b-41d4-a716-446655444200', '550e8400-e29b-41d4-a716-446655444102', 30, '550e8400-e29b-41d4-a716-446655443701', 25.0000, 20.0000, '2024-02-09 08:00:00', '2024-02-12 17:00:00', 'in_progress', '550e8400-e29b-41d4-a716-446655441304');

-- Quality Standards
INSERT INTO quality_standards (id, company_id, name, description, test_type, is_active) VALUES
('550e8400-e29b-41d4-a716-446655444400', '550e8400-e29b-41d4-a716-446655440000', 'Laptop Performance Test', 'Comprehensive performance and stress testing', 'final', true),
('550e8400-e29b-41d4-a716-446655444401', '550e8400-e29b-41d4-a716-446655440000', 'Visual Inspection', 'Physical appearance and build quality check', 'final', true),
('550e8400-e29b-41d4-a716-446655444402', '550e8400-e29b-41d4-a716-446655440000', 'Component Verification', 'Incoming component quality verification', 'incoming', true);

-- Quality Inspections
INSERT INTO quality_inspections (id, production_order_id, work_order_id, product_id, quality_standard_id, inspector_id, inspection_date, quantity_inspected, quantity_passed, quantity_failed, status, notes) VALUES
('550e8400-e29b-41d4-a716-446655444500', '550e8400-e29b-41d4-a716-446655444200', '550e8400-e29b-41d4-a716-446655444302', '550e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655444400', '550e8400-e29b-41d4-a716-446655441304', '2024-02-12', 20.0000, 18.0000, 2.0000, 'conditional', 'Two units failed performance test - investigating'),
('550e8400-e29b-41d4-a716-446655444501', '550e8400-e29b-41d4-a716-446655444200', '550e8400-e29b-41d4-a716-446655444302', '550e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655444401', '550e8400-e29b-41d4-a716-446655441304', '2024-02-12', 20.0000, 20.0000, 0.0000, 'passed', 'All units passed visual inspection');

-- Project Management Sample Data

-- Skills
INSERT INTO skills (id, company_id, name, description, category, is_active) VALUES
('550e8400-e29b-41d4-a716-446655444600', '550e8400-e29b-41d4-a716-446655440000', 'JavaScript', 'JavaScript programming language', 'Programming', true),
('550e8400-e29b-41d4-a716-446655444601', '550e8400-e29b-41d4-a716-446655440000', 'Project Management', 'Project planning and execution', 'Management', true),
('550e8400-e29b-41d4-a716-446655444602', '550e8400-e29b-41d4-a716-446655440000', 'SQL', 'Database query and design', 'Database', true),
('550e8400-e29b-41d4-a716-446655444603', '550e8400-e29b-41d4-a716-446655440000', 'Python', 'Python programming language', 'Programming', true),
('550e8400-e29b-41d4-a716-446655444604', '550e8400-e29b-41d4-a716-446655440000', 'Leadership', 'Team leadership and management', 'Management', true);

-- Employee Skills
INSERT INTO employee_skills (employee_id, skill_id, proficiency_level, years_experience, certified, certification_date) VALUES
('550e8400-e29b-41d4-a716-446655441306', '550e8400-e29b-41d4-a716-446655444600', 4, 5, true, '2022-06-15'),
('550e8400-e29b-41d4-a716-446655441306', '550e8400-e29b-41d4-a716-446655444602', 5, 7, true, '2021-09-10'),
('550e8400-e29b-41d4-a716-446655441306', '550e8400-e29b-41d4-a716-446655444603', 3, 3, false, null),
('550e8400-e29b-41d4-a716-446655441300', '550e8400-e29b-41d4-a716-446655444601', 5, 10, true, '2020-03-20'),
('550e8400-e29b-41d4-a716-446655441300', '550e8400-e29b-41d4-a716-446655444604', 4, 8, false, null),
('550e8400-e29b-41d4-a716-446655441301', '550e8400-e29b-41d4-a716-446655444604', 4, 6, false, null),
('550e8400-e29b-41d4-a716-446655441302', '550e8400-e29b-41d4-a716-446655444602', 4, 6, true, '2019-11-15');

-- Projects
INSERT INTO projects (id, company_id, project_code, name, description, customer_id, project_manager_id, start_date, end_date, planned_start_date, planned_end_date, budget, actual_cost, status, priority, completion_percentage) VALUES
('550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655440000', 'PROJ-001', 'ERP System Implementation', 'Implementation of new ERP system for Acme Corp', '550e8400-e29b-41d4-a716-446655440080', '550e8400-e29b-41d4-a716-446655441300', '2024-01-15', null, '2024-01-15', '2024-06-30', 125000.00, 45000.00, 'active', 1, 35.00),
('550e8400-e29b-41d4-a716-446655444701', '550e8400-e29b-41d4-a716-446655440000', 'PROJ-002', 'Website Redesign', 'Complete website redesign and modernization', '550e8400-e29b-41d4-a716-446655440081', '550e8400-e29b-41d4-a716-446655441306', '2024-02-01', null, '2024-02-01', '2024-04-15', 45000.00, 12000.00, 'active', 2, 25.00),
('550e8400-e29b-41d4-a716-446655444702', '550e8400-e29b-41d4-a716-446655440000', 'PROJ-003', 'Network Upgrade', 'Infrastructure upgrade and security implementation', '550e8400-e29b-41d4-a716-446655440082', '550e8400-e29b-41d4-a716-446655441306', '2024-03-01', null, '2024-03-01', '2024-05-31', 75000.00, 0.00, 'planning', 3, 0.00);

-- Project Phases
INSERT INTO project_phases (id, project_id, name, description, planned_start_date, planned_end_date, actual_start_date, actual_end_date, phase_order, status, completion_percentage) VALUES
('550e8400-e29b-41d4-a716-446655444800', '550e8400-e29b-41d4-a716-446655444700', 'Analysis & Planning', 'Requirements gathering and project planning', '2024-01-15', '2024-02-15', '2024-01-15', '2024-02-10', 1, 'completed', 100.00),
('550e8400-e29b-41d4-a716-446655444801', '550e8400-e29b-41d4-a716-446655444700', 'Development', 'System development and customization', '2024-02-16', '2024-05-15', '2024-02-16', null, 2, 'in_progress', 40.00),
('550e8400-e29b-41d4-a716-446655444802', '550e8400-e29b-41d4-a716-446655444700', 'Testing & Deployment', 'System testing and go-live', '2024-05-16', '2024-06-30', null, null, 3, 'not_started', 0.00),
('550e8400-e29b-41d4-a716-446655444803', '550e8400-e29b-41d4-a716-446655444701', 'Design Phase', 'UI/UX design and prototyping', '2024-02-01', '2024-02-28', '2024-02-01', null, 1, 'in_progress', 60.00),
('550e8400-e29b-41d4-a716-446655444804', '550e8400-e29b-41d4-a716-446655444701', 'Development Phase', 'Frontend and backend development', '2024-03-01', '2024-04-15', null, null, 2, 'not_started', 0.00);

-- Project Tasks
INSERT INTO project_tasks (id, project_id, phase_id, parent_task_id, task_code, name, description, assigned_to, planned_start_date, planned_end_date, actual_start_date, actual_end_date, estimated_hours, actual_hours, status, priority, completion_percentage, is_milestone) VALUES
('550e8400-e29b-41d4-a716-446655444900', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655444800', null, 'TASK-001', 'Requirements Gathering', 'Collect and document business requirements', '550e8400-e29b-41d4-a716-446655441300', '2024-01-15', '2024-01-30', '2024-01-15', '2024-01-28', 80.00, 75.00, 'completed', 1),
('550e8400-e29b-41d4-a716-446655444901', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655444800', null, 'TASK-002', 'Technical Design', 'Create technical architecture and design documents', '550e8400-e29b-41d4-a716-446655441306', '2024-01-31', '2024-02-15', '2024-01-29', '2024-02-10', 60.00, 65.00, 'completed', 1),
('550e8400-e29b-41d4-a716-446655444902', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655444801', null, 'TASK-003', 'Database Development', 'Set up database and core data structures', '550e8400-e29b-41d4-a716-446655441306', '2024-02-16', '2024-03-15', '2024-02-16', null, 120.00, 85.00, 'in_progress', 1),
('550e8400-e29b-41d4-a716-446655444903', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655444801', null, 'TASK-004', 'Frontend Development', 'Build user interface components', '550e8400-e29b-41d4-a716-446655441306', '2024-03-01', '2024-04-30', null, null, 200.00, 0.00, 'not_started', 2),
('550e8400-e29b-41d4-a716-446655444904', '550e8400-e29b-41d4-a716-446655444701', '550e8400-e29b-41d4-a716-446655444803', null, 'TASK-005', 'Wireframe Creation', 'Create wireframes for all pages', '550e8400-e29b-41d4-a716-446655441306', '2024-02-01', '2024-02-15', '2024-02-01', '2024-02-12', 40.00, 38.00, 'completed', 1),
('550e8400-e29b-41d4-a716-446655444905', '550e8400-e29b-41d4-a716-446655444701', '550e8400-e29b-41d4-a716-446655444803', null, 'TASK-006', 'UI Design', 'Create visual designs and prototypes', '550e8400-e29b-41d4-a716-446655441306', '2024-02-16', '2024-02-28', '2024-02-16', null, 60.00, 25.00, 'in_progress', 1);

-- Task Dependencies
INSERT INTO task_dependencies (predecessor_task_id, successor_task_id, dependency_type, lag_days) VALUES
('550e8400-e29b-41d4-a716-446655444900', '550e8400-e29b-41d4-a716-446655444901', 'finish_to_start', 1),
('550e8400-e29b-41d4-a716-446655444901', '550e8400-e29b-41d4-a716-446655444902', 'finish_to_start', 1),
('550e8400-e29b-41d4-a716-446655444902', '550e8400-e29b-41d4-a716-446655444903', 'start_to_start', 14),
('550e8400-e29b-41d4-a716-446655444904', '550e8400-e29b-41d4-a716-446655444905', 'finish_to_start', 1);

-- Project Resources
INSERT INTO project_resources (id, project_id, employee_id, role, allocation_percentage, hourly_rate, start_date, end_date, is_active) VALUES
('550e8400-e29b-41d4-a716-446655445000', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655441300', 'Project Manager', 50.00, 95.00, '2024-01-15', '2024-06-30', true),
('550e8400-e29b-41d4-a716-446655445001', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655441306', 'Lead Developer', 80.00, 85.00, '2024-01-20', '2024-06-15', true),
('550e8400-e29b-41d4-a716-446655445002', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655441307', 'Business Analyst', 30.00, 75.00, '2024-01-15', '2024-03-31', true),
('550e8400-e29b-41d4-a716-446655445003', '550e8400-e29b-41d4-a716-446655444701', '550e8400-e29b-41d4-a716-446655441306', 'Web Developer', 60.00, 85.00, '2024-02-01', '2024-04-15', true);

-- Project Time Entries
INSERT INTO project_time_entries (id, project_id, task_id, employee_id, date, hours, billable_hours, hourly_rate, description, is_billable, status, approved_by, approved_at) VALUES
('550e8400-e29b-41d4-a716-446655445100', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655444900', '550e8400-e29b-41d4-a716-446655441300', '2024-01-15', 8.00, 8.00, 95.00, 'Initial requirements workshop with client', true, 'approved', '550e8400-e29b-41d4-a716-446655441300', '2024-01-16 09:00:00'),
('550e8400-e29b-41d4-a716-446655445101', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655444901', '550e8400-e29b-41d4-a716-446655441306', '2024-02-05', 6.00, 6.00, 85.00, 'Database schema design', true, 'approved', '550e8400-e29b-41d4-a716-446655441300', '2024-02-06 10:00:00'),
('550e8400-e29b-41d4-a716-446655445102', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655444902', '550e8400-e29b-41d4-a716-446655441306', '2024-02-20', 8.00, 8.00, 85.00, 'Database table creation and relationships', true, 'approved', '550e8400-e29b-41d4-a716-446655441300', '2024-02-21 09:00:00'),
('550e8400-e29b-41d4-a716-446655445103', '550e8400-e29b-41d4-a716-446655444701', '550e8400-e29b-41d4-a716-446655444904', '550e8400-e29b-41d4-a716-446655441306', '2024-02-08', 7.00, 7.00, 85.00, 'Homepage and navigation wireframes', true, 'submitted', null, null);

-- Project Expenses
INSERT INTO project_expenses (id, project_id, employee_id, expense_date, amount, expense_type, description, receipt_number, is_billable, status, approved_by, approved_at) VALUES
('550e8400-e29b-41d4-a716-446655445200', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655441300', '2024-01-20', 1250.00, 'Software License', 'ERP development tools and licenses', 'RCP-2024-001', true, 'approved', '550e8400-e29b-41d4-a716-446655441302', '2024-01-22 14:00:00'),
('550e8400-e29b-41d4-a716-446655445201', '550e8400-e29b-41d4-a716-446655444700', '550e8400-e29b-41d4-a716-446655441306', '2024-02-10', 350.00, 'Travel', 'Client site visit for requirements gathering', 'RCP-2024-002', true, 'approved', '550e8400-e29b-41d4-a716-446655441300', '2024-02-12 10:00:00'),
('550e8400-e29b-41d4-a716-446655445202', '550e8400-e29b-41d4-a716-446655444701', '550e8400-e29b-41d4-a716-446655441306', '2024-02-15', 199.99, 'Software', 'Design software subscription', 'RCP-2024-003', true, 'submitted', null, null);

-- Fixed Assets and Financial Planning Data

-- Asset Categories
INSERT INTO asset_categories (id, company_id, name, description, useful_life_years, default_depreciation_method, is_active) VALUES
('550e8400-e29b-41d4-a716-446655445300', '550e8400-e29b-41d4-a716-446655440000', 'Computer Equipment', 'Laptops, desktops, and peripherals', 3, 'straight_line', true),
('550e8400-e29b-41d4-a716-446655445301', '550e8400-e29b-41d4-a716-446655440000', 'Office Furniture', 'Desks, chairs, and office furnishings', 7, 'straight_line', true),
('550e8400-e29b-41d4-a716-446655445302', '550e8400-e29b-41d4-a716-446655440000', 'Vehicles', 'Company vehicles and transportation', 5, 'declining_balance', true),
('550e8400-e29b-41d4-a716-446655445303', '550e8400-e29b-41d4-a716-446655440000', 'Manufacturing Equipment', 'Production and assembly equipment', 10, 'straight_line', true);

-- Fixed Assets
INSERT INTO fixed_assets (id, company_id, asset_number, name, description, category_id, location, department_id, custodian_employee_id, acquisition_date, purchase_cost, useful_life_years, salvage_value, depreciation_method, accumulated_depreciation, status, serial_number, model, manufacturer, warranty_expiry_date) VALUES
('550e8400-e29b-41d4-a716-446655445400', '550e8400-e29b-41d4-a716-446655440000', 'ASSET-001', 'Development Laptop #1', 'High-performance laptop for development team', '550e8400-e29b-41d4-a716-446655445300', 'San Francisco HQ', '550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655441306', '2023-06-15', 2500.00, 3, 300.00, 'straight_line', 610.42, 'active', 'DEV-LAP-001', 'MacBook Pro 16"', 'Apple', '2026-06-15'),
('550e8400-e29b-41d4-a716-446655445401', '550e8400-e29b-41d4-a716-446655440000', 'ASSET-002', 'Conference Table', 'Large conference room table', '550e8400-e29b-41d4-a716-446655445301', 'San Francisco HQ', '550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655441300', '2023-03-01', 3200.00, 7, 200.00, 'straight_line', 485.71, 'active', 'FURN-001', 'Executive Conference Table', 'OfficeMax Pro', null),
('550e8400-e29b-41d4-a716-446655445402', '550e8400-e29b-41d4-a716-446655440000', 'ASSET-003', 'Company Van', 'Delivery and transportation vehicle', '550e8400-e29b-41d4-a716-446655445302', 'Oakland Warehouse', '550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655441304', '2022-09-20', 45000.00, 5, 8000.00, 'declining_balance', 18150.00, 'active', 'VAN-001', 'Transit Connect', 'Ford', '2025-09-20'),
('550e8400-e29b-41d4-a716-446655445403', '550e8400-e29b-41d4-a716-446655440000', 'ASSET-004', 'Assembly Line Station', 'Primary laptop assembly workstation', '550e8400-e29b-41d4-a716-446655445303', 'Oakland Warehouse', '550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655441303', '2023-01-10', 15000.00, 10, 1500.00, 'straight_line', 1485.00, 'active', 'ASM-001', 'ModularLine Pro', 'TechAssembly Inc', '2026-01-10');

-- Budget Periods
INSERT INTO budget_periods (id, company_id, name, start_date, end_date, period_type, status, created_by) VALUES
('550e8400-e29b-41d4-a716-446655445500', '550e8400-e29b-41d4-a716-446655440000', '2024 Annual Budget', '2024-01-01', '2024-12-31', 'annual', 'active', '550e8400-e29b-41d4-a716-446655441302'),
('550e8400-e29b-41d4-a716-446655445501', '550e8400-e29b-41d4-a716-446655440000', '2024 Q1 Budget', '2024-01-01', '2024-03-31', 'quarterly', 'active', '550e8400-e29b-41d4-a716-446655441302');

-- Budget Categories
INSERT INTO budget_categories (id, company_id, name, description, category_type, account_id, is_active) VALUES
('550e8400-e29b-41d4-a716-446655445600', '550e8400-e29b-41d4-a716-446655440000', 'Sales Revenue', 'Product and service sales', 'revenue', '550e8400-e29b-41d4-a716-446655441106', true),
('550e8400-e29b-41d4-a716-446655445601', '550e8400-e29b-41d4-a716-446655440000', 'Salary Expenses', 'Employee compensation costs', 'expense', '550e8400-e29b-41d4-a716-446655441109', true),
('550e8400-e29b-41d4-a716-446655445602', '550e8400-e29b-41d4-a716-446655440000', 'Operating Expenses', 'General business operating costs', 'expense', '550e8400-e29b-41d4-a716-446655441108', true),
('550e8400-e29b-41d4-a716-446655445603', '550e8400-e29b-41d4-a716-446655440000', 'Capital Expenditures', 'Equipment and asset purchases', 'capital', '550e8400-e29b-41d4-a716-446655441103', true);

-- Budget Lines
INSERT INTO budget_lines (id, budget_period_id, budget_category_id, department_id, account_id, budgeted_amount, actual_amount, notes, created_by) VALUES
('550e8400-e29b-41d4-a716-446655445700', '550e8400-e29b-41d4-a716-446655445500', '550e8400-e29b-41d4-a716-446655445600', '550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655441106', 2500000.00, 650000.00, 'Annual sales revenue target', '550e8400-e29b-41d4-a716-446655441302'),
('550e8400-e29b-41d4-a716-446655445701', '550e8400-e29b-41d4-a716-446655445500', '550e8400-e29b-41d4-a716-446655445601', null, '550e8400-e29b-41d4-a716-446655441109', 720000.00, 180000.00, 'Total employee salaries and benefits', '550e8400-e29b-41d4-a716-446655441302'),
('550e8400-e29b-41d4-a716-446655445702', '550e8400-e29b-41d4-a716-446655445500', '550e8400-e29b-41d4-a716-446655445602', '550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655441108', 150000.00, 35000.00, 'Operations department expenses', '550e8400-e29b-41d4-a716-446655441302'),
('550e8400-e29b-41d4-a716-446655445703', '550e8400-e29b-41d4-a716-446655445500', '550e8400-e29b-41d4-a716-446655445603', null, '550e8400-e29b-41d4-a716-446655441103', 75000.00, 18000.00, 'Equipment and infrastructure upgrades', '550e8400-e29b-41d4-a716-446655441302');

-- System Configuration and Business Intelligence Data

-- System Settings
INSERT INTO system_settings (id, company_id, setting_key, setting_value, setting_type, description, is_encrypted, updated_by) VALUES
('550e8400-e29b-41d4-a716-446655445800', '550e8400-e29b-41d4-a716-446655440000', 'company_name', 'TechFlow Solutions Inc.', 'string', 'Official company name for reports', false, '550e8400-e29b-41d4-a716-446655440020'),
('550e8400-e29b-41d4-a716-446655445801', '550e8400-e29b-41d4-a716-446655440000', 'default_currency', 'USD', 'string', 'Default currency for financial operations', false, '550e8400-e29b-41d4-a716-446655441302'),
('550e8400-e29b-41d4-a716-446655445802', '550e8400-e29b-41d4-a716-446655440000', 'inventory_reorder_threshold', '10', 'number', 'Default reorder threshold percentage', false, '550e8400-e29b-41d4-a716-446655441300'),
('550e8400-e29b-41d4-a716-446655445803', '550e8400-e29b-41d4-a716-446655440000', 'enable_automatic_backups', 'true', 'boolean', 'Enable automatic database backups', false, '550e8400-e29b-41d4-a716-446655440020'),
('550e8400-e29b-41d4-a716-446655445804', '550e8400-e29b-41d4-a716-446655440000', 'email_smtp_config', '{"host":"smtp.techflow.com","port":587,"username":"noreply@techflow.com"}', 'json', 'SMTP configuration for outbound emails', true, '550e8400-e29b-41d4-a716-446655440020');

-- KPIs
INSERT INTO kpis (id, company_id, name, description, category, calculation_method, target_value, unit_of_measure, frequency, owner_id, is_active) VALUES
('550e8400-e29b-41d4-a716-446655445900', '550e8400-e29b-41d4-a716-446655440000', 'Monthly Sales Revenue', 'Total sales revenue per month', 'Sales', 'SUM(invoice_total) WHERE status = paid', 200000.0000, 'USD', 'monthly', '550e8400-e29b-41d4-a716-446655441301', true),
('550e8400-e29b-41d4-a716-446655445901', '550e8400-e29b-41d4-a716-446655440000', 'Customer Satisfaction Score', 'Average customer satisfaction rating', 'Customer Service', 'AVG(satisfaction_rating)', 4.5000, 'Rating', 'monthly', '550e8400-e29b-41d4-a716-446655441301', true),
('550e8400-e29b-41d4-a716-446655445902', '550e8400-e29b-41d4-a716-446655440000', 'Inventory Turnover', 'Number of times inventory is sold per year', 'Operations', 'COGS / Average Inventory', 12.0000, 'Times per year', 'quarterly', '550e8400-e29b-41d4-a716-446655441300', true),
('550e8400-e29b-41d4-a716-446655445903', '550e8400-e29b-41d4-a716-446655440000', 'Employee Retention Rate', 'Percentage of employees retained', 'HR', '(Employees at end - New hires) / Employees at start * 100', 95.0000, 'Percentage', 'quarterly', '550e8400-e29b-41d4-a716-446655441302', true);

-- KPI Values
INSERT INTO kpi_values (id, kpi_id, period_date, actual_value, target_value, notes) VALUES
('550e8400-e29b-41d4-a716-446655446000', '550e8400-e29b-41d4-a716-446655445900', '2024-01-31', 185000.0000),
('550e8400-e29b-41d4-a716-446655446001', '550e8400-e29b-41d4-a716-446655445900', '2024-02-29', 220000.0000),
('550e8400-e29b-41d4-a716-446655446002', '550e8400-e29b-41d4-a716-446655445901', '2024-01-31', 4.2000),
('550e8400-e29b-41d4-a716-446655446003', '550e8400-e29b-41d4-a716-446655445902', '2024-03-31', 11.5000),
('550e8400-e29b-41d4-a716-446655446004', '550e8400-e29b-41d4-a716-446655445903', '2024-03-31', 97.0000);

-- Reports
INSERT INTO reports (id, company_id, name, description, report_type, query_sql, parameters, is_public, created_by, is_active) VALUES
('550e8400-e29b-41d4-a716-446655446100', '550e8400-e29b-41d4-a716-446655440000', 'Monthly Sales Summary', 'Summary of sales performance by month', 'sales', 'SELECT DATE_TRUNC(''month'', invoice_date) as month, SUM(total_amount) as revenue FROM invoices WHERE status = ''paid'' GROUP BY month ORDER BY month', '{"date_range": "monthly"}', true, '550e8400-e29b-41d4-a716-446655441301', true),
('550e8400-e29b-41d4-a716-446655446101', '550e8400-e29b-41d4-a716-446655440000', 'Inventory Status Report', 'Current inventory levels and reorder alerts', 'operational', 'SELECT p.name, i.quantity_on_hand, p.minimum_stock FROM products p JOIN inventory i ON p.id = i.product_id WHERE i.quantity_on_hand <= p.minimum_stock', '{}', false, '550e8400-e29b-41d4-a716-446655441300', true),
('550e8400-e29b-41d4-a716-446655446102', '550e8400-e29b-41d4-a716-446655440000', 'Employee Payroll Summary', 'Payroll summary by department and period', 'hr', 'SELECT d.name as department, pr.run_date, SUM(pi.gross_pay) as total_gross, SUM(pi.net_pay) as total_net FROM payroll_items pi JOIN employees e ON pi.employee_id = e.id JOIN departments d ON e.department_id = d.id JOIN payroll_runs pr ON pi.payroll_run_id = pr.id GROUP BY d.name, pr.run_date ORDER BY pr.run_date DESC', '{"period": "current"}', false, '550e8400-e29b-41d4-a716-446655441302', true);

-- User Notifications
INSERT INTO user_notifications (id, user_id, title, message, notification_type, is_read, related_to_type, related_to_id) VALUES
('550e8400-e29b-41d4-a716-446655446200', '550e8400-e29b-41d4-a716-446655440021', 'New Sales Order', 'Sales order SO-2024-004 requires your approval', 'in_app', false, 'sales_order', '550e8400-e29b-41d4-a716-446655440103'),
('550e8400-e29b-41d4-a716-446655446201', '550e8400-e29b-41d4-a716-446655440022', 'Lead Assignment', 'New lead LEAD-004 has been assigned to you', 'in_app', true, 'lead', '550e8400-e29b-41d4-a716-446655441503'),
('550e8400-e29b-41d4-a716-446655446202', '550e8400-e29b-41d4-a716-446655440023', 'Budget Alert', 'Operations department has exceeded 80% of quarterly budget', 'email', false, 'budget', '550e8400-e29b-41d4-a716-446655445702'),
('550e8400-e29b-41d4-a716-446655446203', '550e8400-e29b-41d4-a716-446655440025', 'Training Reminder', 'Safety training session starts tomorrow at 9:00 AM', 'in_app', false, 'training', '550e8400-e29b-41d4-a716-446655443601');

-- Commit transaction
COMMIT;

-- ==============================================
-- COMPREHENSIVE ERP SAMPLE DATA SUMMARY
-- ==============================================

-- Display comprehensive summary of all inserted data
SELECT '=== COMPREHENSIVE ERP SAMPLE DATA SUMMARY ===' as info;

SELECT 'Core System Data:' as category, 'Companies' as entity, count(*) as count FROM companies
UNION ALL SELECT 'Core System Data:', 'Users', count(*) FROM users
UNION ALL SELECT 'Core System Data:', 'Employees', count(*) FROM employees
UNION ALL SELECT 'Core System Data:', 'Departments', count(*) FROM departments
UNION ALL SELECT 'Core System Data:', 'Roles', count(*) FROM roles

UNION ALL SELECT 'CRM Data:', 'Customers', count(*) FROM customers
UNION ALL SELECT 'CRM Data:', 'Leads', count(*) FROM leads
UNION ALL SELECT 'CRM Data:', 'Opportunities', count(*) FROM opportunities
UNION ALL SELECT 'CRM Data:', 'Campaigns', count(*) FROM campaigns
UNION ALL SELECT 'CRM Data:', 'Activities', count(*) FROM activities

UNION ALL SELECT 'Products & Inventory:', 'Products', count(*) FROM products
UNION ALL SELECT 'Products & Inventory:', 'Categories', count(*) FROM product_categories
UNION ALL SELECT 'Products & Inventory:', 'Warehouses', count(*) FROM warehouses
UNION ALL SELECT 'Products & Inventory:', 'Inventory Records', count(*) FROM inventory

UNION ALL SELECT 'Sales & Financial:', 'Sales Orders', count(*) FROM sales_orders
UNION ALL SELECT 'Sales & Financial:', 'Invoices', count(*) FROM invoices
UNION ALL SELECT 'Sales & Financial:', 'Payments', count(*) FROM payments
UNION ALL SELECT 'Sales & Financial:', 'Accounts', count(*) FROM accounts

UNION ALL SELECT 'HR Management:', 'Benefits', count(*) FROM employee_benefits
UNION ALL SELECT 'HR Management:', 'Leave Requests', count(*) FROM leave_requests
UNION ALL SELECT 'HR Management:', 'Payroll Runs', count(*) FROM payroll_runs
UNION ALL SELECT 'HR Management:', 'Training Programs', count(*) FROM training_programs

UNION ALL SELECT 'Manufacturing:', 'Work Centers', count(*) FROM work_centers
UNION ALL SELECT 'Manufacturing:', 'BOMs', count(*) FROM bom_headers
UNION ALL SELECT 'Manufacturing:', 'Production Orders', count(*) FROM production_orders
UNION ALL SELECT 'Manufacturing:', 'Quality Inspections', count(*) FROM quality_inspections

UNION ALL SELECT 'Project Management:', 'Projects', count(*) FROM projects
UNION ALL SELECT 'Project Management:', 'Project Tasks', count(*) FROM project_tasks
UNION ALL SELECT 'Project Management:', 'Time Entries', count(*) FROM project_time_entries
UNION ALL SELECT 'Project Management:', 'Skills', count(*) FROM skills

UNION ALL SELECT 'Financial Planning:', 'Fixed Assets', count(*) FROM fixed_assets
UNION ALL SELECT 'Financial Planning:', 'Budget Periods', count(*) FROM budget_periods
UNION ALL SELECT 'Financial Planning:', 'Budget Lines', count(*) FROM budget_lines

UNION ALL SELECT 'Business Intelligence:', 'KPIs', count(*) FROM kpis
UNION ALL SELECT 'Business Intelligence:', 'Reports', count(*) FROM reports
UNION ALL SELECT 'Business Intelligence:', 'Notifications', count(*) FROM user_notifications

UNION ALL SELECT 'System Configuration:', 'Currencies', count(*) FROM currencies
UNION ALL SELECT 'System Configuration:', 'System Settings', count(*) FROM system_settings

ORDER BY category, entity;

-- Sample data verification queries
SELECT 'Sample Business Scenarios:' as info;

-- Active projects and their progress
SELECT 'Active Projects:' as category;
SELECT project_code, name, 
       CONCAT(completion_percentage::text, '%') as progress,
       status,
       budget::text as budget
FROM projects 
WHERE status = 'active' 
ORDER BY project_code 
LIMIT 5;

-- Recent sales performance
SELECT 'Recent Sales Orders:' as category;
SELECT order_number,
       (SELECT name FROM customers WHERE id = sales_orders.customer_id) as customer_name,
       status,
       total_amount::text as amount
FROM sales_orders 
ORDER BY order_date DESC 
LIMIT 5;

-- Employee overview by department
SELECT 'Employee Overview:' as category;
SELECT d.name as department, 
       COUNT(e.id) as employee_count,
       AVG(e.salary)::DECIMAL(10,2) as avg_salary
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
WHERE d.company_id = '550e8400-e29b-41d4-a716-446655440000'
GROUP BY d.name
ORDER BY employee_count DESC;

-- Manufacturing status
SELECT 'Production Status:' as category;
SELECT order_number,
       (SELECT name FROM products WHERE id = production_orders.product_id) as product_name,
       quantity_to_produce::text as planned_qty,
       quantity_produced::text as actual_qty,
       status
FROM production_orders
ORDER BY planned_start_date DESC
LIMIT 3;

-- Display summary of inserted data
SELECT 'Data Summary:' as info;
SELECT 'Companies' as entity, count(*) as count FROM companies
UNION ALL SELECT 'Users', count(*) FROM users
UNION ALL SELECT 'Customers', count(*) FROM customers
UNION ALL SELECT 'Products', count(*) FROM products
UNION ALL SELECT 'Sales Orders', count(*) FROM sales_orders
UNION ALL SELECT 'Invoices', count(*) FROM invoices
UNION ALL SELECT 'Stock Movements', count(*) FROM stock_movements;

-- Display some sample data for verification
SELECT 'Sample Customers:' as info;
SELECT customer_code, name, city, state, credit_limit FROM customers ORDER BY customer_code LIMIT 3;

SELECT 'Sample Products:' as info;
SELECT sku, name, unit_price, minimum_stock FROM products ORDER BY sku LIMIT 3;

SELECT 'Sample Sales Orders:' as info;
SELECT order_number, 
       (SELECT name FROM customers WHERE id = sales_orders.customer_id) as customer_name,
       status, total_amount 
FROM sales_orders ORDER BY order_number LIMIT 3;