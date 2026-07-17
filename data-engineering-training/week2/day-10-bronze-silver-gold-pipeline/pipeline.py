from pprint import pprint
import csv
import os


def load_csv(file_path):
    with open(file_path) as f:
        data = csv.DictReader(f)
        return list(data)


def ensure_output_folders():
    os.makedirs("data/silver", exist_ok=True)
    os.makedirs("data/gold", exist_ok=True)


def write_file(file_path, data, field_names):
    with open(file_path, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=field_names)
        writer.writeheader()
        writer.writerows(data)


def write_csv(file_path, rows, fieldnames):
    write_file(file_path, rows, fieldnames)


def lookup_field(data, key_field):
    lookup = {}
    for row in data:
        lookup[row[key_field]] = row
    return lookup


def build_lookup(rows, key_field):
    return lookup_field(rows, key_field)


# ---------------- PIPELINE LOGGING (PART 6) ----------------


def write_pipeline_log(steps):
    log_content = "Pipeline Log - Day 10\n"
    for i, step_text in enumerate(steps, 1):
        log_content += f"Step {i}: {step_text}\n"
    log_content += "Pipeline completed successfully.\n"
    
    with open("pipeline_log.txt", "w") as f:
        f.write(log_content)


# ---------------- NORMALIZATION ----------------


def normalize_status(status):
    if status.strip() in ["COMPLETED", "done", "Completed"]:
        status = "completed"
    elif status.strip() in ["CANCELLED", "Cancelled"]:
        status = "cancelled"
    elif status.strip() in ["PENDING", "Pending"]:
        status = "pending"
    return status


def normalize_channel(channel):
    if channel.strip() in ["Online", "web", "mobile"]:
        channel = "online"
    elif channel.strip() == "Store":
        channel = "store"
    elif not channel or channel.strip() == "":
        channel = "Unknown"
    return channel


def normalize_city(city):
    if city.strip() in ["prishtina", "PRISHTINA"]:
        city = "Prishtina"
    elif city.strip() in ["vushtrri", "VUSHTRRI"]:
        city = "Vushtrri"
    elif not city or city.strip() == "":
        city = "Unknown"
    return city


# ---------------- VALIDATION ----------------


def validate_orders(orders, customers_lookup, products_lookup):
    valid_orders = []
    invalid_orders = []
    seen_orders = set()

    for order in orders:
        errors = []

        if order["order_id"] in seen_orders:
            errors.append("duplicate order_id")
        else:
            seen_orders.add(order["order_id"])

        try:
            if int(order["quantity"]) <= 0:
                errors.append("quantity must be positive")
        except:
            errors.append("invalid quantity")

        if not order["order_date"] or order["order_date"].strip() == "":
            errors.append("missing order_date")

        if order["customer_id"] not in customers_lookup:
            errors.append("customer does not exist")

        if order["product_id"] not in products_lookup:
            errors.append("product does not exist")

        if errors:
            order["reason"] = ",".join(errors)
            invalid_orders.append(order)
        else:
            valid_orders.append(order)

    return valid_orders, invalid_orders


def validate_products(products):
    valid_products = []
    invalid_products = []
    seen_products = set()

    for product in products:
        errors = []

        if product["product_id"] in seen_products:
            errors.append("duplicate product_id")
        else:
            seen_products.add(product["product_id"])

        try:
            if float(product["price"]) <= 0:
                errors.append("price must be positive")
        except:
            errors.append("invalid price")

        if not product["category"] or product["category"].strip() == "":
            product["category"] = "Unknown"

        if errors:
            product["reason"] = ",".join(errors)
            invalid_products.append(product)
        else:
            valid_products.append(product)

    return valid_products, invalid_products


