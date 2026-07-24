# Data Quality Notes

## What does each table represent in the business?

### companies
Stores information about each company using the SaaS platform.

### users
Stores employees or users who belong to a company and use the platform.

### plans
Stores the subscription plans offered by the business (Basic, Pro, Enterprise, etc.).

### subscriptions
Stores which subscription plan each company is currently using.

### payments
Stores payment records for subscriptions.

### support_tickets
Stores customer support requests created by users.

---

# Primary Keys

| Table | Primary Key |
|--------|-------------|
| companies | company_id |
| users | user_id |
| plans | plan_id |
| subscriptions | subscription_id |
| payments | payment_id |
| support_tickets | ticket_id |

Each primary key should be:
- UNIQUE
- NOT NULL
- AUTO_INCREMENT

---

# Foreign Keys

| Table | Foreign Key | References |
|--------|-------------|------------|
| users | company_id | companies(company_id) |
| subscriptions | company_id | companies(company_id) |
| subscriptions | plan_id | plans(plan_id) |
| payments | subscription_id | subscriptions(subscription_id) |
| support_tickets | user_id | users(user_id) |

Foreign keys ensure that related records already exist.

---

# Fields that should be NOT NULL

### companies
- company_name
- created_at

### users
- company_id
- first_name
- last_name
- email

### plans
- plan_name
- monthly_price

### subscriptions
- company_id
- plan_id
- start_date
- status

### payments
- subscription_id
- payment_date
- amount
- status

### support_tickets
- user_id
- subject
- status
- created_at

These fields are required for the system to function correctly.

---

# Fields protected with CHECK constraints

### plans
- monthly_price >= 0

### subscriptions
- status IN ('Active', 'Cancelled', 'Expired')

### payments
- amount >= 0
- status IN ('Paid', 'Pending', 'Failed')

### support_tickets
- status IN ('Open', 'In Progress', 'Closed')

CHECK constraints prevent invalid values from being inserted.

---

# One-to-Many Relationships

- One company → Many users
- One company → Many subscriptions
- One plan → Many subscriptions
- One subscription → Many payments
- One user → Many support tickets

---

# Bridge Table

The **subscriptions** table acts as the bridge between companies and plans.

A company can subscribe to different plans over time, and one plan can be used by many companies.

---

# Invalid Data the Database Should Reject

The database should reject:

- Duplicate primary keys.
- Foreign keys that reference records that do not exist.
- NULL values in required fields.
- Negative payment amounts.
- Negative plan prices.
- Invalid subscription statuses.
- Invalid payment statuses.
- Invalid support ticket statuses.
- Duplicate emails if the email column is marked UNIQUE.
- Payments created for subscriptions that do not exist.
- Support tickets created for users that do not exist.

These rules help maintain accurate and consistent data throughout the database.