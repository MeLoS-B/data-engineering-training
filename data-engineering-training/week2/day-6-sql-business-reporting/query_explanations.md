# Query Explanations - Day 6 SQL Business Reporting Sprint

## Query 1: Completed revenue by category

**File:** join_reports.sql

**Business question:**
Which product category generated the most completed revenue?

**Tables used:**
orders and products

**Why JOIN is needed:**
The orders table contains the product_id and quantity, but the product category and price are stored in the products table. The JOIN connects these tables so we can calculate revenue by category.

**Why WHERE is needed:**
Only completed orders should be included because pending and cancelled orders are not real revenue.

**Why GROUP BY is needed:**
We need one result row for each product category to compare revenue between categories.

**What I understood:**
This query helps the business understand which categories are generating actual income. It prevents incorrect reporting by excluding orders that are not completed.

---

## Query 2: Completed revenue by product

**File:** join_reports.sql

**Business question:**
Which products generate the most completed revenue?

**Tables used:**
orders and products

**Why JOIN is needed:**
The orders table stores the product_id and quantity, while the products table stores the product name and price. We need both tables to calculate product revenue.

**Why WHERE is needed:**
The query filters only completed orders because only completed sales should increase revenue.

**Why GROUP BY is needed:**
Each product needs its own total revenue calculation.

**What I understood:**
This query shows which products are most valuable for the business and can help managers decide what products should be promoted or stocked more.

---

## Query 3: Top 3 products by completed revenue

**File:** join_reports.sql

**Business question:**
What are the three highest revenue-generating products?

**Tables used:**
orders and products

**Why JOIN is needed:**
The product name and price are not available in orders, so we need product information from the products table.

**Why WHERE is needed:**
Only completed orders are considered because cancelled and pending orders do not represent actual sales.

**Why GROUP BY is needed:**
Revenue must be calculated separately for each product.

**Why ORDER BY and LIMIT are needed:**
ORDER BY sorts products from highest to lowest revenue, and LIMIT returns only the top three products.

**What I understood:**
This query creates a quick ranking of the best-performing products.

---

## Query 4: Pending and cancelled orders report

**File:** join_reports.sql

**Business question:**
Which orders are not completed and what is their potential value?

**Tables used:**
orders, customers, and products

**Why JOIN is needed:**
Orders only contain customer_id and product_id. Customer names, cities, product names, and prices are stored in other tables.

**Why WHERE is needed:**
The query filters only pending and cancelled orders because they should not be counted as completed revenue.

**Why calculation is needed:**
Quantity multiplied by price shows the possible revenue if these orders were completed.

**What I understood:**
This report helps the business identify lost opportunities and understand how much revenue is affected by incomplete orders.

---

## Query 5: Revenue by city

**File:** join_reports.sql

**Business question:**
Which cities generate the most completed revenue?

**Tables used:**
orders, customers, and products

**Why JOIN is needed:**
The city is stored in customers, while order information and prices are stored in orders and products.

**Why WHERE is needed:**
Only completed orders should contribute to revenue.

**Why GROUP BY is needed:**
Revenue needs to be calculated separately for every city.

**What I understood:**
This query helps identify strong markets and where sales activities are performing well.

---

## Query 6: Orders per customer

**File:** customer_reports.sql

**Business question:**
Which customers have placed multiple orders?

**Tables used:**
orders and customers

**Why JOIN is needed:**
The orders table has customer_id, but customer names are stored in the customers table.

**Why GROUP BY is needed:**
Orders must be counted separately for each customer.

**Why HAVING is needed:**
HAVING filters grouped results and allows us to show only customers with more than one order.

**What I understood:**
This query helps identify repeat customers who may be valuable for loyalty programs.

---

## Query 7: Highest spending customer

**File:** customer_reports.sql

**Business question:**
Which customer generated the most completed revenue?

**Tables used:**
orders, customers, and products

**Why JOIN is needed:**
Customer names come from customers, while revenue data comes from orders and products.

**Why WHERE is needed:**
Only completed orders represent real customer spending.

**Why GROUP BY is needed:**
Each customer needs an individual revenue total.

**Why ORDER BY is needed:**
Customers are sorted by revenue to find the highest spender.

**What I understood:**
This query helps managers identify their most valuable customers.

---

## Query 8: Total orders by city

**File:** customer_reports.sql

**Business question:**
Which city has the highest number of orders?

**Tables used:**
orders and customers

**Why JOIN is needed:**
The order location is not stored directly in orders. The city information comes from customers.

**Why GROUP BY is needed:**
Orders need to be counted separately for each city.

**Why COUNT is needed:**
COUNT calculates how many orders exist in each city.

**What I understood:**
This query helps the business understand where customers are most active and where marketing efforts may be useful.
