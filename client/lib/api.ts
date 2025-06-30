import { getAuthHeaders } from './auth';
import type {
  User,
  Company,
  Customer,
  Product,
  SalesOrder,
  Invoice,
  LoginRequest,
  LoginResponse,
  ApiResponse,
} from './types';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api/v1';

class ApiClient {
  private baseUrl: string;

  constructor(baseUrl: string = API_BASE_URL) {
    this.baseUrl = baseUrl;
  }

  private async request<T>(
    endpoint: string,
    options: RequestInit = {}
  ): Promise<ApiResponse<T>> {
    const url = `${this.baseUrl}${endpoint}`;
    const config: RequestInit = {
      headers: {
        'Content-Type': 'application/json',
        ...getAuthHeaders(),
        ...options.headers,
      },
      ...options,
    };

    try {
      const response = await fetch(url, config);
      
      // Get response text first to handle non-JSON responses
      const responseText = await response.text();
      
      // Try to parse as JSON
      let data;
      try {
        data = responseText ? JSON.parse(responseText) : {};
      } catch (parseError) {
        // If JSON parsing fails, return detailed error info
        return {
          error: `Invalid JSON response from ${url}. Status: ${response.status} ${response.statusText}. Response: ${responseText.substring(0, 200)}${responseText.length > 200 ? '...' : ''}`,
        };
      }

      if (!response.ok) {
        return {
          error: data?.message || `HTTP ${response.status}: ${response.statusText} - ${url}`,
        };
      }

      return { data };
    } catch (error) {
      return {
        error: `Network error requesting ${url}: ${error instanceof Error ? error.message : 'Unknown error'}`,
      };
    }
  }

  async login(credentials: LoginRequest): Promise<ApiResponse<LoginResponse>> {
    return this.request<LoginResponse>('/auth/login', {
      method: 'POST',
      body: JSON.stringify(credentials),
    });
  }

  async getUsers(): Promise<ApiResponse<User[]>> {
    return this.request<User[]>('/users');
  }

  async getUserById(id: string): Promise<ApiResponse<User>> {
    return this.request<User>(`/users/${id}`);
  }

  async createUser(user: Partial<User>): Promise<ApiResponse<User>> {
    return this.request<User>('/users', {
      method: 'POST',
      body: JSON.stringify(user),
    });
  }

  async updateUser(id: string, user: Partial<User>): Promise<ApiResponse<User>> {
    return this.request<User>(`/users/${id}`, {
      method: 'PUT',
      body: JSON.stringify(user),
    });
  }

  async deleteUser(id: string): Promise<ApiResponse<void>> {
    return this.request<void>(`/users/${id}`, {
      method: 'DELETE',
    });
  }

  async getCustomers(): Promise<ApiResponse<Customer[]>> {
    return this.request<Customer[]>('/customers');
  }

  async getCustomerById(id: string): Promise<ApiResponse<Customer>> {
    return this.request<Customer>(`/customers/${id}`);
  }

  async createCustomer(customer: Partial<Customer>): Promise<ApiResponse<Customer>> {
    return this.request<Customer>('/customers', {
      method: 'POST',
      body: JSON.stringify(customer),
    });
  }

  async updateCustomer(id: string, customer: Partial<Customer>): Promise<ApiResponse<Customer>> {
    return this.request<Customer>(`/customers/${id}`, {
      method: 'PUT',
      body: JSON.stringify(customer),
    });
  }

  async deleteCustomer(id: string): Promise<ApiResponse<void>> {
    return this.request<void>(`/customers/${id}`, {
      method: 'DELETE',
    });
  }

  async getProducts(): Promise<ApiResponse<Product[]>> {
    return this.request<Product[]>('/products');
  }

  async getProductById(id: string): Promise<ApiResponse<Product>> {
    return this.request<Product>(`/products/${id}`);
  }

  async createProduct(product: Partial<Product>): Promise<ApiResponse<Product>> {
    return this.request<Product>('/products', {
      method: 'POST',
      body: JSON.stringify(product),
    });
  }

  async updateProduct(id: string, product: Partial<Product>): Promise<ApiResponse<Product>> {
    return this.request<Product>(`/products/${id}`, {
      method: 'PUT',
      body: JSON.stringify(product),
    });
  }

  async deleteProduct(id: string): Promise<ApiResponse<void>> {
    return this.request<void>(`/products/${id}`, {
      method: 'DELETE',
    });
  }

  async getSalesOrders(): Promise<ApiResponse<SalesOrder[]>> {
    return this.request<SalesOrder[]>('/sales-orders');
  }

  async getSalesOrderById(id: string): Promise<ApiResponse<SalesOrder>> {
    return this.request<SalesOrder>(`/sales-orders/${id}`);
  }

  async createSalesOrder(order: Partial<SalesOrder>): Promise<ApiResponse<SalesOrder>> {
    return this.request<SalesOrder>('/sales-orders', {
      method: 'POST',
      body: JSON.stringify(order),
    });
  }

  async updateSalesOrder(id: string, order: Partial<SalesOrder>): Promise<ApiResponse<SalesOrder>> {
    return this.request<SalesOrder>(`/sales-orders/${id}`, {
      method: 'PUT',
      body: JSON.stringify(order),
    });
  }

  async deleteSalesOrder(id: string): Promise<ApiResponse<void>> {
    return this.request<void>(`/sales-orders/${id}`, {
      method: 'DELETE',
    });
  }

  async getInvoices(): Promise<ApiResponse<Invoice[]>> {
    return this.request<Invoice[]>('/invoices');
  }

  async getInvoiceById(id: string): Promise<ApiResponse<Invoice>> {
    return this.request<Invoice>(`/invoices/${id}`);
  }

  async createInvoice(invoice: Partial<Invoice>): Promise<ApiResponse<Invoice>> {
    return this.request<Invoice>('/invoices', {
      method: 'POST',
      body: JSON.stringify(invoice),
    });
  }

  async updateInvoice(id: string, invoice: Partial<Invoice>): Promise<ApiResponse<Invoice>> {
    return this.request<Invoice>(`/invoices/${id}`, {
      method: 'PUT',
      body: JSON.stringify(invoice),
    });
  }

  async deleteInvoice(id: string): Promise<ApiResponse<void>> {
    return this.request<void>(`/invoices/${id}`, {
      method: 'DELETE',
    });
  }
}

export const apiClient = new ApiClient();
export default apiClient;