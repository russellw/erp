-- Sample Data for ERP System
-- This file provides comprehensive test data for all major entities

-- Start transaction
BEGIN;

-- Clear existing data (in dependency order)
DELETE FROM invoice_line_items;
DELETE FROM sales_order_line_items;
DELETE FROM purchase_order_line_items;
DELETE FROM stock_movements;
DELETE FROM inventory_levels;
DELETE FROM invoices;
DELETE FROM sales_orders;
DELETE FROM purchase_orders;
DELETE FROM products;
DELETE FROM product_categories;
DELETE FROM customers;
DELETE FROM suppliers;
DELETE FROM warehouses;
DELETE FROM user_roles;
DELETE FROM departments;
DELETE FROM users;
DELETE FROM roles;
DELETE FROM companies;

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

-- Assign user roles
INSERT INTO user_roles (user_id, role_id) VALUES
('550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440010'), -- admin -> admin role
('550e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440011'), -- jsmith -> manager
('550e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440013'), -- mjohnson -> sales
('550e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440014'), -- rbrown -> accountant
('550e8400-e29b-41d4-a716-446655440024', '550e8400-e29b-41d4-a716-446655440012'); -- sdavis -> employee

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
INSERT INTO inventory_levels (id, warehouse_id, product_id, quantity_on_hand, reserved_quantity, reorder_point, last_updated) VALUES
('550e8400-e29b-41d4-a716-446655440070', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440060', 25, 5, 10, CURRENT_TIMESTAMP), -- Laptops in Main Warehouse
('550e8400-e29b-41d4-a716-446655440071', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440061', 150, 20, 50, CURRENT_TIMESTAMP), -- Mice in Main Warehouse
('550e8400-e29b-41d4-a716-446655440072', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440062', 45, 5, 15, CURRENT_TIMESTAMP), -- Keyboards in Main Warehouse
('550e8400-e29b-41d4-a716-446655440073', '550e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440064', 12, 2, 5, CURRENT_TIMESTAMP), -- Monitors in East Coast
('550e8400-e29b-41d4-a716-446655440074', '550e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440061', 80, 10, 30, CURRENT_TIMESTAMP); -- Mice in East Coast

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
('550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440000', 'SO-2024-004', '550e8400-e29b-41d4-a716-446655440083', '550e8400-e29b-41d4-a716-446655440022', '2024-01-22', '2024-02-20', null, 'pending', 999.98, 80.00, 25.00, 1104.98, 'Research lab equipment');

-- Insert Sales Order Line Items
INSERT INTO sales_order_line_items (id, sales_order_id, product_id, quantity, unit_price, total_price, notes) VALUES
-- SO-2024-001 items
('550e8400-e29b-41d4-a716-446655440110', '550e8400-e29b-41d4-a716-446655440100', '550e8400-e29b-41d4-a716-446655440060', 2, 1299.99, 2599.98, 'Executive laptops'),
('550e8400-e29b-41d4-a716-446655440111', '550e8400-e29b-41d4-a716-446655440100', '550e8400-e29b-41d4-a716-446655440061', 1, 49.99, 49.99, 'Wireless mouse'),
-- SO-2024-002 items
('550e8400-e29b-41d4-a716-446655440112', '550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440060', 1, 1299.99, 1299.99, 'Developer laptop'),
('550e8400-e29b-41d4-a716-446655440113', '550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440062', 2, 129.99, 259.98, 'Development keyboards'),
('550e8400-e29b-41d4-a716-446655440114', '550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440061', 6, 49.99, 299.94, 'Team mice'),
-- SO-2024-003 items
('550e8400-e29b-41d4-a716-446655440115', '550e8400-e29b-41d4-a716-446655440102', '550e8400-e29b-41d4-a716-446655440060', 3, 1299.99, 3899.97, 'Management laptops'),
-- SO-2024-004 items
('550e8400-e29b-41d4-a716-446655440116', '550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440064', 2, 449.99, 899.98, 'Research monitors'),
('550e8400-e29b-41d4-a716-446655440117', '550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440061', 2, 49.99, 99.98, 'Lab mice');

-- Insert Invoices
INSERT INTO invoices (id, company_id, invoice_number, customer_id, sales_order_id, invoice_date, due_date, status, subtotal, tax_amount, total_amount, paid_amount, balance_due, notes) VALUES
('550e8400-e29b-41d4-a716-446655440120', '550e8400-e29b-41d4-a716-446655440000', 'INV-2024-001', '550e8400-e29b-41d4-a716-446655440080', '550e8400-e29b-41d4-a716-446655440100', '2024-01-30', '2024-03-01', 'paid', 2649.97, 212.00, 2861.97, 2861.97, 0.00, 'Payment received via wire transfer'),
('550e8400-e29b-41d4-a716-446655440121', '550e8400-e29b-41d4-a716-446655440000', 'INV-2024-002', '550e8400-e29b-41d4-a716-446655440081', '550e8400-e29b-41d4-a716-446655440101', '2024-02-10', '2024-02-25', 'partial', 1849.96, 147.00, 1996.96, 1000.00, 996.96, 'Partial payment received'),
('550e8400-e29b-41d4-a716-446655440122', '550e8400-e29b-41d4-a716-446655440000', 'INV-2024-003', '550e8400-e29b-41d4-a716-446655440082', '550e8400-e29b-41d4-a716-446655440102', '2024-02-03', '2024-03-20', 'sent', 3899.97, 312.00, 4211.97, 0.00, 4211.97, 'Invoice sent to customer'),
('550e8400-e29b-41d4-a716-446655440123', '550e8400-e29b-41d4-a716-446655440000', 'INV-2024-004', '550e8400-e29b-41d4-a716-446655440083', null, '2024-01-10', '2024-01-25', 'overdue', 625.00, 50.00, 675.00, 0.00, 675.00, 'Support services - overdue payment');

-- Insert Invoice Line Items
INSERT INTO invoice_line_items (id, invoice_id, product_id, quantity, unit_price, total_price, description) VALUES
-- INV-2024-001 items (matches SO-2024-001)
('550e8400-e29b-41d4-a716-446655440130', '550e8400-e29b-41d4-a716-446655440120', '550e8400-e29b-41d4-a716-446655440060', 2, 1299.99, 2599.98, 'TechFlow Pro Laptop'),
('550e8400-e29b-41d4-a716-446655440131', '550e8400-e29b-41d4-a716-446655440120', '550e8400-e29b-41d4-a716-446655440061', 1, 49.99, 49.99, 'Wireless Precision Mouse'),
-- INV-2024-002 items (matches SO-2024-002)
('550e8400-e29b-41d4-a716-446655440132', '550e8400-e29b-41d4-a716-446655440121', '550e8400-e29b-41d4-a716-446655440060', 1, 1299.99, 1299.99, 'TechFlow Pro Laptop'),
('550e8400-e29b-41d4-a716-446655440133', '550e8400-e29b-41d4-a716-446655440121', '550e8400-e29b-41d4-a716-446655440062', 2, 129.99, 259.98, 'Mechanical Keyboard'),
('550e8400-e29b-41d4-a716-446655440134', '550e8400-e29b-41d4-a716-446655440121', '550e8400-e29b-41d4-a716-446655440061', 6, 49.99, 299.94, 'Wireless Precision Mouse'),
-- INV-2024-003 items (matches SO-2024-003)
('550e8400-e29b-41d4-a716-446655440135', '550e8400-e29b-41d4-a716-446655440122', '550e8400-e29b-41d4-a716-446655440060', 3, 1299.99, 3899.97, 'TechFlow Pro Laptop'),
-- INV-2024-004 items (service invoice)
('550e8400-e29b-41d4-a716-446655440136', '550e8400-e29b-41d4-a716-446655440123', '550e8400-e29b-41d4-a716-446655440065', 5, 125.00, 625.00, 'Technical Support Services');

-- Insert Stock Movements (sample inventory transactions)
INSERT INTO stock_movements (id, warehouse_id, product_id, movement_type, quantity, reference_number, notes, moved_at) VALUES
('550e8400-e29b-41d4-a716-446655440140', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440060', 'receipt', 30, 'PO-2024-001', 'Initial stock receipt', '2024-01-01'),
('550e8400-e29b-41d4-a716-446655440141', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440061', 'receipt', 200, 'PO-2024-002', 'Mouse inventory replenishment', '2024-01-02'),
('550e8400-e29b-41d4-a716-446655440142', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440060', 'shipment', -2, 'SO-2024-001', 'Shipped to Acme Corporation', '2024-01-30'),
('550e8400-e29b-41d4-a716-446655440143', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440061', 'shipment', -1, 'SO-2024-001', 'Shipped to Acme Corporation', '2024-01-30'),
('550e8400-e29b-41d4-a716-446655440144', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440062', 'receipt', 50, 'PO-2024-003', 'Keyboard stock receipt', '2024-01-15'),
('550e8400-e29b-41d4-a716-446655440145', '550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440060', 'shipment', -3, 'SO-2024-003', 'Shipped to Global Solutions', '2024-02-03');

-- Commit transaction
COMMIT;

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