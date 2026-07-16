import csv
import os
from collections import Counter

#Part 2
def load_csv(file_path):
    rows = []

    with open(file_path, "r", newline="", encoding="utf-8") as file:
        reader = csv.DictReader(file)

        for row in reader:
            rows.append(row)

    return rows


def load_orders():
    orders = load_csv("data/orders_raw.csv")
    print(f"Loaded raw orders: {len(orders)}")
    return orders


def load_customers():
    customers = load_csv("data/customers_raw.csv")
    print(f"Loaded raw customers: {len(customers)}")
    return customers


def load_products():
    products = load_csv("data/products_raw.csv")
    print(f"Loaded raw products: {len(products)}")
    return products

#Part 3
def build_lookup_table(rows, key_field):
    lookup = {}
    for row in rows:
        key = row[key_field]
        lookup[key] = row
    return lookup


#Part 4
def normalize_status(status):
    if not status:
        return "unknown"

    status = status.strip().lower()

    if status in ["completed", "complete", "done"]:
        return "completed"

    elif status == "pending":
        return "pending"

    elif status in ["cancelled", "canceled"]:
        return "cancelled"

    else:
        return "unknown"

def normalize_city(city):
    if not city:
        return "unknown"

    city = city.strip().lower()

    city_mapping = {
        "prishtina": "Prishtina",
        "vushtrri": "Vushtrri",
        "mitrovica": "Mitrovica",
        "peja": "Peja",
        "prizren": "Prizren",
        "ferizaj": "Ferizaj"
    }

    return city_mapping.get(city, city.title())

def normalize_channel(channel):
    if not channel:
        return "unknown"
    channel = channel.strip().lower()
    if channel in ["online","Online","web"]:
        return "online"
    elif channel in ["store","Store"]:
        return "store"
    else:
        return "unknown"
    
#Part 5
    
def is_positive_integer(value):
    if not value:
        return False
    
    try:
        number = int(value)
        
        if number > 0:
            return True
        else:
            return False
    except ValueError:
        return False

def validate_order(order,customers_lookup,products_lookup):
    if not order.get("order_id"):
        return False,"missing_order_id"
    
    customer_id = order.get("customer_id")
    
    if not customer_id or customer_id not in customers_lookup:
        return False,"invalid_customer_id"
    
    product_id = order.get("product_id")
    
    if not product_id or product_id not in products_lookup:
        return False,"invalid_product_id"
    
    if not order.get("order_date"):
        return False,"missing_order_date"
    
    quantity = order.get("quantity")
    
    if not quantity:
        return False,"missing_quantity"
    
    if not is_positive_integer(quantity):
        if quantity.startswith("-"):
            return False,"negative_quantity"
        return False,"invalid_quantity"
    
    status = normalize_status(order.get("status"))
    
    if not order.get("status"):
        return False,"missing_status"
    
    if status == "unknown":
        return False,"invalid_status"
    
    channel = normalize_channel(order.get("channel"))
    if channel not in ["online","store","unknown"]:
        return False,"invalid_channel"
    
    return True,None
    
    
    
# Part 6
def calculate_total_amount(order):
    quantity = int(order["quantity"])
    price = float(order["price"])
    
    return round(quantity * price,2)

def enrich_order(order,customer_lookup,products_lookup):
    customer = customer_lookup[order["customer_id"]]
    product = products_lookup[order["product_id"]]
    
    enriched_order = {
        "order_id": order["order_id"],
        "customer_id": order["customer_id"],
        "customer_name": customer["customer_name"],
        "city": normalize_city(customer["city"]),
        "product_id": order["product_id"],
        "product_name": product["product_name"],
        "category": product["category"],
        "quantity": order["quantity"],
        "price": product["price"],
        "total_amount": calculate_total_amount(
            {
                "quantity": order["quantity"],
                "price": product["price"]
            }
        ),
        "status": normalize_status(
            order["status"]
        ),
        "channel": normalize_channel(
            order["channel"]
        ),
        "order_date": order["order_date"]
    }
    return enriched_order

# Part 7

def write_csv(file_path, rows, fieldnames):

    with open(
        file_path,
        "w",
     
    ) as file:

        writer = csv.DictWriter(
            file,
            fieldnames=fieldnames,
            extrasaction="ignore"
        )

        writer.writeheader()
        writer.writerows(rows)  
# Part 8

