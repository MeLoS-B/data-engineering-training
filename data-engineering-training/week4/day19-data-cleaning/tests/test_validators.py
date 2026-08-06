import unittest
from datetime import datetime

from src.normalizers import (
    normalize_text,
    normalize_email,
    normalize_status,
    normalize_country,
    normalize_city,
    normalize_currency,
    normalize_price,
    parse_date,
)

from src.validators import (
    validate_customer,
    validate_product,
    validate_order,
    validate_order_item,
    validate_payment,
    is_valid_email
)

class TestNormalizers(unittest.TestCase):
    def test_normalize_text(self):
        self.assertEqual(normalize_text("  hello   world  "), "hello world")
        self.assertEqual(normalize_text(None), "")
        self.assertEqual(normalize_text(123), "123")

    def test_normalize_email(self):
        self.assertEqual(normalize_email(" USER1@MAIL.COM  "), "user1@mail.com")

    def test_normalize_status(self):
        self.assertEqual(normalize_status("ACTIVE"), "active")
        self.assertEqual(normalize_status("enabled"), "active")
        self.assertEqual(normalize_status("unknown"), "unknown")

    def test_normalize_country(self):
        self.assertEqual(normalize_country("us"), "United States")
        self.assertEqual(normalize_country("kosovo"), "Kosovo")
        self.assertEqual(normalize_country("ks"), "Kosovo")
        self.assertEqual(normalize_country("germany"), "Germany")

    def test_normalize_city(self):
        self.assertEqual(normalize_city("  prishtina "), "Prishtina")

    def test_normalize_currency(self):
        self.assertEqual(normalize_currency("eur"), "EUR")
        self.assertEqual(normalize_currency("€"), "EUR")
        self.assertEqual(normalize_currency("$"), "USD")

    def test_normalize_price(self):
        self.assertEqual(normalize_price("€232.19"), "232.19")
        self.assertEqual(normalize_price(" $1,08.87 "), "108.87")

    def test_parse_date(self):
        self.assertEqual(parse_date("2026-01-02"), "2026-01-02")
        self.assertEqual(parse_date("02/01/2026"), "2026-01-02")
        self.assertEqual(parse_date("invalid-date"), None)


class TestValidators(unittest.TestCase):
    def test_validate_customer_valid(self):
        row = {
            "customer_id": "1",
            "full_name": "Test Customer",
            "email": "test@mail.com",
            "city": "Prishtina",
            "country": "Kosovo",
            "created_at": "2026-01-02",
            "status": "Active"
        }
        cleaned, errors = validate_customer(row)
        self.assertEqual(errors, [])
        self.assertEqual(cleaned["status"], "active")
        self.assertEqual(cleaned["country"], "Kosovo")

    def test_validate_customer_invalid(self):
        row = {
            "customer_id": "",
            "full_name": "   ",
            "email": "bademail",
            "city": "Prishtina",
            "country": "",
            "created_at": "invalid-date",
            "status": "unknown"
        }
        cleaned, errors = validate_customer(row)
        self.assertIn("customer_id is required", errors)
        self.assertIn("full_name is required", errors)
        self.assertIn("email is invalid", errors)
        self.assertIn("country is required", errors)
        self.assertIn("created_at is invalid", errors)
        self.assertIn("customer status 'unknown' is invalid", errors)

    def test_validate_product_valid(self):
        row = {
            "product_id": "P1",
            "product_name": "Laptop x1",
            "category": "laptop",
            "price": "€1,200.50",
            "stock_quantity": "10",
            "supplier_id": "3",
            "status": "active"
        }
        cleaned, errors = validate_product(row)
        self.assertEqual(errors, [])
        self.assertEqual(cleaned["price"], 1200.50)
        self.assertEqual(cleaned["stock_quantity"], 10)
        self.assertEqual(cleaned["category"], "Laptop")

    def test_validate_product_invalid(self):
        row = {
            "product_id": "",
            "product_name": "",
            "category": "",
            "price": "-50",
            "stock_quantity": "-5",
            "status": "invalid"
        }
        cleaned, errors = validate_product(row)
        self.assertIn("product_id is required", errors)
        self.assertIn("price must be greater than zero", errors)
        self.assertIn("stock_quantity cannot be negative", errors)

if __name__ == "__main__":
    unittest.main()
