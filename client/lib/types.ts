export interface User {
  id: string;
  username: string;
  email: string;
  first_name: string;
  last_name: string;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface Company {
  id: string;
  name: string;
  tax_id?: string;
  registration_number?: string;
  address?: string;
  city?: string;
  state?: string;
  postal_code?: string;
  country?: string;
  phone?: string;
  email?: string;
  website?: string;
  created_at: string;
  updated_at: string;
}

export interface Customer {
  id: string;
  company_id: string;
  customer_code: string;
  name: string;
  email?: string;
  phone?: string;
  tax_id?: string;
  billing_address?: string;
  shipping_address?: string;
  city?: string;
  state?: string;
  postal_code?: string;
  country?: string;
  credit_limit: number;
  payment_terms: number;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface Product {
  id: string;
  company_id: string;
  sku: string;
  name: string;
  description?: string;
  category_id?: string;
  unit_of_measure?: string;
  unit_price?: number;
  cost_price?: number;
  weight?: number;
  dimensions?: string;
  is_active: boolean;
  track_inventory: boolean;
  minimum_stock: number;
  maximum_stock?: number;
  created_at: string;
  updated_at: string;
}

export interface SalesOrder {
  id: string;
  company_id: string;
  order_number: string;
  customer_id: string;
  salesperson_id?: string;
  order_date: string;
  required_date?: string;
  promised_date?: string;
  status: string;
  subtotal: number;
  tax_amount: number;
  shipping_amount: number;
  total_amount: number;
  notes?: string;
  created_at: string;
  updated_at: string;
}

export interface Invoice {
  id: string;
  company_id: string;
  invoice_number: string;
  customer_id: string;
  sales_order_id?: string;
  invoice_date: string;
  due_date: string;
  status: string;
  subtotal: number;
  tax_amount: number;
  total_amount: number;
  paid_amount: number;
  balance_due: number;
  notes?: string;
  created_at: string;
  updated_at: string;
}

export interface LoginRequest {
  username: string;
  password: string;
}

export interface LoginResponse {
  token: string;
  user: User;
}

export interface ApiResponse<T> {
  data?: T;
  message?: string;
  error?: string;
}