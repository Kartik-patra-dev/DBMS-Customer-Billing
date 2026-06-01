# Database Schema Documentation

## Overview

The DBMS-Customer-Billing system uses a relational database with the following main tables:

## Entity Relationship Diagram (Conceptual)

```
Users (1) ──── (Many) Customers
Users (1) ──── (Many) Billing
Users (1) ──── (Many) Payments
Users (1) ──── (Many) Audit Logs

Customers (1) ──── (Many) Pump Usage
Customers (1) ──── (Many) Billing
Customers (1) ──── (Many) Payments

Billing (1) ──── (Many) Payments
```

## Table Details

### 1. **users** Table
Stores admin and operator credentials for system access.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique user identifier |
| username | VARCHAR(50) | UNIQUE, NOT NULL | Login username |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Email address |
| password | VARCHAR(255) | NOT NULL | Hashed password (bcrypt) |
| full_name | VARCHAR(100) | | User's full name |
| role | ENUM | DEFAULT 'operator' | 'admin' or 'operator' |
| is_active | BOOLEAN | DEFAULT TRUE | Account status |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | AUTO UPDATE | Last modification timestamp |
| last_login | TIMESTAMP | NULL | Last login timestamp |

**Indexes**: username, email

---

### 2. **customers** Table
Stores customer information and pump connection details.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique customer identifier |
| customer_id | VARCHAR(20) | UNIQUE, NOT NULL | Auto-generated customer code (e.g., CUST001) |
| name | VARCHAR(100) | NOT NULL | Customer's name |
| phone | VARCHAR(15) | NOT NULL | Contact phone number |
| email | VARCHAR(100) | | Email address |
| address | TEXT | | Street address |
| city | VARCHAR(50) | | City name |
| state | VARCHAR(50) | | State/Province |
| postal_code | VARCHAR(10) | | ZIP/Postal code |
| land_area | DECIMAL(10,2) | | Cultivated land area (acres/sq.m) |
| pump_type | VARCHAR(50) | | Type of pump (HP 2, HP 3, etc.) |
| connection_date | DATE | | Date of pump connection |
| is_active | BOOLEAN | DEFAULT TRUE | Customer status |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation date |
| updated_at | TIMESTAMP | AUTO UPDATE | Last update date |
| created_by | INT | FOREIGN KEY (users.id) | User who created the record |

**Indexes**: customer_id, name, phone, created_at

---

### 3. **pump_usage** Table
Tracks pump usage and electricity/water consumption.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique record ID |
| customer_id | INT | FOREIGN KEY (customers.id) | Reference to customer |
| usage_date | DATE | NOT NULL | Date of usage |
| hours_used | DECIMAL(5,2) | | Hours pump was operated |
| units_consumed | DECIMAL(10,2) | | Units consumed (kWh, liters, etc.) |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation date |
| updated_at | TIMESTAMP | AUTO UPDATE | Last update date |

**Indexes**: customer_id, usage_date
**Unique Constraint**: (customer_id, usage_date) - One record per customer per day

---

### 4. **billing** Table
Stores billing records with calculated amounts.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique billing record ID |
| bill_id | VARCHAR(30) | UNIQUE, NOT NULL | Human-readable bill number (BILL001, etc.) |
| customer_id | INT | FOREIGN KEY (customers.id) | Reference to customer |
| billing_period_start | DATE | NOT NULL | Start of billing period |
| billing_period_end | DATE | NOT NULL | End of billing period |
| total_usage | DECIMAL(10,2) | | Total units used in period |
| rate_per_unit | DECIMAL(10,2) | | Rate applied per unit |
| subtotal | DECIMAL(12,2) | | Amount before tax |
| tax_amount | DECIMAL(10,2) | DEFAULT 0 | Tax calculated |
| total_amount | DECIMAL(12,2) | NOT NULL | Final billing amount |
| bill_status | ENUM | DEFAULT 'draft' | 'draft', 'pending', 'issued', 'overdue' |
| issue_date | DATE | | Date bill was issued |
| due_date | DATE | | Payment due date |
| notes | TEXT | | Additional notes |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation date |
| updated_at | TIMESTAMP | AUTO UPDATE | Last update date |
| created_by | INT | FOREIGN KEY (users.id) | User who created the bill |

**Indexes**: bill_id, customer_id, bill_status, issue_date, created_at

---

### 5. **payments** Table
Records payment transactions for bills.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique payment record ID |
| payment_id | VARCHAR(30) | UNIQUE, NOT NULL | Human-readable payment ID (PAY001, etc.) |
| bill_id | INT | FOREIGN KEY (billing.id) | Reference to bill |
| customer_id | INT | FOREIGN KEY (customers.id) | Reference to customer |
| payment_amount | DECIMAL(12,2) | NOT NULL | Amount paid |
| payment_date | DATE | NOT NULL | Date of payment |
| payment_method | ENUM | DEFAULT 'cash' | 'cash', 'cheque', 'transfer', 'card' |
| transaction_id | VARCHAR(100) | | External transaction reference |
| payment_status | ENUM | DEFAULT 'completed' | 'pending', 'completed', 'failed', 'cancelled' |
| reference_note | TEXT | | Additional notes |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation date |
| updated_at | TIMESTAMP | AUTO UPDATE | Last update date |
| recorded_by | INT | FOREIGN KEY (users.id) | User who recorded the payment |

