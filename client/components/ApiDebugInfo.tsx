'use client';

import { useState } from 'react';

interface ApiDebugInfoProps {
  className?: string;
}

export default function ApiDebugInfo({ className = '' }: ApiDebugInfoProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [testResult, setTestResult] = useState<string>('');
  const [testing, setTesting] = useState(false);

  const apiUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api';

  const testConnection = async () => {
    setTesting(true);
    setTestResult('Testing connection...');

    try {
      // Test basic connectivity
      const response = await fetch(apiUrl.replace('/api', '/health'), {
        method: 'GET',
      });
      
      const text = await response.text();
      setTestResult(`Status: ${response.status} ${response.statusText}\nResponse: ${text}`);
    } catch (error) {
      setTestResult(`Connection failed: ${error instanceof Error ? error.message : 'Unknown error'}`);
    }
    
    setTesting(false);
  };

  if (!isOpen) {
    return (
      <button
        onClick={() => setIsOpen(true)}
        className={`fixed bottom-4 right-4 bg-blue-600 hover:bg-blue-700 text-white px-3 py-2 rounded-full text-sm font-medium shadow-lg z-50 ${className}`}
        title="API Debug Info"
      >
        🔧
      </button>
    );
  }

  return (
    <div className="fixed bottom-4 right-4 bg-white border border-gray-300 rounded-lg shadow-xl p-4 w-80 max-h-96 overflow-auto z-50">
      <div className="flex justify-between items-center mb-3">
        <h3 className="text-sm font-medium text-gray-900">API Debug Info</h3>
        <button
          onClick={() => setIsOpen(false)}
          className="text-gray-400 hover:text-gray-600"
        >
          ✕
        </button>
      </div>
      
      <div className="space-y-3 text-xs">
        <div>
          <strong>API Base URL:</strong>
          <div className="font-mono bg-gray-100 p-1 rounded mt-1 break-all">
            {apiUrl}
          </div>
        </div>
        
        <div>
          <strong>Current Page:</strong>
          <div className="font-mono bg-gray-100 p-1 rounded mt-1">
            {typeof window !== 'undefined' ? window.location.pathname : 'N/A'}
          </div>
        </div>
        
        <div>
          <strong>Auth Token:</strong>
          <div className="font-mono bg-gray-100 p-1 rounded mt-1 break-all">
            {typeof window !== 'undefined' ? 
              (localStorage.getItem('token') ? 'Present' : 'Missing') : 'N/A'}
          </div>
        </div>
        
        <div>
          <button
            onClick={testConnection}
            disabled={testing}
            className="w-full bg-blue-600 hover:bg-blue-700 disabled:bg-gray-400 text-white px-3 py-2 rounded text-xs font-medium"
          >
            {testing ? 'Testing...' : 'Test Connection'}
          </button>
        </div>
        
        {testResult && (
          <div>
            <strong>Test Result:</strong>
            <div className="font-mono bg-gray-100 p-2 rounded mt-1 text-xs whitespace-pre-wrap">
              {testResult}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}