# ERP Schema Forward Reference Analysis

## Overview
The schema.sql file has **7 critical forward reference issues** that are causing schema loading failures. These occur when a table references another table that hasn't been created yet.

## Critical Forward References

### 1. **employees table** (Most Critical)
The `employees` table is defined at line 501 but is referenced by **6 tables** that appear earlier in the file:

| Referencing Table | Line | Column | Gap (lines) |
|-------------------|------|--------|-------------|
| leads | 103 | assigned_to | 398 |
| opportunities | 133 | assigned_to | 368 |
| campaigns | 168 | owner_id | 333 |
| activities | 203 | assigned_to | 298 |
| territories | 253 | manager_id | 248 |
| territory_assignments | 264 | salesperson_id | 237 |

### 2. **products table**
The `products` table is defined at line 314 but is referenced by:

| Referencing Table | Line | Column | Gap (lines) |
|-------------------|------|--------|-------------|
| opportunity_products | 156 | product_id | 158 |

## Root Cause Analysis

The main issues are:
1. **employees** table is placed too late in the schema (line 501) but is needed by CRM tables
2. **products** table is placed after some tables that need it
3. Basic entity tables are scattered throughout the file instead of being grouped at the beginning

## Immediate Fix Strategy

### Phase 1: Move Critical Tables
Move these tables to the beginning of the schema (after basic setup tables):

1. **Move `employees` table** from line 501 to approximately line 90-100
   - This will resolve 6 forward references immediately
   - Place after `departments` table (line 53) since employees reference departments

2. **Move `products` table** from line 314 to approximately line 280-290  
   - This will resolve the opportunity_products forward reference
   - Place after `product_categories` table (line 304)

### Phase 2: Optimal Reorganization
For a complete fix, reorganize the schema into logical sections:

1. **Foundation Tables** (no dependencies)
   - roles
   - companies  
   - currencies
   - users

2. **Core Entity Tables**
   - departments
   - employees
   - customers
   - suppliers
   - product_categories
   - products
   - warehouses

3. **Business Logic Tables**
   - CRM tables (leads, opportunities, etc.)
   - Sales/Purchase orders
   - Inventory management
   - etc.

## Recommended Table Order (First 20 tables)

1. roles (line 21) ✓
2. companies (line 36) ✓  
3. currencies (line 1537) ⚠️ **MOVE UP**
4. users (line 8) ✓
5. departments (line 53) ✓
6. **employees (line 501)** ⚠️ **MOVE UP** 
7. customers (line 63) ✓
8. lead_sources (line 93) ✓
9. suppliers (line 284) ⚠️ **MOVE UP**
10. product_categories (line 304) ⚠️ **MOVE UP**
11. **products (line 314)** ⚠️ **MOVE UP**
12. warehouses (line 335) ⚠️ **MOVE UP**
13. accounts (line 464) ⚠️ **MOVE UP** 
14. leads (line 103) ✓
15. opportunities (line 133) ✓
16. campaigns (line 168) ✓
17. activities (line 203) ✓
18. territories (line 253) ✓
19. customer_contacts (line 237) ✓
20. sales_orders (line 361) ✓

## Impact Assessment

### Current Issues
- **Schema loading fails** due to forward references
- **Database initialization impossible** without manual intervention
- **Development workflow blocked**

### After Fix
- Schema will load successfully
- All foreign key constraints will be valid
- Clean separation of concerns in schema organization
- Easier maintenance and understanding

## Implementation Notes

1. **Backup first**: Always backup the current schema before making changes
2. **Test thoroughly**: Verify schema loads completely after changes
3. **Consider dependencies**: Some tables have circular references (like employees.manager_id → employees.id) which are acceptable
4. **Index placement**: Indexes at the end of the file are fine and don't need to move

## Files Generated
- `schema_analysis.py`: Analysis tool for identifying forward references
- `forward_reference_summary.md`: This summary document