**Indexes**: payment_id, bill_id, customer_id, payment_date, payment_status, created_at

---

### 6. **rates** Table
Stores billing rates for different periods or categories.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique rate ID |
| rate_name | VARCHAR(100) | NOT NULL | Name of rate (e.g., "Summer Rate") |
| rate_per_unit | DECIMAL(10,2) | NOT NULL | Rate per unit |
| effective_from | DATE | NOT NULL | Start date of rate validity |
| effective_to | DATE | | End date of rate validity |
| rate_type | ENUM | DEFAULT 'fixed' | 'fixed', 'variable', 'slab' |
| description | TEXT | | Rate description |
| is_active | BOOLEAN | DEFAULT TRUE | Rate status |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation date |
| updated_at | TIMESTAMP | AUTO UPDATE | Last update date |

**Indexes**: effective_from, is_active

---

### 7. **audit_logs** Table
Records all system activities for security and compliance.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INT | PRIMARY KEY, AUTO_INCREMENT | Log entry ID |
| user_id | INT | FOREIGN KEY (users.id) | User who performed action |
| action | VARCHAR(50) | | Action type (INSERT, UPDATE, DELETE, etc.) |
| entity_type | VARCHAR(50) | | Type of entity affected (customer, billing, etc.) |
| entity_id | INT | | ID of affected entity |
| old_value | TEXT | | Previous value (for updates) |
| new_value | TEXT | | New value (for updates) |
| ip_address | VARCHAR(45) | | IP address of requester |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp of action |

**Indexes**: user_id, created_at, (entity_type, entity_id)

---

### 8. **settings** Table
Stores system configuration and settings.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INT | PRIMARY KEY, AUTO_INCREMENT | Setting ID |
| setting_key | VARCHAR(100) | UNIQUE, NOT NULL | Setting identifier |
| setting_value | TEXT | | Setting value |
| setting_type | ENUM | DEFAULT 'string' | 'string', 'number', 'boolean', 'json' |
| description | TEXT | | Setting description |
| updated_at | TIMESTAMP | AUTO UPDATE | Last modification date |

**Common Settings**:
- `company_name`: Company name for billing
- `tax_rate`: Tax percentage
- `currency`: Currency for billing
- `bill_footer`: Footer text for bills

---

## Sample Queries

### Get Customer with Latest Bill
```sql
SELECT c.*, b.bill_id, b.total_amount, b.bill_status
FROM customers c
LEFT JOIN billing b ON c.id = b.customer_id
WHERE c.customer_id = 'CUST001'
ORDER BY b.issue_date DESC
LIMIT 1;
```

### Get Payment Status for a Customer
```sql
SELECT 
    c.name,
    b.bill_id,
    b.total_amount,
    COALESCE(SUM(p.payment_amount), 0) as paid_amount,
    (b.total_amount - COALESCE(SUM(p.payment_amount), 0)) as pending_amount
FROM customers c
JOIN billing b ON c.id = b.customer_id
LEFT JOIN payments p ON b.id = p.bill_id
WHERE c.customer_id = 'CUST001'
GROUP BY b.id;
```

### Get Usage Summary for Billing Period
```sql
SELECT 
    customer_id,
    SUM(units_consumed) as total_usage,
    AVG(hours_used) as avg_hours
FROM pump_usage
WHERE usage_date BETWEEN '2026-05-01' AND '2026-05-31'
GROUP BY customer_id;
```

### Get Overdue Bills
```sql
SELECT b.bill_id, c.name, b.total_amount, b.due_date
FROM billing b
JOIN customers c ON b.customer_id = c.id
WHERE b.bill_status IN ('issued', 'overdue')
AND b.due_date < CURDATE()
ORDER BY b.due_date;
```

---

## Performance Considerations

1. **Indexing**: All frequently queried columns are indexed
2. **Foreign Keys**: Enforce referential integrity
3. **Timestamps**: Enable tracking and filtering by date
4. **Soft Deletes**: Use `is_active` flag instead of hard deletes
5. **Partitioning**: Consider partitioning `pump_usage` and `billing` tables by date for large datasets

---

## Backup Strategy

1. **Daily Backups**: Automated daily backups to secondary storage
2. **Weekly Full Backup**: Complete database backup
3. **Monthly Archive**: Long-term storage of monthly backups
4. **Transaction Logs**: Enable point-in-time recovery

---

## Data Validation Rules

- **Customer ID**: Auto-generated, unique, non-changeable
- **Phone**: 10-15 digits
- **Email**: Valid email format
- **Amounts**: Non-negative decimals
- **Dates**: Valid dates, billing period end >= start
- **Bill Status**: Only valid enum values
- **Payment Amount**: Cannot exceed bill total

---

**Last Updated**: June 1, 2026