def validate_customers(customers):
    valid_customers = []
    invalid_customers = []
    seen_customers = set()

    for customer in customers:
        errors = []

        if not customer["customer_id"] or customer["customer_id"].strip() == "":
            errors.append("customer_id missing")

        if customer["customer_id"] in seen_customers:
            errors.append("duplicate customer_id")
        else:
            seen_customers.add(customer["customer_id"])

        if errors:
            customer["reason"] = ",".join(errors)
            invalid_customers.append(customer)
        else:
            valid_customers.append(customer)

    return valid_customers, invalid_customers


# ---------------- ENRICH SILVER ----------------


def enrich_orders(orders, customers_lookup, products_lookup):
    new_clean_orders = []

    for order in orders:
        customer_name = customers_lookup[order["customer_id"]]["customer_name"]
        city = customers_lookup[order["customer_id"]]["city"]
        product_name = products_lookup[order["product_id"]]["product_name"]
        category = products_lookup[order["product_id"]]["category"]
        price = products_lookup[order["product_id"]]["price"]

        orders_copy = order.copy()
        orders_copy["customer_name"] = customer_name
        orders_copy["city"] = city
        orders_copy["product_name"] = product_name
        orders_copy["category"] = category
        orders_copy["price"] = price
        orders_copy["total_amount"] = int(price) * int(order["quantity"])

        new_clean_orders.append(orders_copy)

    return new_clean_orders


# ---------------- BUSINESS REPORTS ----------------


def revenue_by_category(clean_orders):
    revenue_category = {}
    for order in clean_orders:
        if order["category"] not in revenue_category:
            revenue_category[order["category"]] = {
                "completed_revenue": 0,
                "total_completed_orders": 0
            }

        if order["status"] == "completed":
            revenue_category[order["category"]]["completed_revenue"] += (
                int(order["price"]) * int(order["quantity"])
            )
            revenue_category[order["category"]]["total_completed_orders"] += 1
    return revenue_category


def revenue_by_city(clean_orders):
    revenue_city = {}
    for order in clean_orders:
        if order["city"] not in revenue_city:
            revenue_city[order["city"]] = {
                "completed_revenue": 0,
                "total_completed_orders": 0
            }

        if order["status"] == "completed":
            revenue_city[order["city"]]["completed_revenue"] += (
                int(order["price"]) * int(order["quantity"])
            )
            revenue_city[order["city"]]["total_completed_orders"] += 1
    return revenue_city


def revenue_by_customers(clean_orders):
    revenue_customers = {}
    for order in clean_orders:
        customer_id = order["customer_id"]
        if customer_id not in revenue_customers:
            revenue_customers[customer_id] = {
                "customer_name": order["customer_name"],
                "city": order["city"],
                "completed_revenue": 0,
                "total_completed_orders": 0
            }

        if order["status"] == "completed":
            revenue_customers[customer_id]["completed_revenue"] += (
                int(order["price"]) * int(order["quantity"])
            )
            revenue_customers[customer_id]["total_completed_orders"] += 1
    return revenue_customers


def create_revenue_by_category(clean_orders):
    return revenue_by_category(clean_orders)


def create_revenue_by_city(clean_orders):
    return revenue_by_city(clean_orders)


def create_revenue_by_customer(clean_orders):
    return revenue_by_customers(clean_orders)


# ---------------- TOP PRODUCTS ----------------


def top_products(clean_orders):
    products = {}
    for order in clean_orders:
        if order["status"] != "completed":
            continue

        name = order["product_name"]
        if name not in products:
            products[name] = {
                "category": order["category"],
                "total_quantity_sold": 0,
                "completed_revenue": 0
            }

        products[name]["total_quantity_sold"] += int(order["quantity"])
        products[name]["completed_revenue"] += (
            int(order["price"]) * int(order["quantity"])
        )
    return products


def create_top_products(clean_orders):
    return top_products(clean_orders)


