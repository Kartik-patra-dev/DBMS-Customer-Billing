-- Sample Data for Testing

-- Insert Sample Admin User
-- Password: admin123 (hashed with bcrypt - replace with actual hash)
INSERT INTO users (username, email, password, full_name, role) 
VALUES 
    ('admin', 'admin@example.com', '$2b$10$YourHashedPasswordHere', 'Admin User', 'admin'),
    ('operator1', 'operator1@example.com', '$2b$10$YourHashedPasswordHere', 'Operator One', 'operator');

-- Insert Sample Customers
INSERT INTO customers (customer_id, name, phone, email, address, city, state, postal_code, land_area, pump_type, connection_date, created_by)
VALUES 
    ('CUST001', 'Raj Kumar Singh', '9876543210', 'raj@example.com', '123 Farm Lane', 'Bangalore', 'Karnataka', '560001', 5.5, 'HP 2', '2025-01-15', 1),
    ('CUST002', 'Priya Sharma', '9876543211', 'priya@example.com', '456 Agriculture Road', 'Mumbai', 'Maharashtra', '400001', 7.2, 'HP 3', '2025-02-10', 1),
    ('CUST003', 'Ravi Patel', '9876543212', 'ravi@example.com', '789 Village Path', 'Ahmedabad', 'Gujarat', '380001', 4.8, 'HP 2', '2025-03-05', 1),
    ('CUST004', 'Anjali Verma', '9876543213', 'anjali@example.com', '321 Green Field', 'Delhi', 'Delhi', '110001', 6.0, 'HP 3', '2025-03-20', 1),
    ('CUST005', 'Vikram Singh', '9876543214', 'vikram@example.com', '654 Farm District', 'Jaipur', 'Rajasthan', '302001', 8.5, 'HP 5', '2025-04-01', 1);

-- Insert Sample Pump Usage
INSERT INTO pump_usage (customer_id, usage_date, hours_used, units_consumed)
VALUES 
    (1, '2026-05-01', 8.5, 42.5),
    (1, '2026-05-02', 7.0, 35.0),
    (1, '2026-05-03', 9.0, 45.0),
    (2, '2026-05-01', 6.5, 32.5),
    (2, '2026-05-02', 8.0, 40.0),
    (2, '2026-05-03', 7.5, 37.5),
    (3, '2026-05-01', 5.5, 27.5),
    (3, '2026-05-02', 6.0, 30.0),
    (4, '2026-05-01', 10.0, 50.0),
    (5, '2026-05-01', 12.0, 60.0);

-- Insert Sample Billing Records
INSERT INTO billing (bill_id, customer_id, billing_period_start, billing_period_end, total_usage, rate_per_unit, subtotal, tax_amount, total_amount, bill_status, issue_date, due_date, created_by)
VALUES 
    ('BILL001', 1, '2026-05-01', '2026-05-31', 122.5, 5.00, 612.50, 30.63, 643.13, 'issued', '2026-05-31', '2026-06-15', 1),
    ('BILL002', 2, '2026-05-01', '2026-05-31', 110.0, 5.00, 550.00, 27.50, 577.50, 'issued', '2026-05-31', '2026-06-15', 1),
    ('BILL003', 3, '2026-05-01', '2026-05-31', 57.5, 5.00, 287.50, 14.38, 301.88, 'pending', '2026-05-31', '2026-06-15', 1),
    ('BILL004', 4, '2026-05-01', '2026-05-31', 50.0, 5.00, 250.00, 12.50, 262.50, 'pending', '2026-05-31', '2026-06-15', 1),
    ('BILL005', 5, '2026-05-01', '2026-05-31', 60.0, 5.00, 300.00, 15.00, 315.00, 'pending', '2026-05-31', '2026-06-15', 1),
    ('BILL006', 1, '2026-04-01', '2026-04-30', 120.0, 5.00, 600.00, 30.00, 630.00, 'issued', '2026-04-30', '2026-05-15', 1),
    ('BILL007', 2, '2026-04-01', '2026-04-30', 105.0, 5.00, 525.00, 26.25, 551.25, 'issued', '2026-04-30', '2026-05-15', 1);

-- Insert Sample Payments
INSERT INTO payments (payment_id, bill_id, customer_id, payment_amount, payment_date, payment_method, payment_status, recorded_by)
VALUES 
    ('PAY001', 1, 1, 643.13, '2026-06-10', 'transfer', 'completed', 1),
    ('PAY002', 2, 2, 577.50, '2026-06-05', 'cash', 'completed', 1),
    ('PAY003', 6, 1, 630.00, '2026-05-10', 'cheque', 'completed', 1),
    ('PAY004', 7, 2, 551.25, '2026-05-08', 'transfer', 'completed', 1);
