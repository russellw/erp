# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a sketch/prototype of an ERP (Enterprise Resource Planning) system with:
- **Backend**: Go-based API server
- **Frontend**: React with Next.js client application  
- **Database**: PostgreSQL with comprehensive schema

The codebase currently includes database schema and initialization scripts.

## Development Configuration

- The project will use a Postgres database, which during development will run on localhost
- The name of the database defaults to 'erp'

## Development Commands

### Database
```bash
# Test database connection
python test_db_connection.py

# Initialize database from schema
python init_db.py

# Reset database (drop and recreate)
python init_db.py --drop
```

### Backend (Go)
```bash
# Initialize Go module (if not already done)
go mod init

# Build the application
go build

# Run the application
go run .

# Run tests
go test ./...

# Run tests with coverage
go test -cover ./...

# Format code
go fmt ./...

# Vet code for potential issues
go vet ./...
```

### Frontend (React/Next.js)
```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Start production server
npm start

# Run tests
npm test

# Lint code
npm run lint
```

## Expected Architecture

As an ERP system, this project will likely include modules for:
- User management and authentication
- Financial management (accounting, invoicing, payments)
- Inventory management
- Customer relationship management (CRM)
- Human resources management
- Reporting and analytics

The Go project structure will likely follow standard conventions with packages organized by domain or functionality.