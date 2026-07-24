


-- Show users together with their company name.
SELECT full_name,company_name FROM users INNER JOIN companies ON users.company_id = companies.company_id



-- Show subscriptions together with company name and plan name.

SELECT subscriptions.subscription_id,start_date,subscriptions.status,company_name,plan_name FROM subscriptions INNER JOIN companies ON subscriptions.company_id = companies.company_id
INNER JOIN plans ON subscriptions.plan_id = plans.plan_id


-- Show payments together with company name, plan name and subscription status.

SELECT * FROM payments INNER JOIN subscriptions ON payments.subscription_id = subscriptions.subscription_id
INNER JOIN companies ON subscriptions.company_id = companies.company_id
INNER JOIN plans ON plans.plan_id = subscriptions.plan_id



-- Show support tickets together with user name, user email and company name.

SELECT support_tickets.ticket_id,issue_type,priority,status,users.full_name,users.email,companies.company_name  FROM support_tickets INNER JOIN users ON support_tickets.user_id = users.user_id
INNER JOIN companies ON users.company_id = companies.company_id


-- Show all companies and their users using LEFT JOIN.
SELECT * FROM companies LEFT JOIN users ON companies.company_id = users.company_id 

-- Show companies that currently have no users.
SELECT * FROM companies LEFT JOIN users ON companies.company_id = users.company_id 
WHERE users.user_id IS NULL


-- Show users that have not opened any support tickets.
SELECT * FROM users LEFT JOIN support_tickets ON users.user_id = support_tickets.user_id
WHERE ticket_id IS NULL


-- Show subscriptions that have no payments yet.
SELECT * FROM subscriptions LEFT JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE payment_id IS NULL


-- Show active subscriptions with pending or failed payments.
SELECT * FROM subscriptions INNER JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE subscriptions.status = 'active' AND payments.payment_status IN ('pending','failed')
