# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a sketch/prototype of an ERP (Enterprise Resource Planning) system. Based on the .gitignore file, this appears to be intended as a Go project, though the codebase is currently minimal with only basic setup files.

## Development Configuration

- The project will use a Postgres database, which during development will run on localhost
- The name of the database defaults to 'erp'

## Development Commands

Since this is an early-stage Go project, the following commands will likely be relevant once development begins:

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

## Expected Architecture

As an ERP system, this project will likely include modules for:
- User management and authentication
- Financial management (accounting, invoicing, payments)
- Inventory management
- Customer relationship management (CRM)
- Human resources management
- Reporting and analytics

The Go project structure will likely follow standard conventions with packages organized by domain or functionality.