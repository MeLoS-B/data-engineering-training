# Day 19 Challenge: Real-World Data Cleaning Pipeline

## 1. Project Overview & Business Problem
A large e-commerce organization received raw operational data from separate source systems: a CRM, an Online Store, a Warehouse Management System, and a Payment Gateway. Because these systems were decoupled and lacked centralized validations, the data arrived with severe defects:
- Duplicate records inflating key metrics.
- Missing values in required business fields.
- Non-standard country, city, and status formats.
- Invalid order dates, future creations, or pricing anomalies.
- Orphans violating referential integrity (e.g. orders for non-existent customers).

This project implements a repeatable **Python + SQLite Data Pipeline** that converts these unreliable CSV sources into trusted, auditable business information in a clean, junior-friendly procedural Python style.

---

## 2. Architecture & Data Flow

We implement a clear **Bronze -> Silver -> Gold** processing sequence:

```
[Raw CSV Data]
       │
       ▼
┌────────────────┐
│  Bronze Layer  │  <-- Immutable copies of raw data + Ingestion manifest
└────────────────┘
       │
       ▼
┌────────────────┐
│  Silver Layer  │  <-- Case/casing normalization, text trimming, ISO dates,
└────────────────┘      technical validation, referential checks
       │         │
       ▼         ▼
┌──────────────┐ ┌──────────────┐
│ Silver Clean │ │ Invalid Rows │ <-- Filtered records written to separate CSVs
└──────────────┘ └──────────────┘
       │
       ▼
┌────────────────┐
│   Gold Layer   │  <-- SQLite tables populated with foreign keys, checks,
│ (SQLite DB)    │      and transaction-level guarantees
└────────────────┘
       │
       ▼
┌────────────────┐
│ Reports Output │  <-- Automated Quality summary (TXT/JSON) and Business SQL reports
└────────────────┘
```

---

## 3. Input Datasets & Validation Rules

### Customers
- **customer_id**: Required, unique.
- **full_name**: Required, non-empty (whitespace trimmed).
- **email**: Required, validated via regular expression, normalized to lowercase.
- **country**: Required, normalized to standard title-cased names (e.g. `US` -> `United States`, `kosovo` -> `Kosovo`).
- **created_at**: Required, normalized to ISO `YYYY-MM-DD` and cannot be in the future (relative to today).
- **status**: Normalized and mapped via config lookup; must be `active` or `inactive`.

### Products
- **product_id**: Required, unique.
- **product_name**: Required, non-empty.
- **category**: Normalized to Title Case.
- **price**: Cleaned of currency symbols (`€`, `$`) and commas; must be `float` and `> 0`.
- **currency**: Defaulted to `EUR` or mapped (e.g. `$`, `usd` -> `USD`).
- **stock_quantity**: Must parse as an integer `>= 0`.
- **status**: Mapped to `active` or `inactive`.

### Orders
- **order_id**: Required, unique.
- **customer_id**: Required; must reference an existing trusted customer in the lookup.
- **order_date**: Normalized to ISO date; cannot be in the future.
- **status**: Must map to `new`, `processing`, `shipped`, `delivered`, `cancelled`, or `completed`.
- **shipping_city**: Normalized.
- **shipping_country**: Auto-populated using the parent customer's country.
- **payment_method**: Mapped and validated (e.g. `paypal`, `cash`, `card`, `bank_transfer`).

### Order Items
- **order_item_id**: Required, unique.
- **order_id**: Must exist in trusted orders.
- **product_id**: Must exist in trusted products.
- **quantity**: Must parse as an integer `> 0`.
- **unit_price**: Must parse as a float `> 0`.
- **discount_amount**: Defaulted to `0.0`.
- **line_total**: Calculated automatically: `quantity * unit_price - discount_amount`.

### Payments
- **payment_id**: Required, unique.
- **order_id**: Must exist in trusted orders.
- **payment_date**: Normalized to ISO date; cannot be in the future.
- **amount**: Must parse as a float `> 0`.
- **currency**: Normalized to uppercase `USD` or `EUR`.
- **payment_method**: Validated (`card`, `bank_transfer`, `cash`, `paypal`).
- **status**: Mapped to `paid`, `pending`, `failed`, or `refunded`.

