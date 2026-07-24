USE schemadb;

-- ==========================
-- COMPANIES (5)
-- ==========================

INSERT INTO companies (company_name, city, industry)
VALUES
('TechNova', 'Prishtina', 'Software'),
('BuildPro', 'Prizren', 'Construction'),
('HealthPlus', 'Peja', 'Healthcare'),
('EduSmart', 'Gjilan', 'Education'),
('RetailHub', 'Mitrovica', 'Retail');

-- ==========================
-- PLANS (3)
-- ==========================

INSERT INTO plans (plan_name, monthly_price, max_users)
VALUES
('Starter', 29.99, 10),
('Business', 79.99, 50),
('Enterprise', 199.99, 500);

-- ==========================
-- USERS (12)
-- ==========================

INSERT INTO users (company_id, full_name, email, role, is_active)
VALUES
(1,'John Smith','john@technova.com','Admin',1),
(1,'Sarah Johnson','sarah@technova.com','Manager',1),
(1,'David Brown','david@technova.com','Employee',1),

(2,'Emily Wilson','emily@buildpro.com','Admin',1),
(2,'Michael Davis','michael@buildpro.com','Engineer',1),

(3,'Anna Taylor','anna@healthplus.com','Admin',1),
(3,'James Moore','james@healthplus.com','Doctor',0),

(4,'Sophia White','sophia@edusmart.com','Admin',1),
(4,'Daniel Harris','daniel@edusmart.com','Teacher',1),

(5,'Olivia Martin','olivia@retailhub.com','Admin',1),
(5,'William Clark','william@retailhub.com','Cashier',1),
(5,'Emma Lewis','emma@retailhub.com','Manager',0);

-- ==========================
-- SUBSCRIPTIONS (6)
-- ==========================

INSERT INTO subscriptions (company_id, plan_id, start_date, status)
VALUES
(1,2,'2025-01-10','active'),
(2,1,'2025-02-15','paused'),
(3,3,'2025-03-01','active'),
(4,2,'2025-04-05','cancelled'),
(5,1,'2025-05-20','active'),
(2,3,'2025-06-10','cancelled');

-- ==========================
-- PAYMENTS (12)
-- ==========================

INSERT INTO payments (subscription_id,payment_date,amount,payment_status)
VALUES
(1,'2025-02-10',80,'paid'),
(1,'2025-03-10',80,'paid'),
(1,'2025-04-10',80,'pending'),

(2,'2025-03-15',30,'paid'),
(2,'2025-04-15',30,'failed'),

(3,'2025-04-01',200,'paid'),
(3,'2025-05-01',200,'paid'),
(3,'2025-06-01',200,'paid'),

(4,'2025-05-05',80,'failed'),

(5,'2025-06-20',30,'paid'),
(5,'2025-07-20',30,'pending'),

(6,'2025-07-10',200,'failed');

-- ==========================
-- SUPPORT TICKETS (12)
-- ==========================

INSERT INTO support_tickets
(user_id,issue_type,priority,status,created_date)
VALUES
(1,'Login issue','High','Resolved','2025-06-01'),
(1,'Password reset','Low','Closed','2025-06-05'),

(2,'Billing question','Medium','Open','2025-06-07'),

(3,'API error','Critical','In Progress','2025-06-09'),
(3,'Dashboard loading','High','Resolved','2025-06-12'),

(4,'Subscription upgrade','Medium','Closed','2025-06-15'),

(5,'Invoice missing','High','Open','2025-06-18'),

(6,'User management','Low','Resolved','2025-06-20'),

(8,'Report export failed','Medium','In Progress','2025-06-25'),

(9,'Email notifications','Low','Closed','2025-06-28'),

(10,'Payment failed','Critical','Open','2025-07-01'),

(11,'Two-factor authentication','Medium','Resolved','2025-07-05');