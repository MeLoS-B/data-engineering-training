# Verified Business Report - Day 7 SQL Detective Day

## 1. Total order activity

**Insight:**
The database contains a total of **[X] orders** across all statuses.

**Verified result:**
Total orders: **[X]**

**SQL query used:**
V1 - Count all orders

**Business meaning:**
This shows the overall order activity in the system and gives the business a view of the total number of transactions recorded.

---

## 2. Completed revenue

**Insight:**
Only completed orders are counted as real revenue. Pending and cancelled orders are excluded.

**Verified result:**
Completed revenue: **[X]**

**SQL query used:**
V7 - Calculate completed revenue only

**Business meaning:**
This represents the actual revenue earned by the business because only successfully completed purchases are included.

---

## 3. Revenue by product

**Insight:**
The products generating the highest completed revenue are **[product names]**.

**Verified result:**
Product revenue results:

* [Product 1] → [Revenue]
* [Product 2] → [Revenue]
* [Product 3] → [Revenue]

**SQL query used:**
V8 - Create completed revenue by product_name

**Business meaning:**
This helps identify the best-performing products and supports decisions about inventory, marketing, and sales strategy.

---

## 4. Revenue by category

**Insight:**
The category with the highest completed revenue is **[category name]**.

**Verified result:**
Category revenue results:

* [Category 1] → [Revenue]
* [Category 2] → [Revenue]

**SQL query used:**
V9 - Create completed revenue by category

**Business meaning:**
This shows which product categories contribute the most income and where the business should focus its resources.

---

## 5. Orders by city

**Insight:**
The city with the highest number of orders is **[city name]**.

**Verified result:**
Orders by city:

* [City 1] → [Number of orders]
* [City 2] → [Number of orders]

**SQL query used:**
V10 - Create order count by city

**Business meaning:**
This helps understand customer locations and identify strong markets or areas with growth opportunities.

---

## 6. Customers with more than one order

**Insight:**
Some customers have placed multiple orders, showing repeat purchasing behavior.

**Verified result:**
Customers with more than one order:

* [Customer name] → [Number of orders]

**SQL query used:**
V11 - Find customers with more than one order

**Business meaning:**
Repeat customers are valuable because they show customer loyalty and can be targeted with retention strategies.

---

## 7. Orders not counted as revenue

**Insight:**
Orders with pending or cancelled status should not be included in real revenue calculations.

**Verified result:**
Non-revenue orders:

* Pending orders: [X]
* Cancelled orders: [X]

**SQL query used:**
V3 - Count pending orders
V4 - Count cancelled orders

**Business meaning:**
This prevents inaccurate financial reporting by excluding orders that have not successfully generated income.

---

## 8. Final recommendation

Based on the verified data, my recommendation is:

The business should focus on increasing sales of the highest-performing products and categories while improving conversion of pending orders into completed purchases. Cancelled orders should also be investigated to understand customer problems and reduce lost revenue.
