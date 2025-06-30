package main

import (
	"database/sql"
	"net/http"
	"regexp"

	"github.com/gin-gonic/gin"
)

// UUID validation regex
var uuidRegex = regexp.MustCompile(`^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$`)

func isValidUUID(uuid string) bool {
	return uuidRegex.MatchString(uuid)
}

// Auth handlers
func handleLogin(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var req LoginRequest
		if err := c.ShouldBindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		// TODO: Implement proper authentication
		c.JSON(http.StatusOK, gin.H{
			"token": "mock-jwt-token",
			"user": gin.H{
				"id":         "1",
				"username":   req.Username,
				"email":      req.Username + "@example.com",
				"first_name": "Mock",
				"last_name":  "User",
			},
		})
	}
}

func handleLogout(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{"message": "Logged out successfully"})
}

func handleGetCurrentUser(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		// TODO: Extract user from JWT token
		c.JSON(http.StatusOK, gin.H{
			"id":         "1",
			"username":   "admin",
			"email":      "admin@example.com",
			"first_name": "Admin",
			"last_name":  "User",
		})
	}
}

// User handlers
func handleGetUsers(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		rows, err := db.Query("SELECT id, username, email, first_name, last_name, is_active, created_at, updated_at FROM users WHERE is_active = true")
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch users"})
			return
		}
		defer rows.Close()

		var users []User
		for rows.Next() {
			var user User
			err := rows.Scan(&user.ID, &user.Username, &user.Email, &user.FirstName, &user.LastName, &user.IsActive, &user.CreatedAt, &user.UpdatedAt)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to scan user"})
				return
			}
			users = append(users, user)
		}

		c.JSON(http.StatusOK, users)
	}
}

func handleCreateUser(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleGetUser(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		id := c.Param("id")
		
		// Validate UUID format
		if !isValidUUID(id) {
			c.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
			return
		}
		
		var user User
		
		err := db.QueryRow("SELECT id, username, email, first_name, last_name, is_active, created_at, updated_at FROM users WHERE id = $1", id).
			Scan(&user.ID, &user.Username, &user.Email, &user.FirstName, &user.LastName, &user.IsActive, &user.CreatedAt, &user.UpdatedAt)
		
		if err == sql.ErrNoRows {
			c.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
			return
		}
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch user"})
			return
		}

		c.JSON(http.StatusOK, user)
	}
}

func handleUpdateUser(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleDeleteUser(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

// Company handlers
func handleGetCompanies(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		rows, err := db.Query("SELECT id, name, tax_id, address, city, country, email, created_at, updated_at FROM companies")
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch companies"})
			return
		}
		defer rows.Close()

		var companies []Company
		for rows.Next() {
			var company Company
			err := rows.Scan(&company.ID, &company.Name, &company.TaxID, &company.Address, &company.City, &company.Country, &company.Email, &company.CreatedAt, &company.UpdatedAt)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to scan company"})
				return
			}
			companies = append(companies, company)
		}

		c.JSON(http.StatusOK, companies)
	}
}

func handleCreateCompany(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleGetCompany(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleUpdateCompany(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleDeleteCompany(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

// Customer handlers
func handleGetCustomers(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		rows, err := db.Query(`
			SELECT id, company_id, customer_code, name, email, phone, 
				   billing_address, city, state, country, credit_limit, 
				   payment_terms, is_active, created_at, updated_at 
			FROM customers 
			WHERE is_active = true 
			ORDER BY name`)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch customers"})
			return
		}
		defer rows.Close()

		var customers []Customer
		for rows.Next() {
			var customer Customer
			err := rows.Scan(
				&customer.ID, &customer.CompanyID, &customer.CustomerCode, 
				&customer.Name, &customer.Email, &customer.Phone,
				&customer.BillingAddress, &customer.City, &customer.State, 
				&customer.Country, &customer.CreditLimit, &customer.PaymentTerms,
				&customer.IsActive, &customer.CreatedAt, &customer.UpdatedAt)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to scan customer"})
				return
			}
			customers = append(customers, customer)
		}

		if customers == nil {
			customers = []Customer{}
		}

		c.JSON(http.StatusOK, customers)
	}
}

func handleCreateCustomer(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleGetCustomer(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleUpdateCustomer(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleDeleteCustomer(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

// Product handlers
func handleGetProducts(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		rows, err := db.Query(`
			SELECT id, company_id, sku, name, description, unit_of_measure,
				   unit_price, cost_price, weight, dimensions, is_active,
				   track_inventory, minimum_stock, maximum_stock, created_at, updated_at
			FROM products 
			WHERE is_active = true 
			ORDER BY name`)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch products"})
			return
		}
		defer rows.Close()

		var products []Product
		for rows.Next() {
			var product Product
			err := rows.Scan(
				&product.ID, &product.CompanyID, &product.SKU, &product.Name,
				&product.Description, &product.UnitOfMeasure, &product.UnitPrice,
				&product.CostPrice, &product.Weight, &product.Dimensions,
				&product.IsActive, &product.TrackInventory, &product.MinimumStock,
				&product.MaximumStock, &product.CreatedAt, &product.UpdatedAt)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to scan product"})
				return
			}
			products = append(products, product)
		}

		if products == nil {
			products = []Product{}
		}

		c.JSON(http.StatusOK, products)
	}
}

func handleCreateProduct(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleGetProduct(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleUpdateProduct(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleDeleteProduct(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

// Sales Order handlers
func handleGetSalesOrders(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleCreateSalesOrder(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleGetSalesOrder(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleUpdateSalesOrder(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleDeleteSalesOrder(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

// Invoice handlers
func handleGetInvoices(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleCreateInvoice(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleGetInvoice(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleUpdateInvoice(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}

func handleDeleteInvoice(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.JSON(http.StatusNotImplemented, gin.H{"error": "Not implemented yet"})
	}
}