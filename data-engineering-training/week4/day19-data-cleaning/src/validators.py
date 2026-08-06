import re
from datetime import datetime

from src.normalizers import (
    normalize_text,
    normalize_email,
    normalize_status,
    normalize_city,
    normalize_country,
    normalize_currency,
    normalize_price,
    parse_date,
)

from src.config import (
    CUSTOMER_STATUS,
    ORDER_STATUS,
    PRODUCT_STATUS,
    PAYMENT_STATUS,
    PAYMENT_METHODS,
    CURRENCY_MAP,
    COUNTRY_MAP
)

EMAIL_REGEX = r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"

APPROVED_CUSTOMER_STATUS = {"active", "inactive"}
APPROVED_PRODUCT_STATUS = {"active", "inactive"}
APPROVED_ORDER_STATUS = {"new", "processing", "shipped", "delivered", "cancelled", "completed"}
APPROVED_PAYMENT_STATUS = {"paid", "pending", "failed", "refunded"}
APPROVED_PAYMENT_METHODS = {"cash", "card", "bank_transfer", "paypal"}
APPROVED_CURRENCIES = {"EUR", "USD"}

def is_valid_email(email):
    return bool(re.match(EMAIL_REGEX, email))

def validate_customer(row):
    row = dict(row)
    row["customer_id"] = normalize_text(row.get("customer_id"))
    row["full_name"] = normalize_text(row.get("full_name"))
    row["email"] = normalize_email(row.get("email"))
    row["city"] = normalize_city(row.get("city"))
    row["country"] = normalize_country(row.get("country"))
    row["created_at"] = parse_date(row.get("created_at"))
    
    raw_status = normalize_text(row.get("status")).lower()
    row["status"] = CUSTOMER_STATUS.get(raw_status, raw_status)

    errors = []

    if not row["customer_id"]:
        errors.append("customer_id is required")

    if not row["full_name"]:
        errors.append("full_name is required")

    if not row["email"]:
        errors.append("email is required")
    elif not is_valid_email(row["email"]):
        errors.append("email is invalid")

    if not row["country"]:
        errors.append("country is required")

    if not row["created_at"]:
        errors.append("created_at is invalid")
    else:
        try:
            dt = datetime.strptime(row["created_at"], "%Y-%m-%d").date()
            if dt > datetime.now().date():
                errors.append("created_at cannot be in the future")
        except ValueError:
            errors.append("created_at is invalid")

    if row["status"] not in APPROVED_CUSTOMER_STATUS:
        errors.append(f"customer status '{row.get('status')}' is invalid")

    return row, errors

def validate_product(row):
    row = dict(row)
    row["product_id"] = normalize_text(row.get("product_id"))
    row["product_name"] = normalize_text(row.get("product_name"))
    row["category"] = normalize_text(row.get("category")).title()
    row["price"] = normalize_price(row.get("price"))
    row["stock_quantity"] = normalize_text(row.get("stock_quantity"))
    row["supplier_id"] = normalize_text(row.get("supplier_id"))
    row["currency"] = normalize_currency(row.get("currency", "EUR"))

    raw_status = normalize_text(row.get("status")).lower()
    row["status"] = PRODUCT_STATUS.get(raw_status, raw_status)

    errors = []

    if not row["product_id"]:
        errors.append("product_id is required")

    if not row["product_name"]:
        errors.append("product_name is required")

    if not row["category"]:
        errors.append("category is required")

    try:
        price_val = float(row["price"])
        row["price"] = price_val
        if price_val <= 0:
            errors.append("price must be greater than zero")
    except (ValueError, TypeError):
        errors.append("price is invalid or missing")

    try:
        stock_val = int(row["stock_quantity"])
        row["stock_quantity"] = stock_val
        if stock_val < 0:
            errors.append("stock_quantity cannot be negative")
    except (ValueError, TypeError):
        errors.append("stock_quantity is invalid or missing")

    if row["status"] not in APPROVED_PRODUCT_STATUS:
        errors.append(f"product status '{row.get('status')}' is invalid")

    if row["currency"] not in APPROVED_CURRENCIES:
        errors.append(f"currency '{row.get('currency')}' is invalid")

    return row, errors

