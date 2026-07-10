# Python vs SQL Comparison

## Task: Show completed orders

### Python approach:
- Loop through the orders list.
- Check if order["status"] == "completed".
- Print matching orders.

### SQL approach:
- SELECT the columns we need.
- FROM the orders table.
- Use WHERE status = 'completed'.

### What I understood:
Both approaches filter data. Python uses a loop and an if statement to check each dictionary. SQL filters rows directly from the table using the WHERE condition.


---

## Task: Show orders with price > 100

### Python approach:
- Loop through every order in the orders list.
- Use an if statement to check if order["price"] > 100.
- Print orders that match the condition.

### SQL approach:
- SELECT the required columns.
- FROM the orders table.
- Use WHERE price > 100 to return only expensive orders.

### What I understood:
Both Python and SQL can filter data based on conditions. Python checks each item manually, while SQL lets the database filter the rows automatically.


---

## Task: Calculate total_amount

### Python approach:
- Loop through every order.
- Multiply order["quantity"] * order["price"].
- Print the calculated total amount.

### SQL approach:
- SELECT quantity and price.
- Calculate quantity * price AS total_amount.
- Display the calculated column.

### What I understood:
Both approaches perform calculations using the same formula. Python calculates values while looping through objects, while SQL calculates values when selecting data from the database.


---

## Task: Sort by price descending

### Python approach:
- Use sorted().
- Use price as the sorting key.
- Use reverse=True to sort from highest to lowest.

### SQL approach:
- SELECT the required columns.
- FROM the orders table.
- Use ORDER BY price DESC.

### What I understood:
Both Python and SQL can organize data. Python sorts a list using a function, while SQL sorts database rows using ORDER BY.


---

## Task: Show top 3 orders

### Python approach:
- Sort the orders by price from highest to lowest.
- Use slicing [:3] to keep only the first 3 orders.
- Print the results.

### SQL approach:
- Sort the data using ORDER BY price DESC.
- Use LIMIT 3 to return only three rows.

### What I understood:
Both methods first organize the data and then limit the results. Python uses list slicing, while SQL uses LIMIT.