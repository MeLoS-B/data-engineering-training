from datetime import datetime

# Maps to clean raw values to approved values
STATUS_MAPPING = {
    "active": "active",
    "enabled": "active",
    "available": "active",
    "inactive": "inactive",
    "disabled": "inactive",

    "new": "new",
    "processing": "processing",
    "shipped": "shipped",
    "delivered": "delivered",
    "cancelled": "cancelled",
    "completed": "completed",
    "paid": "completed",

    "failed": "failed",
    "refunded": "refunded"
}

from src.config import COUNTRY_MAP as COUNTRY_MAPPING, CURRENCY_MAP as CURRENCY_MAPPING

def normalize_text(value):
    if value is None:
        return ""
    return " ".join(str(value).strip().split())

def normalize_email(email):
    return normalize_text(email).lower()

def normalize_status(status):
    status = normalize_text(status).lower()
    return STATUS_MAPPING.get(status, status)

def normalize_country(country):
    country = normalize_text(country).lower()
    return COUNTRY_MAPPING.get(country, country.title())

def normalize_city(city):
    city = normalize_text(city)
    return city.title()

def normalize_currency(currency):
    currency = normalize_text(currency).lower()
    return CURRENCY_MAPPING.get(currency, currency.upper())

def normalize_price(price):
    price = normalize_text(price)
    price = (
        price.replace("€", "")
             .replace("$", "")
             .replace(",", "")
    )
    return price

def parse_date(date_string):
    date_string = normalize_text(date_string)
    if not date_string:
        return None

    formats = [
        "%Y-%m-%d",
        "%Y-%m-%d %H:%M:%S",
        "%d/%m/%Y",
        "%m/%d/%Y",
    ]

    for fmt in formats:
        try:
            return datetime.strptime(date_string, fmt).strftime("%Y-%m-%d")
        except ValueError:
            continue

    return None