def validate_order(row, trusted_customers):
    row = dict(row)
    row["order_id"] = normalize_text(row.get("order_id"))
    row["customer_id"] = normalize_text(row.get("customer_id"))
    row["order_date"] = parse_date(row.get("order_date"))
    row["shipping_city"] = normalize_city(row.get("shipping_city"))
    
    # Default country to customer's country
    cust_id = row["customer_id"]
    if cust_id in trusted_customers:
        row["shipping_country"] = trusted_customers[cust_id].get("country", "")
    else:
        row["shipping_country"] = ""

    raw_status = normalize_text(row.get("status")).lower()
    row["status"] = ORDER_STATUS.get(raw_status, raw_status)

    raw_pm = normalize_text(row.get("payment_method")).lower()
    row["payment_method"] = PAYMENT_METHODS.get(raw_pm, raw_pm)

    errors = []

    if not row["order_id"]:
        errors.append("order_id is required")

    if not row["customer_id"]:
        errors.append("customer_id is required")
    elif row["customer_id"] not in trusted_customers:
        errors.append("customer_id does not exist in trusted customers")

    if not row["order_date"]:
        errors.append("order_date is invalid or missing")
    else:
        try:
            dt = datetime.strptime(row["order_date"], "%Y-%m-%d").date()
            if dt > datetime.now().date():
                errors.append("order_date cannot be in the future")
        except ValueError:
            errors.append("order_date is invalid")

    if row["status"] not in APPROVED_ORDER_STATUS:
        errors.append(f"order status '{row.get('status')}' is invalid")

    if row["payment_method"] and row["payment_method"] not in APPROVED_PAYMENT_METHODS:
        errors.append(f"payment_method '{row.get('payment_method')}' is invalid")

    return row, errors

def validate_order_item(row, trusted_orders, trusted_products):
    row = dict(row)
    row["order_item_id"] = normalize_text(row.get("order_item_id"))
    row["order_id"] = normalize_text(row.get("order_id"))
    row["product_id"] = normalize_text(row.get("product_id"))
    row["quantity"] = normalize_text(row.get("quantity"))
    row["unit_price"] = normalize_price(row.get("unit_price"))
    row["discount_amount"] = 0.0

    errors = []

    if not row["order_item_id"]:
        errors.append("order_item_id is required")

    if not row["order_id"]:
        errors.append("order_id is required")
    elif row["order_id"] not in trusted_orders:
        errors.append("order_id does not exist in trusted orders")

    if not row["product_id"]:
        errors.append("product_id is required")
    elif row["product_id"] not in trusted_products:
        errors.append("product_id does not exist in trusted products")

    try:
        qty = int(row["quantity"])
        row["quantity"] = qty
        if qty <= 0:
            errors.append("quantity must be greater than zero")
    except (ValueError, TypeError):
        errors.append("quantity is invalid or missing")

    try:
        price = float(row["unit_price"])
        row["unit_price"] = price
        if price <= 0:
            errors.append("unit_price must be greater than zero")
    except (ValueError, TypeError):
        errors.append("unit_price is invalid or missing")

    if not errors:
        row["line_total"] = round(row["quantity"] * row["unit_price"] - row["discount_amount"], 2)
    else:
        row["line_total"] = 0.0

    return row, errors

def validate_payment(row, trusted_orders):
    row = dict(row)
    row["payment_id"] = normalize_text(row.get("payment_id"))
    row["order_id"] = normalize_text(row.get("order_id"))
    row["payment_date"] = parse_date(row.get("payment_date"))
    row["amount"] = normalize_price(row.get("amount"))
    row["currency"] = normalize_currency(row.get("currency"))

    raw_status = normalize_text(row.get("status")).lower()
    row["status"] = PAYMENT_STATUS.get(raw_status, raw_status)

    raw_pm = normalize_text(row.get("payment_method")).lower()
    row["payment_method"] = PAYMENT_METHODS.get(raw_pm, raw_pm)

    errors = []

    if not row["payment_id"]:
        errors.append("payment_id is required")

    if not row["order_id"]:
        errors.append("order_id is required")
    elif row["order_id"] not in trusted_orders:
        errors.append("order_id does not exist in trusted orders")

    if not row["payment_date"]:
        errors.append("payment_date is invalid or missing")
    else:
        try:
            dt = datetime.strptime(row["payment_date"], "%Y-%m-%d").date()
            if dt > datetime.now().date():
                errors.append("payment_date cannot be in the future")
        except ValueError:
            errors.append("payment_date is invalid")

    try:
        amt = float(row["amount"])
        row["amount"] = amt
        if amt <= 0:
            errors.append("amount must be greater than zero")
    except (ValueError, TypeError):
        errors.append("amount is invalid or missing")

    if row["currency"] not in APPROVED_CURRENCIES:
        errors.append(f"currency '{row.get('currency')}' is invalid")

    if row["payment_method"] not in APPROVED_PAYMENT_METHODS:
        errors.append(f"payment_method '{row.get('payment_method')}' is invalid")

    if row["status"] not in APPROVED_PAYMENT_STATUS:
        errors.append(f"payment status '{row.get('status')}' is invalid")

    return row, errors