def create_data_quality_report(raw_orders, clean_orders, invalid_orders):
    """
    Create data quality report.
    """

    invalid_reasons = Counter()

    for order in invalid_orders:
        invalid_reasons[order["reason"]] += 1


    status_values = Counter()

    for order in clean_orders:
        status_values[order["status"]] += 1


    channel_values = Counter()

    for order in clean_orders:
        channel_values[order["channel"]] += 1


    city_values = Counter()

    for order in clean_orders:
        city_values[order["city"]] += 1


    with open(
        "output/data_quality_report.txt",
        "w",
        encoding="utf-8"
    ) as file:


        file.write("Data Quality Report - Day 9\n")
        file.write("===========================\n\n")


        file.write(
            f"Total raw orders: {len(raw_orders)}\n"
        )

        file.write(
            f"Valid orders: {len(clean_orders)}\n"
        )

        file.write(
            f"Invalid orders: {len(invalid_orders)}\n\n"
        )


        file.write("Invalid records by reason:\n")

        for reason, count in invalid_reasons.items():
            file.write(
                f"- {reason}: {count}\n"
            )


        file.write("\nStatus values after cleaning:\n")

        for status, count in status_values.items():
            file.write(
                f"- {status}: {count}\n"
            )


        file.write("\nChannel values after cleaning:\n")

        for channel, count in channel_values.items():
            file.write(
                f"- {channel}: {count}\n"
            )


        file.write("\nCity values after cleaning:\n")

        for city, count in city_values.items():
            file.write(
                f"- {city}: {count}\n"
            )


        file.write(
            "\nBronze input files checked:\n"
        )

        file.write(
            "- orders_raw.csv\n"
        )

        file.write(
            "- customers_raw.csv\n"
        )

        file.write(
            "- products_raw.csv\n"
        )


        file.write(
            "\nSilver output files created:\n"
        )

        file.write(
            "- orders_clean.csv\n"
        )

        file.write(
            "- invalid_orders.csv\n"
        )


        file.write(
            "\nMain data quality problems found:\n"
        )

        if invalid_reasons:
            for reason in invalid_reasons:
                file.write(
                    f"- {reason}\n"
                )
        else:
            file.write(
                "- No data quality problems found\n"
            )

# Part 9
def count_by_field(rows, field_name):
    counts = {}
    for row in rows:
        value = row[field_name]
        if value in counts:
            counts[value] += 1
        else:
            counts[value] = 1
    return counts

def sum_by_field(rows, group_field, amount_field):
    totals = {}
    for row in rows:
        group = row[group_field]
        amount = float(row[amount_field])
        if group in totals:
            totals[group] += amount
        else:
            totals[group] = amount
    return totals

def get_completed_orders(rows):
    completed = []
    for row in rows:
        if row["status"] == "completed":
            completed.append(row)
    return completed


def get_top_n_by_field(rows, field_name, n):
    totals = {}
    for row in rows:
        field = row[field_name]
        amount = float(row["total_amount"])
        if field in totals:
            totals[field] += amount
        else:
            totals[field] = amount

    sorted_totals = sorted(
        totals.items(),
        key=lambda x: x[1],
        reverse=True
    )

    return sorted_totals[:n]

def create_business_summary(clean_orders):

    completed_orders = get_completed_orders(clean_orders)


    completed_revenue = sum(
        float(order["total_amount"])
        for order in completed_orders
    )


    orders_status = count_by_field(
        clean_orders,
        "status"
    )


    orders_city = count_by_field(
        clean_orders,
        "city"
    )


    revenue_category = sum_by_field(
        completed_orders,
        "category",
        "total_amount"
    )


    revenue_channel = sum_by_field(
        completed_orders,
        "channel",
        "total_amount"
    )


    top_customers = get_top_n_by_field(
        completed_orders,
        "customer_name",
        3
    )


    top_products = get_top_n_by_field(
        completed_orders,
        "product_name",
        3
    )


    most_valuable_order = max(
        completed_orders,
        key=lambda x: float(x["total_amount"])
    )


    with open(
        "output/business_summary.txt",
        "w",
        encoding="utf-8"
    ) as file:


        file.write("Business Summary - Day 9\n")
        file.write("========================\n\n")


        file.write(
            f"Completed revenue: {completed_revenue}\n\n"
        )


        file.write("Orders by status:\n")

        for key, value in orders_status.items():
            file.write(
                f"- {key}: {value}\n"
            )


        file.write("\nOrders by city:\n")

        for key, value in orders_city.items():
            file.write(
                f"- {key}: {value}\n"
            )


        file.write("\nRevenue by category:\n")

        for key, value in revenue_category.items():
            file.write(
                f"- {key}: {value}\n"
            )


        file.write("\nRevenue by channel:\n")

        for key, value in revenue_channel.items():
            file.write(
                f"- {key}: {value}\n"
            )


        file.write("\nTop 3 customers by completed revenue:\n")

        for name, revenue in top_customers:
            file.write(
                f"- {name}: {revenue}\n"
            )


        file.write("\nTop 3 products by completed revenue:\n")

        for name, revenue in top_products:
            file.write(
                f"- {name}: {revenue}\n"
            )


        file.write("\nMost valuable completed order:\n")

        file.write(
            f"- Order {most_valuable_order['order_id']} "
            f"with {most_valuable_order['total_amount']}\n"
        )


        file.write(
            "\nOrders that should not count as revenue:\n"
        )

        file.write(
            "- Pending orders\n"
        )

        file.write(
            "- Cancelled orders\n"
        )


        file.write(
            "\nBusiness recommendation:\n"
        )

        file.write(
            "- Focus on completed orders and monitor pending orders before considering them revenue.\n"
        )


        file.write(
            "\nWhy this Gold output can be trusted:\n"
        )

        file.write(
            "- Only validated clean orders were used.\n"
        )

        file.write(
            "- Only completed orders contribute to revenue.\n"
        )

        file.write(
            "- Invalid records were separated during validation.\n"
        )
        
        
#Bonus challenges
def find_duplicate_order_ids(rows):
    order_ids = []
    duplicates = []
    for row in rows:
        order_id = row["order_id"]

        if order_id in order_ids:
            duplicates.append(order_id)
        else:
            order_ids.append(order_id)

    return duplicates

def write_completed_orders(clean_orders):

    completed_orders = get_completed_orders(clean_orders)

    fields = [
        "order_id",
        "customer_name",
        "product_name",
        "quantity",
        "total_amount",
        "status"
    ]

    write_csv(
        "output/completed_orders.csv",
        completed_orders,
        fields
    )


def create_revenue_by_city(clean_orders):

    completed = get_completed_orders(clean_orders)

    revenue = sum_by_field(
        completed,
        "city",
        "total_amount"
    )

    sorted_revenue = sorted(
        revenue.items(),
        key=lambda x:x[1],
        reverse=True
    )


    with open(
        "output/revenue_by_city.txt",
        "w"
    ) as file:

        for city, amount in sorted_revenue:
            file.write(
                f"{city}: {amount}\n"
            )

def create_revenue_by_category(clean_orders):

    completed = get_completed_orders(clean_orders)

    revenue = sum_by_field(
        completed,
        "category",
        "total_amount"
    )


    sorted_revenue = sorted(
        revenue.items(),
        key=lambda x:x[1],
        reverse=True
    )


    with open(
        "output/revenue_by_category.txt",
        "w"
    ) as file:

        for category, amount in sorted_revenue:
            file.write(
                f"{category}: {amount}\n"
            )
            

def create_top_customers(clean_orders):

    completed = get_completed_orders(clean_orders)

    top = get_top_n_by_field(
        completed,
        "customer_name",
        5
    )

    with open(
        "output/top_customers.txt",
        "w"
    ) as file:

        for customer, revenue in top:
            file.write(
                f"{customer}: {revenue}\n"
            )

def create_top_products(clean_orders):

    completed = get_completed_orders(clean_orders)

    top = get_top_n_by_field(
        completed,
        "product_name",
        5
    )


    with open(
        "output/top_products.txt",
        "w"
    ) as file:

        for product, revenue in top:
            file.write(
                f"{product}: {revenue}\n"
            )

def main():

    # 1. Load raw CSV files

    orders = load_orders()
    customers = load_customers()
    products = load_products()


    # 2. Build lookup tables

    customers_lookup = build_lookup_table(
        customers,
        "customer_id"
    )

    products_lookup = build_lookup_table(
        products,
        "product_id"
    )


    # 3. Validate and clean orders
    # 4. Enrich valid orders

    clean_orders = []
    invalid_orders = []


    for order in orders:

        valid, reason = validate_order(
            order,
            customers_lookup,
            products_lookup
        )


        if valid:

            enriched_order = enrich_order(
                order,
                customers_lookup,
                products_lookup
            )

            clean_orders.append(
                enriched_order
            )


        else:

            invalid_orders.append(
                {
                    **order,
                    "reason": reason
                }
            )


    print("\nPipeline validation completed")
    print(f"Valid orders: {len(clean_orders)}")
    print(f"Invalid orders: {len(invalid_orders)}")


    # 5. Write clean and invalid CSV files

    os.makedirs(
        "output",
        exist_ok=True
    )


    clean_fields = [
        "order_id",
        "customer_id",
        "customer_name",
        "city",
        "product_id",
        "product_name",
        "category",
        "quantity",
        "price",
        "total_amount",
        "status",
        "channel",
        "order_date"
    ]


    invalid_fields = [
        "order_id",
        "customer_id",
        "product_id",
        "order_date",
        "quantity",
        "status",
        "channel",
        "reason"
    ]


    write_csv(
        "output/orders_clean.csv",
        clean_orders,
        clean_fields
    )


    write_csv(
        "output/invalid_orders.csv",
        invalid_orders,
        invalid_fields
    )


    # 6. Create data quality report

    create_data_quality_report(
        orders,
        clean_orders,
        invalid_orders
    )


    # 7. Create business summary report

    create_business_summary(clean_orders)
    

    write_completed_orders(
        clean_orders
    )

    create_revenue_by_city(
        clean_orders
    )

    create_revenue_by_category(
        clean_orders
    )

    create_top_customers(
        clean_orders
    )

    create_top_products(
        clean_orders
    )
    
    
    duplicates = find_duplicate_order_ids(orders)

    if duplicates:
        print("Duplicate order IDs found:")
        print(duplicates)
    else:
        print("No duplicate order IDs found")


    print("\nPipeline finished successfully")
if __name__ == "__main__":
    main()
