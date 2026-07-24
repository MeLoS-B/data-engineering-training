


-- Total paid revenue from payments where payment_status = paid.
SELECT SUM(amount) AS total_paid_revenue
FROM payments
WHERE payment_status = 'paid';




-- Paid revenue by company.
SELECT 
    c.company_name,
    SUM(p.amount) AS paid_revenue
FROM companies c
INNER JOIN subscriptions s 
    ON c.company_id = s.company_id
INNER JOIN payments p 
    ON s.subscription_id = p.subscription_id
WHERE p.payment_status = 'paid'
GROUP BY c.company_name;


-- Paid revenue by plan.
SELECT SUM(amount) as total_revenue,plans.plan_name,plans.plan_id FROM plans INNER JOIN subscriptions ON plans.plan_id = subscriptions.plan_id
INNER JOIN payments ON subscriptions.subscription_id = payments.subscription_id
GROUP BY plans.plan_id


-- Number of active subscriptions by plan.

SELECT COUNT(subscriptions.subscription_id) AS total_active,plans.plan_name FROM subscriptions INNER JOIN plans ON subscriptions.plan_id = plans.plan_id
WHERE subscriptions.status = 'active'
GROUP BY plans.plan_id



-- Number of users by company.
SELECT COUNT(*) AS total_users_per_company,companies.company_name FROM users INNER JOIN companies ON users.company_id = companies.company_id
GROUP BY companies.company_id


-- Support tickets by company.
SELECT COUNT(*) AS tickets_per_company,companies.company_name FROM support_tickets INNER JOIN users ON support_tickets.user_id = users.user_id
INNER JOIN companies ON users.company_id = companies.company_id
GROUP BY companies.company_id


-- Open support tickets by priority.
SELECT 
    priority,
    COUNT(ticket_id) AS open_tickets
FROM support_tickets
WHERE status = 'Open'
GROUP BY priority;


-- Companies with active subscriptions but unpaid/pending payments.

SELECT * FROM companies INNER JOIN subscriptions ON companies.company_id = subscriptions.company_id
INNER JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE subscriptions.status = 'active' AND payments.payment_status IN ('pending','failed')




-- Top 5 companies by paid revenue.

SELECT SUM(payments.amount) AS total_revenue,companies.company_name FROM companies INNER JOIN subscriptions ON companies.company_id = subscriptions.company_id
INNER JOIN payments ON subscriptions.subscription_id = payments.subscription_id
GROUP BY companies.company_name
ORDER BY total_revenue DESC
LIMIT 5;


-- Average payment amount by plan.

SELECT AVG(amount) AS average,plans.plan_name FROM payments INNER JOIN subscriptions ON payments.subscription_id = subscriptions.subscription_id
INNER JOIN plans ON subscriptions.plan_id = plans.plan_id
GROUP BY plans.plan_id


-- Companies with the highest number of support tickets.

SELECT COUNT(*) AS total_support_tickets,companies.company_name FROM companies INNER JOIN users ON companies.company_id = users.company_id
INNER JOIN support_tickets ON support_tickets.user_id = users.user_id
GROUP BY companies.company_id


-- A final executive summary query combining company, plan, revenue and ticket count.
SELECT 
    c.company_name,
    p.plan_name,
    COALESCE(SUM(CASE 
        WHEN pay.payment_status = 'paid' 
        THEN pay.amount 
        ELSE 0 
    END), 0) AS paid_revenue,
    COUNT(DISTINCT st.ticket_id) AS total_tickets
FROM companies c

LEFT JOIN subscriptions s
    ON c.company_id = s.company_id

LEFT JOIN plans p
    ON s.plan_id = p.plan_id

LEFT JOIN payments pay
    ON s.subscription_id = pay.subscription_id

LEFT JOIN users u
    ON c.company_id = u.company_id

LEFT JOIN support_tickets st
    ON u.user_id = st.user_id

GROUP BY 
    c.company_name,
    p.plan_name;





-- advanced challenge


CREATE TABLE features (
    feature_id INT PRIMARY KEY AUTO_INCREMENT,
    feature_name VARCHAR(100) NOT NULL UNIQUE
);


INSERT INTO features (feature_name)
VALUES
('Advanced Analytics'),
('API Access'),
('Priority Support'),
('Custom Reports'),
('Unlimited Users');


CREATE TABLE subscription_features (
    subscription_id INT,
    feature_id INT,

    PRIMARY KEY(subscription_id, feature_id),

    FOREIGN KEY(subscription_id)
        REFERENCES subscriptions(subscription_id),

    FOREIGN KEY(feature_id)
        REFERENCES features(feature_id),

    CONSTRAINT unique_subscription_feature
        UNIQUE(subscription_id, feature_id)
);


INSERT INTO subscription_features
(subscription_id, feature_id)
VALUES

-- TechNova Business plan
(1,1),
(1,2),
(1,3),

-- BuildPro Starter plan
(2,3),

-- HealthPlus Enterprise plan
(3,1),
(3,2),
(3,3),
(3,4),
(3,5),

-- RetailHub Starter plan
(5,2);


SELECT
    s.subscription_id,
    f.feature_name
FROM subscription_features sf
INNER JOIN subscriptions s
    ON sf.subscription_id = s.subscription_id
INNER JOIN features f
    ON sf.feature_id = f.feature_id;


    SELECT
    s.subscription_id,
    COUNT(f.feature_id) AS total_features
FROM subscriptions s
INNER JOIN subscription_features sf
    ON s.subscription_id = sf.subscription_id
INNER JOIN features f
    ON sf.feature_id = f.feature_id
GROUP BY s.subscription_id;



SELECT
    c.company_name,
    p.plan_name,
    f.feature_name
FROM companies c

INNER JOIN subscriptions s
    ON c.company_id = s.company_id

INNER JOIN plans p
    ON s.plan_id = p.plan_id

INNER JOIN subscription_features sf
    ON s.subscription_id = sf.subscription_id

INNER JOIN features f
    ON sf.feature_id = f.feature_id

WHERE s.status = 'active'

ORDER BY c.company_name;