import Layout from '../../components/Layout';

const statsData = [
  { name: 'Total Customers', value: '1,234', change: '+4.75%', changeType: 'positive' },
  { name: 'Active Orders', value: '89', change: '+12.02%', changeType: 'positive' },
  { name: 'Pending Invoices', value: '23', change: '-2.35%', changeType: 'negative' },
  { name: 'Monthly Revenue', value: '$45,231', change: '+8.12%', changeType: 'positive' },
];

const recentOrders = [
  { id: 'ORD-001', customer: 'Acme Corp', amount: '$2,450.00', status: 'Processing' },
  { id: 'ORD-002', customer: 'TechStart Ltd', amount: '$1,890.50', status: 'Shipped' },
  { id: 'ORD-003', customer: 'Global Solutions', amount: '$3,200.75', status: 'Pending' },
  { id: 'ORD-004', customer: 'Innovation Hub', amount: '$875.25', status: 'Delivered' },
];

const pendingInvoices = [
  { id: 'INV-101', customer: 'Acme Corp', amount: '$2,450.00', dueDate: '2024-01-15' },
  { id: 'INV-102', customer: 'TechStart Ltd', amount: '$1,890.50', dueDate: '2024-01-18' },
  { id: 'INV-103', customer: 'Global Solutions', amount: '$3,200.75', dueDate: '2024-01-20' },
];

export default function Dashboard() {
  return (
    <Layout>
      <div className="space-y-6">
        <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
          {statsData.map((item) => (
            <div key={item.name} className="bg-white overflow-hidden shadow rounded-lg">
              <div className="p-5">
                <div className="flex items-center">
                  <div className="flex-shrink-0">
                    <div className="text-2xl font-bold text-gray-900">{item.value}</div>
                  </div>
                </div>
                <div className="mt-1">
                  <div className="text-sm font-medium text-gray-500">{item.name}</div>
                  <div className={`text-sm ${item.changeType === 'positive' ? 'text-green-600' : 'text-red-600'}`}>
                    {item.change}
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
          <div className="bg-white shadow rounded-lg">
            <div className="px-4 py-5 sm:p-6">
              <h3 className="text-lg leading-6 font-medium text-gray-900 mb-4">Recent Orders</h3>
              <div className="flow-root">
                <ul className="-my-5 divide-y divide-gray-200">
                  {recentOrders.map((order) => (
                    <li key={order.id} className="py-4">
                      <div className="flex items-center space-x-4">
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-medium text-gray-900 truncate">{order.id}</p>
                          <p className="text-sm text-gray-500 truncate">{order.customer}</p>
                        </div>
                        <div className="flex-shrink-0 text-right">
                          <p className="text-sm font-medium text-gray-900">{order.amount}</p>
                          <p className={`text-sm ${
                            order.status === 'Delivered' ? 'text-green-600' :
                            order.status === 'Shipped' ? 'text-blue-600' :
                            order.status === 'Processing' ? 'text-yellow-600' : 'text-gray-600'
                          }`}>{order.status}</p>
                        </div>
                      </div>
                    </li>
                  ))}
                </ul>
              </div>
            </div>
          </div>

          <div className="bg-white shadow rounded-lg">
            <div className="px-4 py-5 sm:p-6">
              <h3 className="text-lg leading-6 font-medium text-gray-900 mb-4">Pending Invoices</h3>
              <div className="flow-root">
                <ul className="-my-5 divide-y divide-gray-200">
                  {pendingInvoices.map((invoice) => (
                    <li key={invoice.id} className="py-4">
                      <div className="flex items-center space-x-4">
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-medium text-gray-900 truncate">{invoice.id}</p>
                          <p className="text-sm text-gray-500 truncate">{invoice.customer}</p>
                        </div>
                        <div className="flex-shrink-0 text-right">
                          <p className="text-sm font-medium text-gray-900">{invoice.amount}</p>
                          <p className="text-sm text-red-600">Due: {invoice.dueDate}</p>
                        </div>
                      </div>
                    </li>
                  ))}
                </ul>
              </div>
            </div>
          </div>
        </div>

        <div className="bg-white shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <h3 className="text-lg leading-6 font-medium text-gray-900 mb-4">Quick Actions</h3>
            <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
              <button className="inline-flex items-center justify-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                New Order
              </button>
              <button className="inline-flex items-center justify-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                Create Invoice
              </button>
              <button className="inline-flex items-center justify-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700">
                Add Customer
              </button>
              <button className="inline-flex items-center justify-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-orange-600 hover:bg-orange-700">
                Add Product
              </button>
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
}