package main

import (
	"database/sql"
	"net/http"

	"github.com/gin-gonic/gin"
)

func setupRoutes(r *gin.Engine, db *sql.DB) {
	// Health check endpoint
	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"status": "healthy",
			"service": "erp-api",
		})
	})

	// API v1 routes
	v1 := r.Group("/api/v1")
	{
		// Auth routes
		auth := v1.Group("/auth")
		{
			auth.POST("/login", handleLogin(db))
			auth.POST("/logout", handleLogout)
			auth.GET("/me", handleGetCurrentUser(db))
		}

		// Users routes
		users := v1.Group("/users")
		{
			users.GET("", handleGetUsers(db))
			users.POST("", handleCreateUser(db))
			users.GET("/:id", handleGetUser(db))
			users.PUT("/:id", handleUpdateUser(db))
			users.DELETE("/:id", handleDeleteUser(db))
		}

		// Companies routes
		companies := v1.Group("/companies")
		{
			companies.GET("", handleGetCompanies(db))
			companies.POST("", handleCreateCompany(db))
			companies.GET("/:id", handleGetCompany(db))
			companies.PUT("/:id", handleUpdateCompany(db))
			companies.DELETE("/:id", handleDeleteCompany(db))
		}

		// Customers routes
		customers := v1.Group("/customers")
		{
			customers.GET("", handleGetCustomers(db))
			customers.POST("", handleCreateCustomer(db))
			customers.GET("/:id", handleGetCustomer(db))
			customers.PUT("/:id", handleUpdateCustomer(db))
			customers.DELETE("/:id", handleDeleteCustomer(db))
		}

		// Products routes
		products := v1.Group("/products")
		{
			products.GET("", handleGetProducts(db))
			products.POST("", handleCreateProduct(db))
			products.GET("/:id", handleGetProduct(db))
			products.PUT("/:id", handleUpdateProduct(db))
			products.DELETE("/:id", handleDeleteProduct(db))
		}

		// Sales Orders routes
		salesOrders := v1.Group("/sales-orders")
		{
			salesOrders.GET("", handleGetSalesOrders(db))
			salesOrders.POST("", handleCreateSalesOrder(db))
			salesOrders.GET("/:id", handleGetSalesOrder(db))
			salesOrders.PUT("/:id", handleUpdateSalesOrder(db))
			salesOrders.DELETE("/:id", handleDeleteSalesOrder(db))
		}

		// Invoices routes
		invoices := v1.Group("/invoices")
		{
			invoices.GET("", handleGetInvoices(db))
			invoices.POST("", handleCreateInvoice(db))
			invoices.GET("/:id", handleGetInvoice(db))
			invoices.PUT("/:id", handleUpdateInvoice(db))
			invoices.DELETE("/:id", handleDeleteInvoice(db))
		}
	}
}