---

## 4. Duplicate-Handling Strategy
For any entity, if a primary key or business key (duplicate customer emails) has already been processed in a valid row, all subsequent rows containing that key are rejected as duplicates with a descriptive error. This preserves first-write integrity and isolates duplicates for source-system analysis.

---

## 5. Setup & How to Run

### Install Dependencies
No external library dependencies are required! The project uses Python's standard libraries (`sqlite3`, `csv`, `re`, `datetime`, `os`).

### Running the Pipeline
Execute the main entry point to run the entire pipeline:
```bash
python3 main.py
```

### Running the Unit Tests
Verify validator and normalizer rules:
```bash
python3 -m unittest discover -s tests -p "test_*.py"
```

---

## 6. Output Artifacts & SQLite Schema
The pipeline automatically outputs:
- **`data/bronze/`**: Raw exact copies + manifest.
- **`data/silver/`**: Deduplicated and normalized clean datasets.
- **`data/invalid/`**: Error-trace files containing the original columns plus trace columns (`source_file`, `source_row_number`, `record_key`, `invalid_reasons`, `processed_at`).
- **`data/gold/`**: 
  - `trusted_data.db` (Gold relational SQLite database)
  - 9 SQL report exports as CSVs (reconciliation and business reports)
- **`reports/`**: 
  - `quality_summary.txt` (technical QA review metrics)
  - `quality_metrics.json` (machine-readable metrics)

---

## 7. Final Engineering Review Questions

### 32. Which source system produced the highest defect rate, and what business risk does that create?
The CRM system (`customers_raw.csv`) and Store system (`orders_raw.csv` / `payments_raw.csv`) produced high defect rates. Because customer status and country columns were frequently missing, incorrect, or unknown (such as `blocked` or `unknown`), it triggered referential integrity failures downstream. The business risk is that reporting will exclude a large portion of actual revenue because their related parents are untrustworthy.

### 33. Which corrections were safe normalization, and which defects required rejection?
- **Safe Normalization**: Standardizing case (`ACTIVE` -> `active`), trimming spaces (`  Prishtina ` -> `Prishtina`), clean formatting prices (`$1,08.87` -> `108.87`), and parsing date formats (`02/01/2026` -> `2026-01-02`).
- **Required Rejection**: Missing required columns (e.g. empty customer name or country), invalid domain rules (negative quantities, prices `<= 0`), unrecognized statuses, duplicate keys, and orphan records.

### 34. How did you decide which duplicate record to keep or reject?
We kept the first valid record based on the sequence in the file. Subsequent records matching the same primary key or business key (customer email) were rejected with a duplicate reason.

### 35. Why are foreign-key checks performed against trusted parent records rather than raw parent files?
Because checking against raw parent files could lead to joining against invalid parents (e.g., a customer who is missing their name). Performing referential checks against trusted parents ensures only clean, consistent relational data is loaded.

### 36. How did you prove that no trusted rows were lost between Silver and SQLite?
The database loader executes a count validation step directly after commits. It selects the counts of each table and reconciles them against the read counts of the Silver clean CSV files. If there is any mismatch, it throws a value error and aborts.

### 37. How did you prevent line-item and payment joins from multiplying financial totals?
We grouped and summed line-item expected values and payment actual values in separate Common Table Expressions (CTEs) at the order grain before joining the results. This avoids the fan-out multiplier effect in joins.

### 38. Which assumptions require confirmation from a product owner or finance stakeholder?
- Whether customer status values of `blocked` or `unknown` should indeed be rejected or mapped to a standard lifecycle status.
- Whether `PayPal` should be added as an approved payment method or remains blocked.
- How to handle payment underpayment or overpayment thresholds.

### 39. What would you change before deploying this pipeline in a production cloud environment?
- Transition the storage layer from local disk to a cloud storage system (like AWS S3 or Google Cloud Storage).
- Convert SQLite to a distributed data warehouse (like Snowflake or BigQuery).
- Introduce schema versioning and drift detection, and automate deployment using a workflow orchestrator like Apache Airflow or Prefect.
