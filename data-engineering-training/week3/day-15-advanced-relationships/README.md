# SaaS Subscription Management Database

## Project Goal

The goal of this project is to design and build a relational database for managing a SaaS (Software as a Service) subscription platform.

The database stores information about companies, their users, subscription plans, payments, and customer support activity.

The main purpose is to maintain accurate business data and allow companies to generate reports about revenue, subscriptions, customer activity, and support performance.

---

# Business Scenario

A SaaS company provides software services to multiple businesses.

Each company can:
- Have multiple users.
- Subscribe to different plans.
- Make monthly payments.
- Receive different product features depending on their subscription.
- Create support tickets when they need help.

The database helps the business answer questions like:

- Which companies generate the most revenue?
- Which subscription plans are most popular?
- How many active subscriptions exist?
- Which companies have unpaid payments?
- How many support issues are open?
- Which features belong to each subscription?

---

# Database Tables

The database contains the following tables:

---

## 1. Companies Table

### Purpose:
Stores information about customer companies using the SaaS platform.

### Columns:
- `company_id` - Unique identifier for each company.
- `company_name` - Name of the company.
- `city` - Company location.
- `industry` - Business industry.

### Example:
A company like TechNova or HealthPlus.

---

## 2. Users Table

### Purpose:
Stores employees/users belonging to companies.

### Columns:
- `user_id` - Unique identifier for each user.
- `company_id` - Connects users to companies.
- `full_name` - User name.
- `email` - Unique email address.
- `role` - User role.
- `is_active` - Shows whether the user account is active.

---

## 3. Plans Table

### Purpose:
Stores available subscription plans.

### Columns:
- `plan_id` - Unique identifier.
- `plan_name` - Name of the subscription plan.
- `monthly_price` - Monthly cost.
- `max_users` - Maximum allowed users.

Examples:
- Starter
- Business
- Enterprise

---

## 4. Subscriptions Table

### Purpose:
Stores subscriptions purchased by companies.

### Columns:
- `subscription_id` - Unique identifier.
- `company_id` - Company owning the subscription.
- `plan_id` - Selected subscription plan.
- `start_date` - Subscription start date.
- `status` - Current subscription state.

Possible statuses:
- active
- paused
- cancelled

---

## 5. Payments Table

### Purpose:
Stores payment transactions made for subscriptions.

### Columns:
- `payment_id` - Unique payment identifier.
- `subscription_id` - Subscription being paid.
- `payment_date` - Date of payment.
- `amount` - Payment amount.
- `payment_status` - Payment result.

Possible statuses:
- paid
- pending
- failed

---

## 6. Support Tickets Table

### Purpose:
Stores customer support requests.

### Columns:
- `ticket_id`
- `user_id`
- `issue_type`
- `priority`
- `status`
- `created_date`

Priority levels:
- Low
- Medium
- High
- Critical

---

## 7. Features Table

### Purpose:
Stores available SaaS features.

Examples:
- API Access
- Advanced Analytics
- Custom Reports

---

## 8. Subscription Features Table

### Purpose:
Bridge table that creates a many-to-many relationship between subscriptions and features.

A subscription can have many features.

A feature can belong to many subscriptions.

---

# Primary Keys

Primary keys were created because every record needs a unique identifier.

Primary keys:

| Table | Primary Key |
|-|-|
| companies | company_id |
| users | user_id |
| plans | plan_id |
| subscriptions | subscription_id |
| payments | payment_id |
| support_tickets | ticket_id |
| features | feature_id |

The `subscription_features` table uses a composite primary key:

```
(subscription_id, feature_id)
```

This prevents duplicate subscription-feature combinations.

---

# Foreign Keys

Foreign keys protect relationships between tables.

Relationships:

```
companies
    |
    | 1-to-many
    |
users
```

One company can have many users.


```
companies
    |
    | 1-to-many
    |
subscriptions
```

A company can have multiple subscriptions.


```
plans
    |
    | 1-to-many
    |
subscriptions
```

One plan can be used by many companies.


```
subscriptions
    |
    | 1-to-many
    |
payments
```

One subscription can have multiple payments.


```
users
    |
    | 1-to-many
    |
support_tickets
```

One user can create multiple tickets.

---

# Constraints Used

Constraints were added to improve data quality.

## NOT NULL

Used for required information.

Examples:

- Company name cannot be empty.
- User name cannot be empty.
- Ticket priority cannot be empty.

---

## UNIQUE

Used to prevent duplicate values.

Examples:

```sql
company_name UNIQUE
email UNIQUE
plan_name UNIQUE
```

A user cannot register the same email twice.

---

## CHECK Constraints

Used to restrict allowed values.

Examples:

Users:

```sql
is_active IN (0,1)
```

Subscription status:

```sql
active, paused, cancelled
```

Payment status:

```sql
paid, pending, failed
```

Ticket priority:

```sql
Low, Medium, High, Critical
```

---

# Invalid Data Rejected

The database successfully rejects:

## Invalid company relationship

```sql
company_id = 999
```

because the company does not exist.

---

## Duplicate email

```sql
john@technova.com
```

cannot be inserted twice.

---

## Negative plan price

```sql
monthly_price = -50
```

is rejected.

---

## Invalid payment status

```sql
payment_status = 'processing'
```

is rejected.

---

## Invalid subscription status

```sql
status = 'expired'
```

is rejected.

---

# Important JOIN Queries

## 1. Paid Revenue by Company

Shows total revenue generated by each company.

```sql
SELECT 
c.company_name,
SUM(p.amount)
FROM companies c
JOIN subscriptions s
ON c.company_id = s.company_id
JOIN payments p
ON s.subscription_id = p.subscription_id
WHERE p.payment_status='paid'
GROUP BY c.company_name;
```

---

## 2. Active Subscriptions by Plan

Shows which plans are currently active.

```sql
SELECT
p.plan_name,
COUNT(s.subscription_id)
FROM plans p
JOIN subscriptions s
ON p.plan_id=s.plan_id
WHERE s.status='active'
GROUP BY p.plan_name;
```

---

## 3. Executive Summary Report

Combines:

- Company
- Subscription plan
- Revenue
- Support tickets

This gives management a complete business overview.

---

# Business Insights From Reports

The database can provide insights such as:

- Which customers generate the highest revenue.
- Which subscription plans are most successful.
- Which companies have unpaid payments.
- Which customers require more support.
- Which features are most commonly used.

These reports help the company make better decisions about pricing, customer success, and product development.

---

# What I Can Explain Live

During a presentation, I can explain:

1. How the database was designed.
2. Why each table exists.
3. How primary keys identify records.
4. How foreign keys protect relationships.
5. Why constraints prevent bad data.
6. How JOIN queries combine information from multiple tables.
7. How the bridge table creates a many-to-many relationship.
8. How reports transform raw data into business insights.

---

# Conclusion

This database demonstrates a complete SaaS management system using relational database principles.

It includes:
- Data modeling
- Relationships
- Constraints
- Seed data
- Validation testing
- Reporting queries
- Many-to-many relationships

The design focuses on maintaining accurate data while supporting real business analysis.