# Day 5 - Friday Data Sprint

## Unity Tech Hub x Agilyti – Data Engineering / Databricks Training

# Group Members
- Melos Beqiri
- Eljesa Krasniqi

---

# Project Overview

This project was completed as part of the **Unity Tech Hub x Agilyti Data Engineering / Databricks Training – Day 5 Friday Data Sprint**.

The objective of this challenge was to analyze a business order dataset using both **Python** and **SQL**, compare the results, and generate meaningful business insights.

The dataset represents orders from a small electronics and office supplies business operating in different cities across Kosovo.

---

# Python Analysis

The Python script performs the following tasks:

- Reads the CSV dataset
- Counts total orders
- Displays completed orders
- Displays pending and cancelled orders
- Calculates total amount for each order
- Calculates completed revenue
- Finds the highest-priced order
- Finds the order with the highest total amount
- Counts orders by:
  - Status
  - City
  - Category
- Prints a clean business report in the terminal

---

# SQL Analysis

The SQL scripts include:

### setup.sql

- Drops the existing table (if any)
- Creates the `orders` table
- Inserts all dataset records
- Verifies the inserted data

### sql_analysis.sql

Queries include:

- Show all orders
- Show completed orders
- Show pending/cancelled orders
- Calculate total amount
- Calculate completed revenue
- Count orders by status
- Count orders by city
- Count orders by category
- Show Top 3 most valuable orders
- Find the most valuable order

SQL queries were tested using **SQLiteOnline.com**.

---

# Running the Project

## Run Python

```bash
python python_analysis.py
```

The script will generate a complete business report in the terminal.

---

## Run SQL

These scripts can be executed in **SQLiteOnline.com** or any SQLite environment.

---

# Business Insights

From this analysis we identified:

- The total number of business orders.
- Revenue generated only from completed orders.
- Cities with the highest number of orders.
- Product categories with the highest demand.
- The most valuable customer order.
- Orders that should not be counted as revenue.
- Recommendations that could help improve business performance.

---

# Screenshots Included

The project includes screenshots showing:

- SQLite table creation
- Inserted dataset
- Completed orders query
- Total amount calculation
- Completed revenue calculation
- GROUP BY queries
- A python terminal output

---

# Technologies Used

- Python 3
- CSV
- SQL
- SQLite
- SQLiteOnline
- Git & GitHub

---

# Learning Outcomes

During this sprint we practiced:

- Data analysis using Python
- SQL querying
- Business reporting
- GitHub project organization
- Team collaboration
- Communication and presentation skills
- Converting technical results into business insights

---

# Most Important Insight

The most important finding is that **only completed orders should be included when calculating business revenue**. Pending and cancelled orders should be excluded to ensure accurate financial reporting and better business decision-making.