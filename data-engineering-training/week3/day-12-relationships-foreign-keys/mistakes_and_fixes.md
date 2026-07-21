# mistakes_and_fixes.md

## Foreign Key Test 1

**Incorrect SQL**

```sql
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES
(14, '2026-07-01', 'completed', 'Online');
```

**Error received**

* FOREIGN KEY constraint failed because `customer_id = 14` does not exist in the `customers` table.

**Why it failed**

* Every order must belong to an existing customer.

**Correct SQL**

```sql
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES
(1, '2026-07-01', 'completed', 'Online');
```

---

## Foreign Key Test 2

**Incorrect SQL**

```sql
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(120, 1, 1);
```

**Error received**

* FOREIGN KEY constraint failed because `order_id = 120` does not exist in the `orders` table.

**Why it failed**

* Every order item must belong to an existing order.

**Correct SQL**

```sql
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 1);
```

---

## Foreign Key Test 3

**Incorrect SQL**

```sql
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 120, 1);
```

**Error received**

* FOREIGN KEY constraint failed because `product_id = 120` does not exist in the `products` table.

**Why it failed**

* Every order item must reference an existing product.

**Correct SQL**

```sql
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 1);
```

---

## CHECK Constraint Test 1

**Incorrect SQL**

```sql
INSERT INTO products (product_name, category, price)
VALUES
('Laptop', 'Electronics', -20);
```

**Error received**

* CHECK constraint failed because the product price cannot be zero or negative.

**Why it failed**

* Products must have a positive price.

**Correct SQL**

```sql
INSERT INTO products (product_name, category, price)
VALUES
('Laptop', 'Electronics', 1200);
```

---

## CHECK Constraint Test 2

**Incorrect SQL**

```sql
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 120, 0);
```

**Error received**

* CHECK constraint failed because the quantity cannot be zero.

**Why it failed**

* Every order item must have a quantity greater than zero.

**Correct SQL**

```sql
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 2);
```

---

## Status CHECK Test

**Incorrect SQL**

```sql
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES
(1, '2026-07-01', 'done', 'Online');
```

**Error received**

* CHECK constraint failed because the status `done` is not allowed.

**Why it failed**

* The database only accepts these status values:

  * `completed`
  * `pending`
  * `cancelled`

**Correct SQL**

```sql
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES
(1, '2026-07-01', 'completed', 'Online');
```

---

## What I Learned

These tests showed that database constraints protect data quality by:

* Preventing orders from referencing customers that do not exist.
* Preventing order items from referencing missing orders or products.
* Preventing invalid prices and quantities.
* Allowing only valid order status values.

Using foreign keys and CHECK constraints helps keep the database accurate and consistent.