def write_top_products(products):
    rows = []
    for product, info in products.items():
        rows.append({
            "product_name": product,
            "category": info["category"],
            "total_quantity_sold": info["total_quantity_sold"],
            "completed_revenue": info["completed_revenue"]
        })

    rows.sort(
        key=lambda x: x["completed_revenue"],
        reverse=True
    )

    write_csv(
        "data/gold/top_products.csv",
        rows,
        [
            "product_name",
            "category",
            "total_quantity_sold",
            "completed_revenue"
        ]
    )


# ---------------- DATA QUALITY ----------------


def create_data_quality_report(
    raw_orders,
    clean_orders,
    invalid_orders,
    raw_customers,
    invalid_customers,
    raw_products,
    invalid_products,
):
    customer_ids_checked = sorted(list(set(c["customer_id"] for c in raw_customers)))
    product_ids_checked = sorted(list(set(p["product_id"] for p in raw_products)))

    duplicate_order_count = 0
    missing_date_count = 0
    invalid_qty_count = 0
    invalid_status_count = 0
    invalid_product_count = 0
    invalid_customer_count = 0
    invalid_price_count = 0
    missing_city_count = 0

    seen_order_ids = set()
    for o in raw_orders:
        oid = o.get("order_id", "").strip()
        if oid in seen_order_ids:
            duplicate_order_count += 1
        else:
            if oid:
                seen_order_ids.add(oid)

        if not o.get("order_date") or o["order_date"].strip() == "":
            missing_date_count += 1

    for io in invalid_orders:
        reason = io.get("reason", "")
        if "invalid quantity" in reason or "quantity must be positive" in reason:
            invalid_qty_count += 1
        if "product does not exist" in reason:
            invalid_product_count += 1
        if "customer does not exist" in reason:
            invalid_customer_count += 1

    for ip in invalid_products:
        reason_p = ip.get("reason", "")
        if "invalid price" in reason_p or "price must be positive" in reason_p:
            invalid_price_count += 1

    for rc in raw_customers:
        if not rc.get("city") or rc["city"].strip() in ["", "Unknown"]:
            missing_city_count += 1

    reason_counts = {}
    for item in invalid_orders + invalid_customers + invalid_products:
        for r in item.get("reason", "").split(","):
            if r:
                reason_counts[r] = reason_counts.get(r, 0) + 1

    reason_lines = "\n".join(
        [f"- {k}: {v}" for k, v in sorted(reason_counts.items(), key=lambda x: x[1], reverse=True)]
    )

    is_matching = (
        "YES" if len(raw_orders) == (len(clean_orders) + len(invalid_orders)) else "NO"
    )

    report = f"""Validation Checks
Raw orders count: {len(raw_orders)}
Silver clean orders count: {len(clean_orders)}
Invalid orders count: {len(invalid_orders)}
Raw = Silver + Invalid: {is_matching}

Customer IDs checked: {len(customer_ids_checked)}
Product IDs checked: {len(product_ids_checked)}
Duplicate order IDs found: {duplicate_order_count}
Missing dates found: {missing_date_count}
Invalid quantities found: {invalid_qty_count}
Invalid statuses found: {invalid_status_count}
Invalid products found: {invalid_product_count}
Invalid customers found: {invalid_customer_count}
Invalid product prices found: {invalid_price_count}
Missing customer cities found: {missing_city_count}

Invalid records by reason:
{reason_lines if reason_lines else "- None"}
"""

    with open("data_quality_report.txt", "w") as f:
        f.write(report)


# ---------------- EXECUTIVE SUMMARY ----------------


