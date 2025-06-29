package main

import (
	"time"
)

type User struct {
	ID           string    `json:"id" db:"id"`
	Username     string    `json:"username" db:"username"`
	Email        string    `json:"email" db:"email"`
	PasswordHash string    `json:"-" db:"password_hash"`
	FirstName    string    `json:"first_name" db:"first_name"`
	LastName     string    `json:"last_name" db:"last_name"`
	IsActive     bool      `json:"is_active" db:"is_active"`
	CreatedAt    time.Time `json:"created_at" db:"created_at"`
	UpdatedAt    time.Time `json:"updated_at" db:"updated_at"`
}

type Company struct {
	ID                 string    `json:"id" db:"id"`
	Name               string    `json:"name" db:"name"`
	TaxID              *string   `json:"tax_id" db:"tax_id"`
	RegistrationNumber *string   `json:"registration_number" db:"registration_number"`
	Address            *string   `json:"address" db:"address"`
	City               *string   `json:"city" db:"city"`
	State              *string   `json:"state" db:"state"`
	PostalCode         *string   `json:"postal_code" db:"postal_code"`
	Country            *string   `json:"country" db:"country"`
	Phone              *string   `json:"phone" db:"phone"`
	Email              *string   `json:"email" db:"email"`
	Website            *string   `json:"website" db:"website"`
	CreatedAt          time.Time `json:"created_at" db:"created_at"`
	UpdatedAt          time.Time `json:"updated_at" db:"updated_at"`
}

type Customer struct {
	ID              string    `json:"id" db:"id"`
	CompanyID       string    `json:"company_id" db:"company_id"`
	CustomerCode    string    `json:"customer_code" db:"customer_code"`
	Name            string    `json:"name" db:"name"`
	Email           *string   `json:"email" db:"email"`
	Phone           *string   `json:"phone" db:"phone"`
	TaxID           *string   `json:"tax_id" db:"tax_id"`
	BillingAddress  *string   `json:"billing_address" db:"billing_address"`
	ShippingAddress *string   `json:"shipping_address" db:"shipping_address"`
	City            *string   `json:"city" db:"city"`
	State           *string   `json:"state" db:"state"`
	PostalCode      *string   `json:"postal_code" db:"postal_code"`
	Country         *string   `json:"country" db:"country"`
	CreditLimit     float64   `json:"credit_limit" db:"credit_limit"`
	PaymentTerms    int       `json:"payment_terms" db:"payment_terms"`
	IsActive        bool      `json:"is_active" db:"is_active"`
	CreatedAt       time.Time `json:"created_at" db:"created_at"`
	UpdatedAt       time.Time `json:"updated_at" db:"updated_at"`
}

type Product struct {
	ID              string    `json:"id" db:"id"`
	CompanyID       string    `json:"company_id" db:"company_id"`
	SKU             string    `json:"sku" db:"sku"`
	Name            string    `json:"name" db:"name"`
	Description     *string   `json:"description" db:"description"`
	CategoryID      *string   `json:"category_id" db:"category_id"`
	UnitOfMeasure   *string   `json:"unit_of_measure" db:"unit_of_measure"`
	UnitPrice       *float64  `json:"unit_price" db:"unit_price"`
	CostPrice       *float64  `json:"cost_price" db:"cost_price"`
	Weight          *float64  `json:"weight" db:"weight"`
	Dimensions      *string   `json:"dimensions" db:"dimensions"`
	IsActive        bool      `json:"is_active" db:"is_active"`
	TrackInventory  bool      `json:"track_inventory" db:"track_inventory"`
	MinimumStock    int       `json:"minimum_stock" db:"minimum_stock"`
	MaximumStock    *int      `json:"maximum_stock" db:"maximum_stock"`
	CreatedAt       time.Time `json:"created_at" db:"created_at"`
	UpdatedAt       time.Time `json:"updated_at" db:"updated_at"`
}

type SalesOrder struct {
	ID             string    `json:"id" db:"id"`
	CompanyID      string    `json:"company_id" db:"company_id"`
	OrderNumber    string    `json:"order_number" db:"order_number"`
	CustomerID     string    `json:"customer_id" db:"customer_id"`
	SalespersonID  *string   `json:"salesperson_id" db:"salesperson_id"`
	OrderDate      time.Time `json:"order_date" db:"order_date"`
	RequiredDate   *time.Time `json:"required_date" db:"required_date"`
	PromisedDate   *time.Time `json:"promised_date" db:"promised_date"`
	Status         string    `json:"status" db:"status"`
	Subtotal       float64   `json:"subtotal" db:"subtotal"`
	TaxAmount      float64   `json:"tax_amount" db:"tax_amount"`
	ShippingAmount float64   `json:"shipping_amount" db:"shipping_amount"`
	TotalAmount    float64   `json:"total_amount" db:"total_amount"`
	Notes          *string   `json:"notes" db:"notes"`
	CreatedAt      time.Time `json:"created_at" db:"created_at"`
	UpdatedAt      time.Time `json:"updated_at" db:"updated_at"`
}

type Invoice struct {
	ID            string    `json:"id" db:"id"`
	CompanyID     string    `json:"company_id" db:"company_id"`
	InvoiceNumber string    `json:"invoice_number" db:"invoice_number"`
	CustomerID    string    `json:"customer_id" db:"customer_id"`
	SalesOrderID  *string   `json:"sales_order_id" db:"sales_order_id"`
	InvoiceDate   time.Time `json:"invoice_date" db:"invoice_date"`
	DueDate       time.Time `json:"due_date" db:"due_date"`
	Status        string    `json:"status" db:"status"`
	Subtotal      float64   `json:"subtotal" db:"subtotal"`
	TaxAmount     float64   `json:"tax_amount" db:"tax_amount"`
	TotalAmount   float64   `json:"total_amount" db:"total_amount"`
	PaidAmount    float64   `json:"paid_amount" db:"paid_amount"`
	BalanceDue    float64   `json:"balance_due" db:"balance_due"`
	Notes         *string   `json:"notes" db:"notes"`
	CreatedAt     time.Time `json:"created_at" db:"created_at"`
	UpdatedAt     time.Time `json:"updated_at" db:"updated_at"`
}

type LoginRequest struct {
	Username string `json:"username" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type LoginResponse struct {
	Token string `json:"token"`
	User  User   `json:"user"`
}