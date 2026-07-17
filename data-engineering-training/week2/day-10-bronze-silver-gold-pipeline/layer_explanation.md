# Layer Explanation - Bronze

## What files are stored in Bronze?

The Bronze layer stores the original raw data exactly as it was received from the source systems. In this project, the Bronze layer contains:

- `orders_raw.csv`
- `customers_raw.csv`
- `products_raw.csv`

These files are not modified before processing.

---

## Why do we keep raw data unchanged?

Raw data is kept unchanged so that the original information is always available. This allows us to trace data back to its source, debug problems, rerun the pipeline if needed, and compare cleaned data with the original records.

---

## What problems did you notice in the raw data?

Some common problems found in the raw data include:

- Missing values
- Duplicate records
- Invalid IDs
- Incorrect date formats
- Negative or zero quantities
- Missing customer or product information
- Inconsistent text formatting (uppercase, lowercase, extra spaces)
- Invalid status values

---

## Which data problems could break business reports if they are not cleaned?

If the raw data is not cleaned, business reports may become inaccurate. For example:

- Missing or invalid IDs can prevent records from being matched correctly.
- Invalid quantities or prices can produce incorrect revenue calculations.
- Duplicate records can count the same order multiple times.
- Missing customer or product information can create incomplete reports.
- Inconsistent status values can lead to incorrect order counts.
- Incorrect dates can affect daily, monthly, or yearly reporting.

The Bronze layer preserves the raw data, while these issues are fixed later in the Silver layer before creating business reports.