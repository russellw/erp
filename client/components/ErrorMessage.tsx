'use client';

import { useState } from 'react';

interface ErrorMessageProps {
  message: string;
  onDismiss?: () => void;
}

export default function ErrorMessage({ message, onDismiss }: ErrorMessageProps) {
  const [copied, setCopied] = useState(false);

  const copyToClipboard = async () => {
    try {
      await navigator.clipboard.writeText(message);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch (err) {
      console.error('Failed to copy to clipboard:', err);
    }
  };

  return (
    <div className="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-md flex items-start justify-between">
      <div className="flex-1 mr-2">
        <p className="text-sm">{message}</p>
      </div>
      <div className="flex items-center space-x-2">
        <button
          onClick={copyToClipboard}
          className="inline-flex items-center p-1 text-red-400 hover:text-red-600 transition-colors"
          title="Copy error message"
        >
          {copied ? (
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7" />
            </svg>
          ) : (
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z" />
            </svg>
          )}
        </button>
        {onDismiss && (
          <button
            onClick={onDismiss}
            className="inline-flex items-center p-1 text-red-400 hover:text-red-600 transition-colors"
            title="Dismiss error"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        )}
      </div>
    </div>
  );
}