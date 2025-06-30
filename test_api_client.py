#!/usr/bin/env python3
"""
Test client for ERP API server.
Tests all available endpoints and validates responses.
"""

import requests
import json
import sys
import os
from typing import Dict, Any, Optional
import argparse

class ERPAPIClient:
    def __init__(self, base_url: str = "http://localhost:8080"):
        self.base_url = base_url.rstrip('/')
        self.session = requests.Session()
        self.token = None
    
    def _make_request(self, method: str, endpoint: str, data: Optional[Dict] = None, 
                     params: Optional[Dict] = None) -> requests.Response:
        """Make HTTP request with error handling."""
        url = f"{self.base_url}{endpoint}"
        headers = {"Content-Type": "application/json"}
        
        if self.token:
            headers["Authorization"] = f"Bearer {self.token}"
        
        try:
            if method.upper() == "GET":
                response = self.session.get(url, headers=headers, params=params)
            elif method.upper() == "POST":
                response = self.session.post(url, headers=headers, json=data)
            elif method.upper() == "PUT":
                response = self.session.put(url, headers=headers, json=data)
            elif method.upper() == "DELETE":
                response = self.session.delete(url, headers=headers)
            else:
                raise ValueError(f"Unsupported HTTP method: {method}")
            
            return response
        except requests.exceptions.RequestException as e:
            print(f"❌ Request failed: {e}")
            raise

    def test_health_check(self) -> bool:
        """Test health check endpoint."""
        print("🏥 Testing health check...")
        try:
            response = self._make_request("GET", "/health")
            if response.status_code == 200:
                data = response.json()
                print(f"   ✅ Health check passed: {data}")
                return True
            else:
                print(f"   ❌ Health check failed: {response.status_code}")
                return False
        except Exception as e:
            print(f"   ❌ Health check error: {e}")
            return False

    def test_auth_login(self, username: str = "admin", password: str = "password") -> bool:
        """Test authentication login."""
        print("🔐 Testing authentication...")
        try:
            login_data = {
                "username": username,
                "password": password
            }
            response = self._make_request("POST", "/api/v1/auth/login", data=login_data)
            
            if response.status_code == 200:
                data = response.json()
                self.token = data.get("token")
                print(f"   ✅ Login successful: {data.get('user', {}).get('username')}")
                return True
            else:
                print(f"   ❌ Login failed: {response.status_code} - {response.text}")
                return False
        except Exception as e:
            print(f"   ❌ Login error: {e}")
            return False

    def test_auth_me(self) -> bool:
        """Test get current user endpoint."""
        print("👤 Testing get current user...")
        try:
            response = self._make_request("GET", "/api/v1/auth/me")
            
            if response.status_code == 200:
                data = response.json()
                print(f"   ✅ Current user: {data.get('username')}")
                return True
            else:
                print(f"   ❌ Get current user failed: {response.status_code}")
                return False
        except Exception as e:
            print(f"   ❌ Get current user error: {e}")
            return False

    def test_users_list(self) -> bool:
        """Test list users endpoint."""
        print("👥 Testing list users...")
        try:
            response = self._make_request("GET", "/api/v1/users")
            
            if response.status_code == 200:
                data = response.json()
                print(f"   ✅ Users list retrieved: {len(data) if isinstance(data, list) else 'N/A'} users")
                return True
            else:
                print(f"   ❌ List users failed: {response.status_code}")
                return False
        except Exception as e:
            print(f"   ❌ List users error: {e}")
            return False

    def test_companies_list(self) -> bool:
        """Test list companies endpoint."""
        print("🏢 Testing list companies...")
        try:
            response = self._make_request("GET", "/api/v1/companies")
            
            if response.status_code == 200:
                data = response.json()
                print(f"   ✅ Companies list retrieved: {len(data) if isinstance(data, list) else 'N/A'} companies")
                return True
            else:
                print(f"   ❌ List companies failed: {response.status_code}")
                return False
        except Exception as e:
            print(f"   ❌ List companies error: {e}")
            return False

    def test_customers_list(self) -> bool:
        """Test list customers endpoint."""
        print("👥 Testing list customers...")
        try:
            response = self._make_request("GET", "/api/v1/customers")
            
            if response.status_code == 200:
                data = response.json()
                count = len(data) if isinstance(data, list) else 'N/A'
                print(f"   ✅ Customers list retrieved: {count} customers")
                if isinstance(data, list) and len(data) > 0:
                    print(f"      Sample customer fields: {list(data[0].keys())}")
                return True
            else:
                print(f"   ❌ List customers failed: {response.status_code} - {response.text}")
                return False
        except Exception as e:
            print(f"   ❌ List customers error: {e}")
            return False

    def test_products_list(self) -> bool:
        """Test list products endpoint."""
        print("📦 Testing list products...")
        try:
            response = self._make_request("GET", "/api/v1/products")
            
            if response.status_code == 200:
                data = response.json()
                count = len(data) if isinstance(data, list) else 'N/A'
                print(f"   ✅ Products list retrieved: {count} products")
                if isinstance(data, list) and len(data) > 0:
                    print(f"      Sample product fields: {list(data[0].keys())}")
                return True
            else:
                print(f"   ❌ List products failed: {response.status_code} - {response.text}")
                return False
        except Exception as e:
            print(f"   ❌ List products error: {e}")
            return False

    def test_not_implemented_endpoints(self) -> bool:
        """Test endpoints that return 'Not implemented yet'."""
        print("🚧 Testing not-implemented endpoints...")
        endpoints = [
            "/api/v1/sales-orders",
            "/api/v1/invoices"
        ]
        
        all_passed = True
        for endpoint in endpoints:
            try:
                response = self._make_request("GET", endpoint)
                if response.status_code == 501:  # Not Implemented
                    print(f"   ✅ {endpoint}: Not implemented (expected)")
                else:
                    print(f"   ❌ {endpoint}: Expected 501, got {response.status_code}")
                    all_passed = False
            except Exception as e:
                print(f"   ❌ {endpoint}: Error - {e}")
                all_passed = False
        
        return all_passed

    def test_invalid_endpoints(self) -> bool:
        """Test invalid endpoints return 404."""
        print("🔍 Testing invalid endpoints...")
        invalid_endpoints = [
            "/api/v1/nonexistent",
            "/api/v1/users/invalid-id",
            "/invalid/path"
        ]
        
        all_passed = True
        for endpoint in invalid_endpoints:
            try:
                response = self._make_request("GET", endpoint)
                if response.status_code == 404:
                    print(f"   ✅ {endpoint}: 404 (expected)")
                else:
                    print(f"   ❌ {endpoint}: Expected 404, got {response.status_code}")
                    all_passed = False
            except Exception as e:
                print(f"   ❌ {endpoint}: Error - {e}")
                all_passed = False
        
        return all_passed

    def test_cors_headers(self) -> bool:
        """Test CORS headers are present."""
        print("🌐 Testing CORS headers...")
        try:
            response = self._make_request("GET", "/health")
            cors_headers = [
                "Access-Control-Allow-Origin",
                "Access-Control-Allow-Methods",
                "Access-Control-Allow-Headers"
            ]
            
            missing_headers = []
            for header in cors_headers:
                if header not in response.headers:
                    missing_headers.append(header)
            
            if not missing_headers:
                print("   ✅ All CORS headers present")
                return True
            else:
                print(f"   ❌ Missing CORS headers: {missing_headers}")
                return False
        except Exception as e:
            print(f"   ❌ CORS test error: {e}")
            return False

    def run_all_tests(self) -> bool:
        """Run all tests and return overall success."""
        print("🧪 ERP API Test Suite")
        print("=" * 50)
        
        tests = [
            self.test_health_check,
            self.test_auth_login,
            self.test_auth_me,
            self.test_users_list,
            self.test_companies_list,
            self.test_customers_list,
            self.test_products_list,
            self.test_not_implemented_endpoints,
            self.test_invalid_endpoints,
            self.test_cors_headers
        ]
        
        passed = 0
        total = len(tests)
        
        for test in tests:
            try:
                if test():
                    passed += 1
                print()  # Empty line between tests
            except Exception as e:
                print(f"   ❌ Test failed with exception: {e}")
                print()
        
        print("=" * 50)
        print(f"📊 Test Results: {passed}/{total} tests passed")
        
        if passed == total:
            print("🎉 All tests passed!")
            return True
        else:
            print("❌ Some tests failed!")
            return False

def main():
    parser = argparse.ArgumentParser(description='Test ERP API server')
    parser.add_argument('--url', default='http://localhost:8080', 
                       help='Base URL of the ERP API server (default: http://localhost:8080)')
    parser.add_argument('--username', default='admin', 
                       help='Username for authentication (default: admin)')
    parser.add_argument('--password', default='password', 
                       help='Password for authentication (default: password)')
    parser.add_argument('--health-only', action='store_true', 
                       help='Only run health check test')
    
    args = parser.parse_args()
    
    print(f"🔗 Testing ERP API at: {args.url}")
    print(f"👤 Using credentials: {args.username}")
    print()
    
    client = ERPAPIClient(args.url)
    
    if args.health_only:
        success = client.test_health_check()
    else:
        success = client.run_all_tests()
    
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()