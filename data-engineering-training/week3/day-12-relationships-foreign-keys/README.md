# Day 12 - Relationships, Foreign Keys, and JOINs

## Project Goal

The goal of this project is to understand how relational databases store connected information using tables, primary keys, foreign keys, and relationships.

The database models a simple business system where customers can place orders, products can be purchased, and order details are stored using relationships between tables.

The main objectives were:

- Design a normalized database structure
- Create relationships between tables
- Use primary keys and foreign keys correctly
- Test database constraints
- Practice SQL JOIN operations
- Create business reports using SQL queries

---

# Database Tables

The database contains four main tables:

## Customers Table

The `customers` table stores information about customers.

Example columns:

- `customer_id` - Unique identifier for each customer
- `name` - Customer name
- `city` - Customer location


## Products Table

The `products` table stores information about available products.

Example columns:

- `product_id` - Unique identifier for each product
- `product_name` - Name of the product
- `category` - Product category
- `price` - Product price


## Orders Table

The `orders` table stores customer orders.

Example columns:

- `order_id` - Unique identifier for each order
- `customer_id` - Reference to the customer who created the order
- `order_date` - Date of the order
- `status` - Order status
- `channel` - Order source


## Order_Items Table

The `order_items` table connects orders with products.

Example columns:

- `order_item_id` - Unique identifier
- `order_id` - Reference to an order
- `product_id` - Reference to a product
- `quantity` - Amount purchased

The `order_items` table is required because one order can contain multiple products and one product can appear in many orders.

---

# Primary Keys

A primary key is a column that uniquely identifies every row in a table.

In this project:

- `customer_id` is the primary key in the `customers` table.
- `product_id` is the primary key in the `products` table.
- `order_id` is the primary key in the `orders` table.
- `order_item_id` is the primary key in the `order_items` table.

Primary keys:
- Must contain unique values
- Cannot contain NULL values
- Help tables identify specific records

---

# Foreign Keys

A foreign key is a column that connects one table to another table.

The foreign keys used in this project are:

- `orders.customer_id` references `customers.customer_id`
- `order_items.order_id` references `orders.order_id`
- `order_items.product_id` references `products.product_id`

Foreign keys help maintain data accuracy by preventing invalid relationships.

For example, an order cannot be created for a customer that does not exist.

---

# Auto Increment

Auto Increment automatically generates unique IDs when new records are inserted.

Example:

```sql
INSERT INTO customers(name, city)
VALUES ('Arta', 'Vushtrri');
```

The database automatically creates the next `customer_id`.

Auto Increment is useful because:

- It prevents duplicate IDs
- It saves time
- It makes inserting new data safer
- It keeps relationships consistent

In a real database, IDs should not usually be manually selected because automatic ID generation prevents human mistakes.

If a row is deleted, the old ID is not reused. The database continues generating new unique IDs.

A stable ID is better than using values like customer names because names can be duplicated or changed.

---

# Relationships

The database contains these relationships:

## Customers and Orders

Relationship:

```
One Customer -> Many Orders
```

A customer can place multiple orders, but each order belongs to one customer.

This is a one-to-many relationship.

---

## Orders and Products

Relationship:

```
Many Orders -> Many Products
```

An order can contain many products, and a product can appear in many different orders.

This is a many-to-many relationship.

To solve this, the `order_items` table is used as a bridge table.

---

# Valid and Invalid Insert Tests

The database was tested to verify that foreign key constraints work correctly.

## Valid Insert Example

A new order was inserted using an existing `customer_id`.

Expected result:

The database accepts the insert because the customer exists.

---

## Invalid Foreign Key Test

An order was inserted using a `customer_id` that does not exist.

Expected result:

The database rejects the insert because the foreign key constraint is violated.

---

## Invalid Order Item Test

An order item was inserted using an `order_id` that does not exist.

Expected result:

The database rejects the insert because the order does not exist.

---

# INNER JOIN vs LEFT JOIN

## INNER JOIN

`INNER JOIN` returns only rows where matching data exists in both tables.

Example:

```sql
SELECT *
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id;
```

Only customers who have orders will appear.

Customers without orders are removed from the result.

---

## LEFT JOIN

`LEFT JOIN` returns all rows from the first table and matching rows from the second table.

Example:

```sql
SELECT *
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;
```

All customers appear, even if they have no orders.

Missing order information appears as `NULL`.

---

## Main Difference

| INNER JOIN | LEFT JOIN |
|------------|-----------|
| Shows only matching records | Shows all records from the left table |
| Removes unmatched rows | Keeps unmatched rows |
| Used when matching data is required | Used when missing relationships are important |

---

# Business Reports

SQL queries were created to generate business information, including:

- Total number of orders
- Completed order revenue
- Revenue by product
- Revenue by category
- Orders by city
- Customers with multiple orders
- Top selling products

These reports help analyze business performance and customer activity.

---

# What I Can Explain Live

I can explain:

- How primary keys uniquely identify records
- How foreign keys create relationships
- Why normalization is important
- Why order_items is needed for many-to-many relationships
- Difference between INNER JOIN and LEFT JOIN
- How Auto Increment works
- How database constraints prevent invalid data
- How SQL queries generate business reports

---

# What I Would Improve Next

Possible improvements for this database:

- Add more validation rules using CHECK constraints
- Add indexes for faster searches
- Add more product and customer information
- Create views for common reports
- Add stored procedures for repeated operations
- Add triggers for automatic updates
- Connect the database with a backend application
- Create a dashboard for visual business analytics