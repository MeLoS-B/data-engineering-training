

-- ---------------------------------------------------
-- Test 1
-- Should fail because company_id = 999 does not exist.
-- Foreign Key violation.
-- ---------------------------------------------------

-- INSERT INTO users (company_id, full_name, email, role, is_active)
-- VALUES (999, 'Fake User', 'fake@company.com', 'Admin', 1);



-- ---------------------------------------------------
-- Test 2
-- Should fail because plan_id = 999 does not exist.
-- Foreign Key violation.
-- ---------------------------------------------------

-- INSERT INTO subscriptions (company_id, plan_id, start_date, status)
-- VALUES (1, 999, '2025-08-01', 'active');



-- ---------------------------------------------------
-- Test 3
-- Should fail because email already exists.
-- UNIQUE constraint violation.
-- ---------------------------------------------------

-- INSERT INTO users (company_id, full_name, email, role, is_active)
-- VALUES (2, 'Another John', 'john@technova.com', 'Employee', 1);



-- ---------------------------------------------------
-- Test 4
-- Should fail because monthly_price is negative.
-- CHECK constraint violation.
-- ---------------------------------------------------

-- INSERT INTO plans (plan_name, monthly_price, max_users)
-- VALUES ('Invalid Plan', -25.00, 20);



-- ---------------------------------------------------
-- Test 5
-- Should fail because amount must be greater than 0.
-- CHECK constraint violation.
-- ---------------------------------------------------

-- INSERT INTO payments
-- (subscription_id, payment_date, amount, payment_status)
-- VALUES (1, '2025-08-10', 0, 'paid');



-- ---------------------------------------------------
-- Test 6
-- Should fail because priority is invalid.
-- CHECK constraint violation.
-- ---------------------------------------------------

-- INSERT INTO support_tickets
-- (user_id, issue_type, priority, status, created_date)
-- VALUES (1, 'Testing invalid priority', 'Urgent', 'Open', '2025-08-01');



-- ---------------------------------------------------
-- Test 7
-- Should fail because subscription status is invalid.
-- CHECK constraint violation.
-- ---------------------------------------------------

-- INSERT INTO subscriptions
-- (company_id, plan_id, start_date, status)
-- VALUES (1, 1, '2025-08-01', 'expired');



-- ---------------------------------------------------
-- Test 8
-- Should fail because payment_status is invalid.
-- CHECK constraint violation.
-- ---------------------------------------------------

-- INSERT INTO payments
-- (subscription_id, payment_date, amount, payment_status)
-- VALUES (1, '2025-08-10', 80, 'processing');