# Day 10 - Bronze / Silver / Gold Pipeline with Python

## Unity Tech Hub x Agilyti - Data Engineering / Databricks Training

## Project goal

The goal of this project was to build a simple data engineering pipeline using the Bronze, Silver, and Gold architecture.

The pipeline takes raw CSV data, validates and cleans it, enriches it with customer and product information, and produces business-ready reports.

The main objective was to understand how real-world data moves through different layers before being used for analysis and dashboards.

---

# Bronze layer

The Bronze layer contains the original raw data files received from the source.

Files stored:

- `customers_raw.csv`
- `products_raw.csv`
- `orders_raw.csv`

The data in this layer is kept unchanged because it represents the original source data.

Keeping raw data helps with:
- Reprocessing the pipeline.
- Auditing data changes.
- Comparing cleaned data with the original source.
- Investigating data quality problems.

Problems found in Bronze data:

- Missing values.
- Duplicate records.
- Invalid IDs.
- Incorrect status formats.
- Invalid quantities.
- Invalid prices.
- Inconsistent text values.

---

# Silver layer

The Silver layer contains cleaned and enriched data.

Cleaning steps performed:

- Validated required columns.
- Removed invalid orders.
- Removed duplicate order IDs.
- Checked customer and product references.
- Standardized status values.
- Converted numeric fields into correct data types.
- Added calculated fields.

Invalid records were separated because they could affect business calculations.

Examples of invalid records:

- Orders with missing customer IDs.
- Orders with missing product IDs.
- Orders with quantity <= 0.
- Orders with price <= 0.
- Duplicate order IDs.

Enrichment added:

- `customer_name`
- `city`
- `product_name`
- `category`
- `price`
- `total_amount`

The Silver layer is safer than Bronze because the data has passed validation and cleaning rules.

---

# Gold layer

The Gold layer contains business-ready reports created from Silver data.

Generated reports:

- `revenue_by_category.csv`
- `revenue_by_city.csv`
- `revenue_by_customer.csv`
- `top_products.csv`

These reports are created only from clean Silver data.

Business questions answered:

### Revenue by category
- Which categories generate the highest completed revenue?
- How many completed orders exist per category?

### Revenue by city
- Which cities generate the most revenue?
- Which locations have the highest customer activity?

### Revenue by customer
- Which customers contribute the most revenue?
- How many completed orders does each customer have?

### Top products
- Which products perform best?
- Which products generate the most sales?

---

# How to run the pipeline

1. Make sure Python is installed.

2. Place the raw CSV files inside:
