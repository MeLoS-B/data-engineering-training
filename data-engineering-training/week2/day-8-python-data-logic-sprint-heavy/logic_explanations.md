# Logic Explanations

## 1. Why validation was done before revenue calculation

Validation was done before revenue calculation because invalid records should not affect business results.

In the cleaning and validation step, orders with missing customer names, invalid quantities, or invalid prices are separated from valid orders.

If revenue calculation was done before validation, incorrect records could create wrong revenue values.

For example:
- An order with quantity = -5 would create negative revenue.
- An order with price = 0 would create an incorrect order value.
- A missing customer name means the order data is incomplete.

By validating first, only correct and usable orders are included in revenue calculations.

---

## 2. How status normalization works

Status normalization converts different versions of the same status into one standard value.

The code removes extra spaces and converts the status text into lowercase first.

Example:

Raw statuses:

- " Completed "
- "completed"
- "COMPLETED"

After normalization:

- "completed"

The logic works by:

1. Taking the original status value.
2. Removing unnecessary spaces using `.strip()`.
3. Converting all characters to lowercase using `.lower()`.
4. Returning the cleaned status.

This ensures that orders with the same meaning are grouped together correctly.

---

## 3. Why only completed orders count as revenue

Only completed orders are counted as revenue because unfinished orders do not represent successful sales.

For example:

- A pending order may still be cancelled.
- A cancelled order does not generate income.
- A completed order means the customer purchase was successfully processed.

The revenue calculation filters the data and only uses orders where:
