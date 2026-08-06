# Project Assumptions & Design Decisions

This document details the assumptions, design choices, and limitations of the Day 19 Data Cleaning Pipeline.

## 1. Assumptions & Data Normalization

- **Currencies**: 
  - Products in `products_raw.csv` did not have a currency column. We assume the base store catalog currency is `EUR` and default it.
  - Payment currencies in `payments_raw.csv` (like `eur`, `Usd`, `EURO`) are mapped to ISO standard `EUR` or `USD` using config rules.
- **Payment Methods**:
  - `PayPal` is used heavily in raw store and payment gateway data (~30% of records). Although not explicitly listed in the minimal training handbook rules, we added it to `APPROVED_PAYMENT_METHODS` so valid customer transactions are not dropped.
- **Discount & Line Totals**:
  - `order_items_raw.csv` has no discount column. We default `discount_amount` to `0.0`.
  - `line_total` is derived as `quantity * unit_price - discount_amount`.
- **Country Mapping**:
  - Empty or missing countries in CRM customer rows are not guessed. They are flagged as invalid and rejected.
  - Typographical aliases (`us` -> `United States`, `ks` -> `Kosovo`) are safely normalized.

## 2. Duplicate Resolution Strategy

For any dataset, duplicate primary keys (e.g., customer_id, product_id, order_id) or critical business keys (like customer emails) are resolved by **keeping the first valid record** encountered in the source file. All subsequent duplicate occurrences are rejected and sent to the invalid directory with a description (e.g. `duplicate customer_id '39'`).

## 3. Referential Integrity Cascades

We enforce a strict relational model:
- Orders are only trusted if the purchasing `customer_id` belongs to a validated, trusted customer.
- Order Items are only trusted if their parent `order_id` and catalog `product_id` are trusted.
- Payments are only trusted if their parent `order_id` is trusted.

As a result, a single invalid record in a parent dataset (such as an active customer with a missing country) naturally cascades and quarantines/rejects all associated downstream orders, line items, and payment transactions. This ensures that the Gold SQLite database remains completely auditable and self-consistent.

## 4. Payment Reconciliation Criteria

Reconciliation compares the expected order total (derived from summing all valid order items) against the actual successful payment amounts:
- **Matched**: Total paid equals the expected total (tolerance threshold of `0.01`).
- **Underpaid**: Total paid is greater than zero but less than expected.
- **Overpaid**: Total paid is greater than expected (e.g. when order items are rejected but payments are recorded).
- **Missing Payment**: No paid or pending transaction matches the order.
- **Refunded**: Payment status is `refunded` and no other active paid amount exists.