def executive_summary(clean_orders, invalid_orders, raw_orders):
    completed = [x for x in clean_orders if x["status"] == "completed"]
    pending = [x for x in clean_orders if x["status"] == "pending"]
    cancelled = [x for x in clean_orders if x["status"] == "cancelled"]

    revenue = sum(int(x["price"]) * int(x["quantity"]) for x in completed)

    categories = {}
    cities = {}
    customers = {}
    products = {}

    for order in completed:
        amount = int(order["price"]) * int(order["quantity"])
        categories[order["category"]] = categories.get(order["category"], 0) + amount
        cities[order["city"]] = cities.get(order["city"], 0) + amount
        customers[order["customer_name"]] = customers.get(order["customer_name"], 0) + amount
        products[order["product_name"]] = products.get(order["product_name"], 0) + amount

    top_category = max(categories, key=categories.get) if categories else "N/A"
    top_city = max(cities, key=cities.get) if cities else "N/A"
    top_customer = max(customers, key=customers.get) if customers else "N/A"
    top_product = max(products, key=products.get) if products else "N/A"

    reasons = {}
    for order in invalid_orders:
        reasons[order["reason"]] = reasons.get(order["reason"], 0) + 1

    most_invalid = max(reasons, key=reasons.get) if reasons else "None"

    recommendation = (
        f"Increase focus on {top_category} products "
        f"and promote {top_product} because they generate "
        f"the highest completed revenue."
    )

    text = f"""Executive Summary - Day 10 Pipeline

Total raw orders:
{len(raw_orders)}

Valid silver orders:
{len(clean_orders)}

Invalid orders:
{len(invalid_orders)}

Completed orders:
{len(completed)}

Pending orders:
{len(pending)}

Cancelled orders:
{len(cancelled)}

Completed revenue:
{revenue}

Top category:
{top_category}

Top city:
{top_city}

Top customer:
{top_customer}

Top product:
{top_product}

Most common invalid reason:
{most_invalid}

Business recommendation:
{recommendation}
"""

    with open("data/gold/executive_summary.txt", "w") as f:
        f.write(text)

    print(text)


# ---------------- MAIN PIPELINE ----------------


def main():
    ensure_output_folders()
    
   
    log_steps = []

    customers = load_csv("data/bronze/customers_raw.csv")
    orders = load_csv("data/bronze/orders_raw.csv")
    products = load_csv("data/bronze/products_raw.csv")
    log_steps.append("Loaded Bronze files.")

    print(f"Raw customers:{len(customers)}")
    print(f"Raw products:{len(products)}")
    print(f"Raw orders:{len(orders)}")

    
    for customer in customers:
        customer["city"] = normalize_city(customer["city"])
    valid_customers, invalid_customers = validate_customers(customers)
    customers_lookup = build_lookup(valid_customers, "customer_id")
    log_steps.append("Cleaned customers.")

    valid_products, invalid_products = validate_products(products)
    products_lookup = build_lookup(valid_products, "product_id")
    log_steps.append("Cleaned products.")


    for order in orders:
        order["status"] = normalize_status(order["status"])
        order["channel"] = normalize_channel(order["channel"])

    valid_orders, invalid_orders = validate_orders(
        orders, customers_lookup, products_lookup
    )
    log_steps.append("Validated orders.")

    clean_orders = enrich_orders(valid_orders, customers_lookup, products_lookup)
    write_csv(
        "data/silver/orders_clean.csv",
        clean_orders,
        [
            "order_id", "customer_id", "product_id", "customer_name", "category",
            "channel", "city", "order_date", "price", "quantity", "status",
            "total_amount", "product_name"
        ]
    )
    log_steps.append("Created Silver clean orders.")

   
    write_csv(
        "data/silver/invalid_orders.csv",
        invalid_orders,
        [
            "order_id", "customer_id", "order_date", "quantity", "reason",
            "status", "channel", "product_id"
        ]
    )
    log_steps.append("Created invalid orders file.")

  
    product_report = create_top_products(clean_orders)
    write_top_products(product_report)
    log_steps.append("Created Gold revenue reports.")

    create_data_quality_report(
        orders, clean_orders, invalid_orders,
        customers, invalid_customers, products, invalid_products
    )
    executive_summary(clean_orders, invalid_orders, orders)
    log_steps.append("Created executive summary.")

   
    write_pipeline_log(log_steps)


if __name__ == "__main__":
    main()