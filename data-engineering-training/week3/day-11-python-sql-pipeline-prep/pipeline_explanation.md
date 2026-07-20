# Pipeline Explanation

## Part 1 - Data Understanding

### 1. How many raw orders exist?

There are **24 raw orders** in `orders_raw.csv`.

### 2. Which columns are used to join orders with customers and products?

* `customer_id` is used to join `orders_raw.csv` with `customers_raw.csv`.
* `product_id` is used to join `orders_raw.csv` with `products_raw.csv`.

### 3. Which values look inconsistent?

Several values require cleaning before the data can be trusted:

* **Status** values are inconsistent:

  * `completed`
  * `Completed`
  * `done`
  * `pending`
  * `cancelled`
  * `canceled`
  * `returned`
  * Missing status
* **Channel** values are inconsistent:

  * `online`
  * `Online`
  * `store`
  * `Store`
  * `web`
  * `bank`
  * Missing channel
* Some **city names** have inconsistent capitalization:

  * `prishtina` → `Prishtina`
  * `VUSHTRRI` → `Vushtrri`
  * `ferizaj` → `Ferizaj`
* Some quantities are invalid:

  * Missing quantity
  * Negative quantity (`-1`)
  * Non-numeric quantity (`abc`)
  * Zero quantity (`0`)
* One order contains an invalid product ID (`P999`).
* One order has a missing order date.

### 4. Which records should not be trusted for revenue?

The following records should not be included in revenue calculations:

* Orders with missing, invalid, zero, or negative quantities.
* Orders with non-numeric quantities.
* Orders with invalid product IDs.
* Cancelled or canceled orders.
* Returned orders.
* Orders with invalid data that fail validation.

### 5. Which file is Bronze, which output should be Silver, and which output should be Gold?

#### Bronze (Raw Data)

* `customers_raw.csv`
* `products_raw.csv`
* `orders_raw.csv`

#### Silver (Cleaned & Validated Data)

* `orders_clean.csv`
* `orders_invalid.csv`

#### Gold (Business Reports)

* `revenue_by_category.csv`
* `revenue_by_city.csv`
* `revenue_by_customer.csv`
* `top_products.csv`
* `executive_summary.txt`
