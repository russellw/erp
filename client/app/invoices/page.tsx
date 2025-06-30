'use client';

import { useState, useEffect } from 'react';
import Layout from '../../components/Layout';
import ErrorMessage from '../../components/ErrorMessage';
import { apiClient } from '../../lib/api';
import type { Invoice, Customer } from '../../lib/types';

export default function Invoices() {
  const [invoices, setInvoices] = useState<Invoice[]>([]);
  const [customers, setCustomers] = useState<Customer[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [showModal, setShowModal] = useState(false);
  const [editingInvoice, setEditingInvoice] = useState<Invoice | null>(null);
  const [formData, setFormData] = useState({
    invoice_number: '',
    customer_id: '',
    invoice_date: '',
    due_date: '',
    status: 'draft',
    subtotal: 0,
    tax_amount: 0,
    total_amount: 0,
    paid_amount: 0,
    balance_due: 0,
    notes: '',
  });

  const invoiceStatuses = [
    'draft',
    'sent',
    'viewed',
    'partial',
    'paid',
    'overdue',
    'cancelled'
  ];

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    setLoading(true);
    const [invoicesResponse, customersResponse] = await Promise.all([
      apiClient.getInvoices(),
      apiClient.getCustomers()
    ]);
    
    if (invoicesResponse.data) {
      setInvoices(invoicesResponse.data);
    }
    if (customersResponse.data) {
      setCustomers(customersResponse.data);
    }
    
    if (invoicesResponse.error || customersResponse.error) {
      setError(invoicesResponse.error || customersResponse.error || 'Failed to load data');
    }
    
    setLoading(false);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    try {
      if (editingInvoice) {
        const response = await apiClient.updateInvoice(editingInvoice.id, formData);
        if (response.error) {
          throw new Error(response.error);
        }
      } else {
        const response = await apiClient.createInvoice(formData);
        if (response.error) {
          throw new Error(response.error);
        }
      }
      
      await loadData();
      setShowModal(false);
      setEditingInvoice(null);
      resetForm();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to save invoice');
    }
  };

  const handleEdit = (invoice: Invoice) => {
    setEditingInvoice(invoice);
    setFormData({
      invoice_number: invoice.invoice_number,
      customer_id: invoice.customer_id,
      invoice_date: new Date(invoice.invoice_date).toISOString().split('T')[0],
      due_date: new Date(invoice.due_date).toISOString().split('T')[0],
      status: invoice.status,
      subtotal: invoice.subtotal,
      tax_amount: invoice.tax_amount,
      total_amount: invoice.total_amount,
      paid_amount: invoice.paid_amount,
      balance_due: invoice.balance_due,
      notes: invoice.notes || '',
    });
    setShowModal(true);
  };

  const handleDelete = async (id: string) => {
    if (confirm('Are you sure you want to delete this invoice?')) {
      const response = await apiClient.deleteInvoice(id);
      if (response.error) {
        setError(response.error);
      } else {
        await loadData();
      }
    }
  };

  const resetForm = () => {
    const today = new Date().toISOString().split('T')[0];
    const dueDate = new Date();
    dueDate.setDate(dueDate.getDate() + 30);
    
    setFormData({
      invoice_number: '',
      customer_id: '',
      invoice_date: today,
      due_date: dueDate.toISOString().split('T')[0],
      status: 'draft',
      subtotal: 0,
      tax_amount: 0,
      total_amount: 0,
      paid_amount: 0,
      balance_due: 0,
      notes: '',
    });
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    const numericFields = ['subtotal', 'tax_amount', 'total_amount', 'paid_amount', 'balance_due'];
    
    setFormData(prev => {
      const newData = {
        ...prev,
        [name]: numericFields.includes(name) ? Number(value) : value,
      };
      
      if (name === 'subtotal' || name === 'tax_amount') {
        newData.total_amount = newData.subtotal + newData.tax_amount;
        newData.balance_due = newData.total_amount - newData.paid_amount;
      } else if (name === 'paid_amount') {
        newData.balance_due = newData.total_amount - newData.paid_amount;
      }
      
      return newData;
    });
  };

  const getCustomerName = (customerId: string) => {
    const customer = customers.find(c => c.id === customerId);
    return customer ? customer.name : 'Unknown Customer';
  };

  const getStatusColor = (status: string) => {
    const colors = {
      draft: 'bg-gray-100 text-gray-800',
      sent: 'bg-blue-100 text-blue-800',
      viewed: 'bg-indigo-100 text-indigo-800',
      partial: 'bg-yellow-100 text-yellow-800',
      paid: 'bg-green-100 text-green-800',
      overdue: 'bg-red-100 text-red-800',
      cancelled: 'bg-gray-100 text-gray-800',
    };
    return colors[status as keyof typeof colors] || 'bg-gray-100 text-gray-800';
  };

  const isOverdue = (invoice: Invoice) => {
    const today = new Date();
    const dueDate = new Date(invoice.due_date);
    return dueDate < today && invoice.status !== 'paid' && invoice.status !== 'cancelled';
  };

  if (loading) {
    return (
      <Layout>
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-900">Invoices</h1>
          <button
            onClick={() => {
              setEditingInvoice(null);
              resetForm();
              setShowModal(true);
            }}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md text-sm font-medium"
          >
            Create Invoice
          </button>
        </div>

        {error && (
          <ErrorMessage 
            message={error} 
            onDismiss={() => setError('')}
          />
        )}

        <div className="bg-white shadow rounded-lg overflow-hidden">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Invoice
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Customer
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Dates
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Amount
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Status
                </th>
                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {invoices.map((invoice) => (
                <tr key={invoice.id} className={isOverdue(invoice) ? 'bg-red-50' : ''}>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div>
                      <div className="text-sm font-medium text-gray-900">{invoice.invoice_number}</div>
                      <div className="text-sm text-gray-500">
                        {new Date(invoice.invoice_date).toLocaleDateString()}
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-900">{getCustomerName(invoice.customer_id)}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-900">
                      Due: {new Date(invoice.due_date).toLocaleDateString()}
                      {isOverdue(invoice) && (
                        <div className="text-red-600 text-xs font-medium">OVERDUE</div>
                      )}
                    </div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-900">
                      Total: ${invoice.total_amount.toFixed(2)}
                    </div>
                    <div className="text-sm text-gray-500">
                      Paid: ${invoice.paid_amount.toFixed(2)}
                    </div>
                    <div className="text-sm font-medium text-gray-900">
                      Balance: ${invoice.balance_due.toFixed(2)}
                    </div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className={`inline-flex px-2 py-1 text-xs font-semibold rounded-full ${getStatusColor(invoice.status)}`}>
                      {invoice.status.charAt(0).toUpperCase() + invoice.status.slice(1)}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <button
                      onClick={() => handleEdit(invoice)}
                      className="text-blue-600 hover:text-blue-900 mr-4"
                    >
                      Edit
                    </button>
                    <button
                      onClick={() => handleDelete(invoice.id)}
                      className="text-red-600 hover:text-red-900"
                    >
                      Delete
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {showModal && (
          <div className="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
            <div className="relative top-20 mx-auto p-5 border w-full max-w-2xl shadow-lg rounded-md bg-white">
              <div className="mt-3">
                <h3 className="text-lg font-medium text-gray-900 mb-4">
                  {editingInvoice ? 'Edit Invoice' : 'Create New Invoice'}
                </h3>
                
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Invoice Number *</label>
                      <input
                        type="text"
                        name="invoice_number"
                        required
                        value={formData.invoice_number}
                        onChange={handleChange}
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                      />
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Customer *</label>
                      <select
                        name="customer_id"
                        required
                        value={formData.customer_id}
                        onChange={handleChange}
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                      >
                        <option value="">Select Customer</option>
                        {customers.map((customer) => (
                          <option key={customer.id} value={customer.id}>
                            {customer.name}
                          </option>
                        ))}
                      </select>
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Invoice Date *</label>
                      <input
                        type="date"
                        name="invoice_date"
                        required
                        value={formData.invoice_date}
                        onChange={handleChange}
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                      />
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Due Date *</label>
                      <input
                        type="date"
                        name="due_date"
                        required
                        value={formData.due_date}
                        onChange={handleChange}
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                      />
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Status</label>
                      <select
                        name="status"
                        value={formData.status}
                        onChange={handleChange}
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                      >
                        {invoiceStatuses.map((status) => (
                          <option key={status} value={status}>
                            {status.charAt(0).toUpperCase() + status.slice(1)}
                          </option>
                        ))}
                      </select>
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Subtotal</label>
                      <input
                        type="number"
                        name="subtotal"
                        min="0"
                        step="0.01"
                        value={formData.subtotal}
                        onChange={handleChange}
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                      />
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Tax Amount</label>
                      <input
                        type="number"
                        name="tax_amount"
                        min="0"
                        step="0.01"
                        value={formData.tax_amount}
                        onChange={handleChange}
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                      />
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Total Amount</label>
                      <input
                        type="number"
                        name="total_amount"
                        min="0"
                        step="0.01"
                        value={formData.total_amount}
                        readOnly
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm bg-gray-100"
                      />
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Paid Amount</label>
                      <input
                        type="number"
                        name="paid_amount"
                        min="0"
                        step="0.01"
                        value={formData.paid_amount}
                        onChange={handleChange}
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                      />
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Balance Due</label>
                      <input
                        type="number"
                        name="balance_due"
                        min="0"
                        step="0.01"
                        value={formData.balance_due}
                        readOnly
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm bg-gray-100"
                      />
                    </div>
                    
                    <div className="sm:col-span-2">
                      <label className="block text-sm font-medium text-gray-700">Notes</label>
                      <textarea
                        name="notes"
                        rows={3}
                        value={formData.notes}
                        onChange={handleChange}
                        className="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                      />
                    </div>
                  </div>
                  
                  <div className="flex justify-end space-x-3 pt-4">
                    <button
                      type="button"
                      onClick={() => setShowModal(false)}
                      className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50"
                    >
                      Cancel
                    </button>
                    <button
                      type="submit"
                      className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700"
                    >
                      {editingInvoice ? 'Update' : 'Create'} Invoice
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        )}
      </div>
    </Layout>
  );
}