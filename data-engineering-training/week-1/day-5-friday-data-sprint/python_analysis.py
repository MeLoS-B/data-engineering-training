def load_orders():
    orders = []

    with open("data/orders.csv") as f:
        next(f)

        for line in f:
            data = line.strip().split(",")
            orders.append(data)

    return orders



def calculate_total_amount(orders):
    orders_with_total = []

    for order in orders:
        quantity = int(order[5])
        price = int(order[6])

        total_amount = quantity * price

        order.append(total_amount)
        orders_with_total.append(order)

    return orders_with_total



def get_completed_orders(orders):
    completed_orders = []

    for order in orders:
        if order[7] == "completed":
            completed_orders.append(order)

    return completed_orders



def calculate_completed_revenue(orders):
    revenue = 0

    for order in orders:
        if order[7] == "completed":
            quantity = int(order[5])
            price = int(order[6])

            revenue += quantity * price

    return revenue



def count_by_status(orders):
    count_status = {}

    for order in orders:
        status = order[7]

        if status in count_status:
            count_status[status] += 1
        else:
            count_status[status] = 1

    return count_status



def count_by_city(orders):
    count_city = {}

    for order in orders:
        city = order[2]

        if city in count_city:
            count_city[city] += 1
        else:
            count_city[city] = 1

    return count_city



def count_by_category(orders):
    count_category = {}

    for order in orders:
        category = order[4]

        if category in count_category:
            count_category[category] += 1
        else:
            count_category[category] = 1

    return count_category



def find_highest_order(orders):
    highest_order = None
    highest_amount = 0

    for order in orders:
        quantity = int(order[5])
        price = int(order[6])

        total = quantity * price

        if total > highest_amount:
            highest_amount = total
            highest_order = order

    return highest_order, highest_amount



def print_business_report():

    orders = load_orders()

    orders_with_total = calculate_total_amount(orders)

    completed_orders = get_completed_orders(orders)

    revenue = calculate_completed_revenue(orders)

    status_report = count_by_status(orders)

    city_report = count_by_city(orders)

    category_report = count_by_category(orders)

    highest_order, highest_amount = find_highest_order(orders)


    print("=" * 40)
    print("Unity Tech Hub x Agilyti")
    print("Day 5 Friday Data Sprint")
    print("BUSINESS REPORT")
    print("=" * 40)


    print("\nTotal Orders:", len(orders))


    print("\nCompleted Orders:")
    for order in completed_orders:
        print(order)


    print("\nCompleted Revenue:")
    print(f"${revenue}")


    print("\nOrders By Status:")
    for status, count in status_report.items():
        print(f"{status}: {count}")


    print("\nOrders By City:")
    for city, count in city_report.items():
        print(f"{city}: {count}")


    print("\nOrders By Category:")
    for category, count in category_report.items():
        print(f"{category}: {count}")


    print("\nHighest Order:")
    print(highest_order)
    print("Total Amount:", highest_amount)


    print("=" * 40)



def main():
    print_business_report()



main()