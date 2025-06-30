import Layout from '../../components/Layout';

const reportTypes = [
  {
    title: 'Sales Report',
    description: 'View sales performance and trends',
    icon: '📊',
    color: 'bg-blue-500',
  },
  {
    title: 'Customer Report',
    description: 'Customer analysis and demographics',
    icon: '👥',
    color: 'bg-green-500',
  },
  {
    title: 'Product Report',
    description: 'Product performance and inventory',
    icon: '📦',
    color: 'bg-purple-500',
  },
  {
    title: 'Financial Report',
    description: 'Revenue, expenses, and profit analysis',
    icon: '💰',
    color: 'bg-yellow-500',
  },
  {
    title: 'Invoice Report',
    description: 'Invoice status and payment tracking',
    icon: '🧾',
    color: 'bg-red-500',
  },
  {
    title: 'Inventory Report',
    description: 'Stock levels and movement tracking',
    icon: '📋',
    color: 'bg-indigo-500',
  },
];

export default function Reports() {
  return (
    <Layout>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-900">Reports</h1>
        </div>

        <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {reportTypes.map((report) => (
            <div
              key={report.title}
              className="bg-white overflow-hidden shadow rounded-lg hover:shadow-md transition-shadow cursor-pointer"
            >
              <div className="p-6">
                <div className="flex items-center">
                  <div className={`flex-shrink-0 w-10 h-10 ${report.color} rounded-md flex items-center justify-center`}>
                    <span className="text-white text-lg">{report.icon}</span>
                  </div>
                  <div className="ml-4">
                    <h3 className="text-lg font-medium text-gray-900">{report.title}</h3>
                    <p className="text-sm text-gray-500">{report.description}</p>
                  </div>
                </div>
                <div className="mt-4">
                  <button className="w-full bg-gray-100 hover:bg-gray-200 text-gray-800 font-medium py-2 px-4 rounded transition-colors">
                    Generate Report
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="bg-white shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <h3 className="text-lg leading-6 font-medium text-gray-900 mb-4">Quick Stats</h3>
            <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
              <div className="bg-blue-50 p-4 rounded-lg">
                <div className="text-2xl font-bold text-blue-600">$45,231</div>
                <div className="text-sm text-blue-600">Monthly Revenue</div>
              </div>
              <div className="bg-green-50 p-4 rounded-lg">
                <div className="text-2xl font-bold text-green-600">1,234</div>
                <div className="text-sm text-green-600">Total Customers</div>
              </div>
              <div className="bg-purple-50 p-4 rounded-lg">
                <div className="text-2xl font-bold text-purple-600">456</div>
                <div className="text-sm text-purple-600">Products</div>
              </div>
              <div className="bg-red-50 p-4 rounded-lg">
                <div className="text-2xl font-bold text-red-600">23</div>
                <div className="text-sm text-red-600">Pending Invoices</div>
              </div>
            </div>
          </div>
        </div>

        <div className="bg-white shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <h3 className="text-lg leading-6 font-medium text-gray-900 mb-4">Recent Activity</h3>
            <div className="flow-root">
              <ul className="-my-5 divide-y divide-gray-200">
                <li className="py-4">
                  <div className="flex items-center space-x-4">
                    <div className="flex-shrink-0">
                      <span className="inline-flex items-center justify-center h-8 w-8 rounded-full bg-blue-500">
                        <span className="text-sm font-medium leading-none text-white">O</span>
                      </span>
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-medium text-gray-900 truncate">New order created</p>
                      <p className="text-sm text-gray-500 truncate">Order #ORD-001 for $2,450.00</p>
                    </div>
                    <div className="flex-shrink-0 text-sm text-gray-500">2h ago</div>
                  </div>
                </li>
                <li className="py-4">
                  <div className="flex items-center space-x-4">
                    <div className="flex-shrink-0">
                      <span className="inline-flex items-center justify-center h-8 w-8 rounded-full bg-green-500">
                        <span className="text-sm font-medium leading-none text-white">I</span>
                      </span>
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-medium text-gray-900 truncate">Invoice paid</p>
                      <p className="text-sm text-gray-500 truncate">Invoice #INV-101 payment received</p>
                    </div>
                    <div className="flex-shrink-0 text-sm text-gray-500">4h ago</div>
                  </div>
                </li>
                <li className="py-4">
                  <div className="flex items-center space-x-4">
                    <div className="flex-shrink-0">
                      <span className="inline-flex items-center justify-center h-8 w-8 rounded-full bg-purple-500">
                        <span className="text-sm font-medium leading-none text-white">C</span>
                      </span>
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-medium text-gray-900 truncate">New customer added</p>
                      <p className="text-sm text-gray-500 truncate">Innovation Hub registered</p>
                    </div>
                    <div className="flex-shrink-0 text-sm text-gray-500">1d ago</div>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
}