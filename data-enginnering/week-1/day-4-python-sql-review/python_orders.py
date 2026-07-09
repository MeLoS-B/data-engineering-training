

orders = [
    {
        "order_id": 1,
        "customer_name": "Arta",
        "city": "Vushtrri",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 700,
        "status": "completed",
        "order_date": "2026-07-01"
    },
    {
        "order_id": 2,
        "customer_name": "Blend",
        "city": "Prishtina",
        "product": "Mouse",
        "category": "Accessories",
        "quantity": 2,
        "price": 15,
        "status": "completed",
        "order_date": "2026-07-01"
    },
    {
        "order_id": 3,
        "customer_name": "Arta",
        "city": "Vushtrri",
        "product": "Keyboard",
        "category": "Accessories",
        "quantity": 1,
        "price": 40,
        "status": "cancelled",
        "order_date": "2026-07-02"
    },
    {
        "order_id": 4,
        "customer_name": "Dren",
        "city": "Mitrovica",
        "product": "Monitor",
        "category": "Electronics",
        "quantity": 1,
        "price": 180,
        "status": "completed",
        "order_date": "2026-07-02"
    },
    {
        "order_id": 5,
        "customer_name": "Elira",
        "city": "Prishtina",
        "product": "Mouse",
        "category": "Accessories",
        "quantity": 1,
        "price": 15,
        "status": "completed",
        "order_date": "2026-07-03"
    },
    {
        "order_id": 6,
        "customer_name": "Dren",
        "city": "Mitrovica",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 700,
        "status": "pending",
        "order_date": "2026-07-03"
    },
    {
        "order_id": 7,
        "customer_name": "Nora",
        "city": "Vushtrri",
        "product": "Headphones",
        "category": "Accessories",
        "quantity": 1,
        "price": 50,
        "status": "completed",
        "order_date": "2026-07-04"
    },
    {
        "order_id": 8,
        "customer_name": "Leart",
        "city": "Peja",
        "product": "Monitor",
        "category": "Electronics",
        "quantity": 2,
        "price": 180,
        "status": "completed",
        "order_date": "2026-07-04"
    },
    {
        "order_id": 9,
        "customer_name": "Faton",
        "city": "Prizren",
        "product": "Desk Chair",
        "category": "Office",
        "quantity": 1,
        "price": 120,
        "status": "completed",
        "order_date": "2026-07-05"
    },
    {
        "order_id": 10,
        "customer_name": "Gresa",
        "city": "Prishtina",
        "product": "USB Cable",
        "category": "Accessories",
        "quantity": 3,
        "price": 8,
        "status": "completed",
        "order_date": "2026-07-05"
    },
    {
        "order_id": 11,
        "customer_name": "Rina",
        "city": "Vushtrri",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 650,
        "status": "cancelled",
        "order_date": "2026-07-06"
    },
    {
        "order_id": 12,
        "customer_name": "Arben",
        "city": "Ferizaj",
        "product": "Desk",
        "category": "Office",
        "quantity": 1,
        "price": 220,
        "status": "pending",
        "order_date": "2026-07-06"
    }
]




# Task P1 - Print basic data
print(f"Total orders {len(orders)}")
print("Customer names:")
for order in orders:
    print(order["customer_name"])
    
    
    
print("Order details:")
for order in orders:
    print(f"{order['customer_name']} ordered {order['product']} from {order['city']} and status is {order['status']}")
    
    
    


# Task P2 - Filter records

print("Completed orders:")
for order in orders:
    if order["status"] == "completed":
        print(f"{order['order_id']} - {order['customer_name']} - {order['product']}")
        
        

print("Pending orders:")
for order in orders:
    if order["status"] == "pending":
        print(f"{order['order_id']} - {order['customer_name']} - {order['product']}")


print("Cancelled orders:")
for order in orders:
    if order["status"] == "cancelled":
        print(f"{order['order_id']} - {order['customer_name']} - {order['product']}")


print("Price greater 100:")
for order in orders:
    if order["price"] > 100:
        print(f"{order['order_id']} - {order['customer_name']} - {order['product']}")





