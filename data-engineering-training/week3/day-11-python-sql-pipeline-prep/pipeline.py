import csv
from pprint import pprint


def load_csv(file_path):
    with open(file_path, newline="") as f:
        reader = csv.DictReader(f)
        return list(reader)



customers = load_csv("data/bronze/customers_raw.csv")
orders = load_csv("data/bronze/orders_raw.csv")
products = load_csv("data/bronze/products_raw.csv")



# ---------------- NORMALIZATION ----------------

def normalize_city(city):

    if not city or city.strip() == "":
        return "Unknown"

    city = city.strip().lower()

    mapping = {
        "prishtina": "Prishtina",
        "mitrovica": "Mitrovica",
        "ferizaj": "Ferizaj",
        "vushtrri": "Vushtrri",
        "peja": "Peja",
        "prizren": "Prizren"
    }

    return mapping.get(city, city.title())



def normalize_status(status):

    if not status:
        return "unknown"

    status = status.strip().lower()

    mapping = {
        "completed":"completed",
        "done":"completed",
        "pending":"pending",
        "cancelled":"cancelled",
        "canceled":"cancelled",
        "returned":"cancelled"
    }

    return mapping.get(status,"unknown")



def normalize_channel(channel):

    if not channel or channel.strip()=="":
        return "unknown"

    channel = channel.strip().lower()

    if channel == "online":
        return "online"

    if channel == "store":
        return "store"

    return "unknown"



# ---------------- LOOKUPS ----------------


def lookup_function(data,key_field):

    lookup={}

    for row in data:
        lookup[row[key_field]]=row

    return lookup



# normalize customers

for customer in customers:
    customer["city"] = normalize_city(customer["city"])


for product in products:
    product["price"] = float(product["price"])



customer_lookup = lookup_function(
    customers,
    "customer_id"
)


product_lookup = lookup_function(
    products,
    "product_id"
)



# ---------------- VALIDATION ----------------


def validate_orders(
        orders,
        customer_lookup,
        product_lookup):


    valid=[]
    invalid=[]

    order_counts={}


    for order in orders:

        order_counts[order["order_id"]] = (
            order_counts.get(order["order_id"],0)+1
        )



    for order in orders:

        errors=[]


        if not order["quantity"] or order["quantity"].strip()=="":
            errors.append("missing quantity")

        else:

            try:

                if int(order["quantity"]) <=0:
                    errors.append("quantity <= 0")

            except:

                errors.append("invalid quantity")



        if not order["status"]:
            errors.append("missing status")


        if not order["channel"]:
            errors.append("missing channel")


        if not order["order_date"]:
            errors.append("missing date")



        if order["customer_id"] not in customer_lookup:
            errors.append("customer not found")


        if order["product_id"] not in product_lookup:
            errors.append("product not found")



        if order_counts[order["order_id"]] > 1:
            errors.append("duplicate order id")



        order["status"] = normalize_status(order["status"])

        order["channel"] = normalize_channel(order["channel"])



        if errors:

            order["errors"]=",".join(errors)
            invalid.append(order)

        else:

            valid.append(order)



    return valid,invalid




# ---------------- ENRICH ----------------


def enrich_orders(
        valid_orders,
        customer_lookup,
        product_lookup):


    result=[]


    for order in valid_orders:

        row=order.copy()


        customer = customer_lookup[
            order["customer_id"]
        ]

        product = product_lookup[
            order["product_id"]
        ]



        row["customer_name"] = customer["customer_name"]
        row["city"] = customer["city"]
        row["segment"] = customer["segment"]


        row["product_name"] = product["product_name"]
        row["category"] = product["category"]
        row["price"] = product["price"]



        row["total_amount"] = (
            int(row["quantity"])
            *
            float(row["price"])
        )


        result.append(row)


    return result




# ---------------- REPORTS ----------------


def revenue_by_city(data):

    result={}


    for order in data:

        city=order["city"]


        if city not in result:

            result[city]={
                "total_revenue":0,
                "total_orders":0
            }



        result[city]["total_revenue"] += order["total_amount"]

        result[city]["total_orders"] +=1


    return result




def revenue_by_category(data):

    result={}


    for order in data:

        category=order["category"]


        if category not in result:

            result[category]={
                "total_revenue":0,
                "total_orders":0
            }



        result[category]["total_revenue"] += order["total_amount"]

        result[category]["total_orders"] +=1



    return result




def top_customers(data):

    customers={}


    for order in data:

        cid=order["customer_id"]


        if cid not in customers:

            customers[cid]={
                "customer_id":cid,
                "customer_name":order["customer_name"],
                "city":order["city"],
                "total_orders":0,
                "total_revenue":0
            }



        customers[cid]["total_orders"]+=1

        customers[cid]["total_revenue"] += order["total_amount"]



    result=list(customers.values())


    result.sort(
        key=lambda x:x["total_revenue"],
        reverse=True
    )


    return result[:10]




# ---------------- WRITE CSV ----------------


def write_csv(data,file_path,fields):

    with open(file_path,"w",newline="") as f:

        writer=csv.DictWriter(
            f,
            fieldnames=fields
        )

        writer.writeheader()

        writer.writerows(data)



# ---------------- PIPELINE RUN ----------------


valid,invalid = validate_orders(
    orders,
    customer_lookup,
    product_lookup
)


clean_orders = enrich_orders(
    valid,
    customer_lookup,
    product_lookup
)



write_csv(
    clean_orders,
    "data/silver/orders_clean.csv",
    [
        "order_id",
        "customer_id",
        "customer_name",
        "city",
        "segment",
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
)



write_csv(
    invalid,
    "data/silver/invalid_orders.csv",
    [
        "order_id",
        "customer_id",
        "product_id",
        "quantity",
        "status",
        "channel",
        "order_date",
        "errors"
    ]
)



# GOLD


city_data=[]

for city,value in revenue_by_city(clean_orders).items():

    city_data.append({
        "city":city,
        **value
    })


write_csv(
    city_data,
    "data/gold/revenue_by_city.csv",
    [
        "city",
        "total_revenue",
        "total_orders"
    ]
)



category_data=[]

for cat,value in revenue_by_category(clean_orders).items():

    category_data.append({
        "category":cat,
        **value
    })


write_csv(
    category_data,
    "data/gold/revenue_by_category.csv",
    [
        "category",
        "total_revenue",
        "total_orders"
    ]
)



top = top_customers(clean_orders)


write_csv(
    top,
    "data/gold/top_customers.csv",
    [
        "customer_id",
        "customer_name",
        "city",
        "total_orders",
        "total_revenue"
    ]
)



summary=f"""
Executive Summary - Sales Pipeline

Total valid orders: {len(clean_orders)}

Invalid orders rejected: {len(invalid)}

Total revenue: {sum(x["total_amount"] for x in clean_orders):.2f}

Completed revenue:
{sum(x["total_amount"] for x in clean_orders if x["status"]=="completed"):.2f}


Cities:
{len(set(x["city"] for x in clean_orders))}


Categories:
{len(set(x["category"] for x in clean_orders))}


Top customer:
{top[0]["customer_name"] if top else "None"}

"""


with open(
    "data/gold/executive_summary.txt",
    "w"
) as f:

    f.write(summary)



print("Gold layer created successfully!")