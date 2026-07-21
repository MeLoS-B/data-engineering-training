# ERD Explanation

## 1. What are the main entities in this project?

The main entities are:
- Customers
- Products
- Orders
- Order Items

Each entity represents a different part of the business and stores its own type of information.

---

## 2. Which table should store customers?

The **customers** table should store all customer information, such as:
- customer_id
- customer_name
- city
- segment

Each customer should only be stored once.

---

## 3. Which table should store products?

The **products** table should store all product information, including:
- product_id
- product_name
- category
- price

Each product should only have one record.

---

## 4. Which table should store orders?

The **orders** table should store information about each order, such as:
- order_id
- customer_id
- order_date
- status
- channel

The customer_id links each order to the customer who placed it.

---

## 5. Why should orders not repeat all customer and product details directly?

Repeating customer and product information in every order would create duplicate data. If a customer's city or a product's price changes, we would have to update many rows. By storing only IDs, the database stays organized, uses less storage, and is easier to maintain.

---

## 6. What is the relationship between customers and orders?

The relationship is **one-to-many (1:N)**.

- One customer can place many orders.
- Each order belongs to only one customer.

---

## 7. What is the relationship between orders and products?

The relationship is **many-to-many (M:N)**.

- One order can contain many products.
- One product can appear in many different orders.

This relationship cannot be stored directly, so another table is needed.

---

## 8. Why do we need an order_items table?

The **order_items** table acts as a bridge between orders and products.

It stores:
- order_item_id
- order_id
- product_id
- quantity

This allows:
- One order to contain multiple products.
- One product to appear in multiple orders.
- The quantity of each product in an order to be recorded.

Without the order_items table, it would not be possible to correctly represent orders containing multiple products.     




What are the main entities in this project?
The main entities are customers, products, orders, and order_items.
Which table should store customers?
The customers table should store all customer information, such as customer ID, name, email, and phone number.
Which table should store products?
The products table should store all product information, such as product ID, product name, category, and price.
Which table should store orders?
The orders table should store information about each order, such as order ID, customer ID, order date, status, and sales channel.
Why should orders not repeat all customer and product details directly?
Orders should not repeat customer and product details because it creates duplicate data. Storing the data only once makes the database easier to maintain, saves space, and keeps the information consistent.
What is the relationship between customers and orders?
One customer can have many orders, but each order belongs to only one customer. This is a one-to-many (1:N) relationship.
What is the relationship between orders and products?
One order can contain many products, and one product can appear in many different orders. This is a many-to-many (M:N) relationship.
Why do we need an order_items table?
We need an order_items table because it connects orders and products. It stores which products belong to each order, along with details like quantity and price for each item. This allows one order to contain multiple products and one product to be included in many orders.