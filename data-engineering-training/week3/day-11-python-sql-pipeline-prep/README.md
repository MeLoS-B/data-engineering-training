# Day 11 - Python + SQL Pipeline Preparation

## Project Goal

The goal of this project was to prepare a small data engineering pipeline using Python and SQL concepts.

The pipeline follows a Bronze, Silver, and Gold architecture:

- Bronze layer: Store and understand raw data.
- Silver layer: Clean, validate, and transform data into reliable datasets.
- Gold layer: Create business-ready reports for analysis.

The purpose was to practice ETL thinking before moving the pipeline into a Databricks notebook environment.

---

# Bronze Data

## What raw files did you receive?

The Bronze layer contained raw CSV files:

- customers_raw.csv
- products_raw.csv
- orders_raw.csv

These files represented raw business data containing customers, products, and orders.

---

## What problems did you notice?

During data exploration, several data quality issues were found:

- Duplicate records
- Missing values
- Inconsistent city names
- Different formatting of status values
- Empty customer names
- Invalid quantities
- Invalid prices
- Inconsistent category and channel values

The Bronze layer was kept unchanged because it represents the original source data.

---

# Silver Data

## What validation rules did you apply?

The following validation rules were applied:

- Customer name cannot be empty.
- Quantity must be greater than 0.
- Price must be greater than 0.
- Customer IDs must exist in customer data.
- Product IDs must exist in product data.
- Required fields cannot be missing.

Invalid records were separated from clean records and stored with reasons explaining why they failed.

---

## Which records became invalid and why?

Records became invalid because of:

- Missing customer information
- Unknown customer IDs
- Unknown product IDs
- Quantity equal to 0 or negative values
- Price equal to 0 or negative values

Each invalid record included a reason field for easier debugging.

---

## What did you normalize?

The following fields were normalized:

- City names:
  - vushtrri → Vushtrri
  - prishtina → Prishtina

- Status values:
  - completed
  - pending
  - cancelled

- Channel values:
  - online
  - store

Normalization helped make the data consistent for reporting.

---

# Gold Reports

## What business reports did you create?

The Gold layer contains business-ready reports:

- revenue_by_category.csv
- revenue_by_city.csv
- revenue_by_customer.csv
- top_products.csv
- top_customers.csv
- executive_summary.txt

These reports were created from Silver cleaned data.

---

## Which report is most useful for a manager?

The most useful report for a manager is:

**executive_summary.txt**

because it provides a quick overview of business performance, including:

- Total revenue
- Number of completed orders
- Best performing category
- Top customers
- Important business trends

---

# Python vs SQL

## What did Python help you do?

Python was used for:

- Reading CSV files
- Cleaning raw data
- Validating records
- Handling missing values
- Normalizing data
- Creating lookup tables
- Joining customer and product information
- Generating reports

Python was useful for building the ETL pipeline logic.

---

## What did SQL help you do?

SQL was used for:

- Querying cleaned data
- Filtering records
- Aggregating revenue
- Counting orders
- Finding top customers and products
- Creating business analysis queries

SQL was useful for answering business questions from structured data.

---

# Data Quality Notes

Data quality was improved by:

- Removing invalid records
- Tracking validation failures
- Standardizing values
- Checking missing data
- Creating clean Silver datasets

The pipeline keeps invalid records instead of deleting them so problems can be investigated later.

---

# Business Insights

From the Gold reports, we can identify:

- Which products generate the most revenue
- Which categories perform best
- Which cities bring the most sales
- Which customers have the highest value
- How many orders are completed successfully

These insights help managers make better decisions.

---

# What I Can Explain Live

I can explain:

- The Bronze, Silver, and Gold architecture
- Why cleaning happens in the Silver layer
- Why Gold reports should use Silver data
- How Python and SQL have different roles
- How validation rules protect data quality
- How ETL pipelines transform raw data into business information

---

# What I Would Improve Next

Next improvements:

- Move the pipeline into Databricks notebooks
- Use PySpark instead of only Python
- Store data using Delta Lake
- Add automated data quality checks
- Create scheduled workflows
- Add logging and monitoring
- Improve scalability for larger datasets