print("Category accessories.:")
for order in orders:
    if order["category"] == "Accessories":
        print(f"{order['order_id']} - {order['customer_name']} - {order['product']}")



# Task P3 - Calculated values

print("Total orders:")
for order in orders:
    print(f"{order['customer_name']} - {order['product']} - {order["quantity"]} * {order["price"]} = {order['quantity'] * order["price"]}")
    

print("User info")
for order in orders:
  
    print(f"{order['customer_name']} - {order['product']} - {order['quantity']} - {order['price']} - {order['price'] * order['quantity']}")
    
    
    
    

# Task P4 - Sorting and top records


print("Product from highest price to lowest")
orders_copy = orders.copy()

highest_to_lowest = sorted(orders_copy, key=lambda order: order["price"], reverse=True)

for order in highest_to_lowest:
    print(order["product"], order["price"])
    
    
    
print("Orders sorted by total amount (highest to lowest)")

orders_sorted = sorted(orders_copy,key=lambda order:order["quantity"] * order["price"],reverse=True)

for order in orders_sorted:
    print(f"{order['product']}: {order['quantity'] * order['price']}")
    
    
    
    
print("Print the top 3 orders by total_amount.")

orders_sorted = sorted(orders_copy,key=lambda order:order["quantity"] * order["price"],reverse=True)


for order in orders_sorted[:3]:
    print(f"{order['product']}: {order['quantity'] * order['price']}")
    
    
    



# Task P5 - Simple summary without GROUP BY


count_status_tasks = {
    "completed":0,
    "pending":0,
    "cancelled":0
}


for order in orders:
    status = order["status"]

    if status == "completed":
        count_status_tasks["completed"] += 1

    elif status == "pending":
        count_status_tasks["pending"] += 1

    elif status == "cancelled":
        count_status_tasks["cancelled"] += 1
        
print("Status counts:")       
for status,count in count_status_tasks.items():
    print(f"{status}:{count}")       
    
    

total_revenue = 0

for order in orders:
    if order["status"] == "completed":
        total_revenue += order["quantity"] * order["price"]

print(f"Total revenue from completed orders: {total_revenue}")




customer_orders = {}

for order in orders:
    customer = order["customer_name"]

    if customer in customer_orders:
        customer_orders[customer] += 1
    else:
        customer_orders[customer] = 1


print("Customers with more than one order:")

for customer, count in customer_orders.items():
    if count > 1:
        print(f"{customer}: {count} orders")
        
        
        
        



# mini bussiness challenge

for order in orders:
    order["total_amount"] = order["quantity"] * order["price"]


# 1. Find customer with the most expensive single order

most_expensive_order = orders[0]

for order in orders:
    if order["total_amount"] > most_expensive_order["total_amount"]:
        most_expensive_order = order

print("Most expensive single order:")
print(
    most_expensive_order["customer_name"],
    "-",
    most_expensive_order["product"],
    "-",
    most_expensive_order["total_amount"]
)




highest_order = max(orders, key=lambda order: order["total_amount"])

print("\nHighest total_amount order:")
print(
    highest_order["customer_name"],
    "-",
    highest_order["product"],
    "-",
    highest_order["total_amount"]
)




print("\nOrders NOT counted as revenue:")

for order in orders:
    if order["status"] == "pending" or order["status"] == "cancelled":
        print(
            order["customer_name"],
            "-",
            order["product"],
            "-",
            order["status"]
        )




completed_revenue = 0

for order in orders:
    if order["status"] == "completed":
        completed_revenue += order["total_amount"]

print("\nCompleted revenue:")
print(completed_revenue)




print("\nBusiness Answer 1:")
print(
    f"The most valuable order is {highest_order['product']} "
    f"from {highest_order['customer_name']} because it has the highest "
    f"total amount of {highest_order['total_amount']}."
)


print("\nBusiness Answer 2:")
print(
    "Cancelled orders should not be counted as revenue because the company "
    "will not receive payment from them. Including them would make revenue "
    "look higher than the real business performance."
)



