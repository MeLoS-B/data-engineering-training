import os
import datetime
from src.io_utils import load_csv, write_csv, copy_file, ensure_directory
from src.validators import (
    validate_customer,
    validate_product,
    validate_order,
    validate_order_item,
    validate_payment
)
from src.quality import generate_quality_report
from src.sqlite_loader import load_sqlite

def run_pipeline(raw_dir: str, bronze_dir: str, silver_dir: str, invalid_dir: str, db_path: str, report_dir: str):
    print("Running data cleaning pipeline...")
    processed_at = datetime.datetime.now().isoformat() + "Z"

    # Step 1: Copy raw files to Bronze
    print("Copying raw files to bronze layer...")
    ensure_directory(bronze_dir)
    files = ["customers_raw.csv", "products_raw.csv", "orders_raw.csv", "order_items_raw.csv", "payments_raw.csv"]
    manifest = []
    
    for f in files:
        src = os.path.join(raw_dir, f)
        dst = os.path.join(bronze_dir, f)
        copy_file(src, dst)
        size = os.path.getsize(dst)
        manifest.append({
            "file_name": f,
            "ingested_at": processed_at,
            "size_bytes": size
        })
    write_csv(os.path.join(bronze_dir, "ingestion_manifest.csv"), manifest)

    # Cleaned lookups for referential checks
    trusted_customers = {}
    trusted_products = {}
    trusted_orders = {}
    
    metrics = {}

    def make_invalid_row(original_row, source_file, row_number, record_key, errors):
        invalid_row = {
            "source_file": source_file,
            "source_row_number": row_number,
            "record_key": record_key,
            "invalid_reasons": "; ".join(errors),
            "processed_at": processed_at
        }
        for k, v in original_row.items():
            invalid_row[f"raw_{k}"] = v
        return invalid_row

    # Step 2: Validate Customers
    print("Validating customers...")
    raw_customers = load_csv(os.path.join(bronze_dir, "customers_raw.csv"))
    valid_cust_list = []
    invalid_cust_list = []
    seen_customer_ids = set()
    seen_emails = set()
    duplicate_count = 0
    missing_required_count = {"customer_id": 0, "full_name": 0, "email": 0, "country": 0, "created_at": 0}
    error_rule_counts = {}

    for idx, row in enumerate(raw_customers):
        row_num = idx + 2
        original_row = dict(row)
        cleaned, errors = validate_customer(row)
        cust_id = cleaned.get("customer_id")
        email = cleaned.get("email")

        for field in missing_required_count:
            if not original_row.get(field):
                missing_required_count[field] += 1

        is_duplicate = False
        if cust_id:
            if cust_id in seen_customer_ids:
                errors.append(f"duplicate customer_id '{cust_id}'")
                is_duplicate = True
            else:
                seen_customer_ids.add(cust_id)
                
        if email:
            if email in seen_emails:
                errors.append(f"duplicate email '{email}'")
                is_duplicate = True
            else:
                seen_emails.add(email)

        if is_duplicate:
            duplicate_count += 1

        if errors:
            for err in errors:
                error_rule_counts[err] = error_rule_counts.get(err, 0) + 1
            invalid_cust_list.append(make_invalid_row(original_row, "customers_raw.csv", row_num, cust_id or "", errors))
        else:
            valid_cust_list.append(cleaned)
            trusted_customers[cust_id] = cleaned

    write_csv(os.path.join(silver_dir, "customers_clean.csv"), valid_cust_list)
    write_csv(os.path.join(invalid_dir, "customers_invalid.csv"), invalid_cust_list)
    
    metrics["customers"] = {
        "raw_rows": len(raw_customers),
        "valid_rows": len(valid_cust_list),
        "invalid_rows": len(invalid_cust_list),
        "duplicate_rows": duplicate_count,
        "missing_required": missing_required_count,
        "error_rules": error_rule_counts
    }

    # Step 3: Validate Products
    print("Validating products...")
    raw_products = load_csv(os.path.join(bronze_dir, "products_raw.csv"))
    valid_prod_list = []
    invalid_prod_list = []
    seen_product_ids = set()
    prod_duplicate_count = 0
    prod_missing_required = {"product_id": 0, "product_name": 0, "category": 0}
    prod_error_rules = {}

    for idx, row in enumerate(raw_products):
        row_num = idx + 2
        original_row = dict(row)
        cleaned, errors = validate_product(row)
        prod_id = cleaned.get("product_id")

        for field in prod_missing_required:
            if not original_row.get(field):
                prod_missing_required[field] += 1

        if prod_id:
            if prod_id in seen_product_ids:
                errors.append(f"duplicate product_id '{prod_id}'")
                prod_duplicate_count += 1
            else:
                seen_product_ids.add(prod_id)

        if errors:
            for err in errors:
                prod_error_rules[err] = prod_error_rules.get(err, 0) + 1
            invalid_prod_list.append(make_invalid_row(original_row, "products_raw.csv", row_num, prod_id or "", errors))
        else:
            valid_prod_list.append(cleaned)
            trusted_products[prod_id] = cleaned

    write_csv(os.path.join(silver_dir, "products_clean.csv"), valid_prod_list)
    write_csv(os.path.join(invalid_dir, "products_invalid.csv"), invalid_prod_list)

    metrics["products"] = {
        "raw_rows": len(raw_products),
        "valid_rows": len(valid_prod_list),
        "invalid_rows": len(invalid_prod_list),
        "duplicate_rows": prod_duplicate_count,
        "missing_required": prod_missing_required,
        "error_rules": prod_error_rules
    }

    # Step 4: Validate Orders
    print("Validating orders...")
    raw_orders = load_csv(os.path.join(bronze_dir, "orders_raw.csv"))
    valid_order_list = []
    invalid_order_list = []
    seen_order_ids = set()
    order_duplicate_count = 0
    order_missing_required = {"order_id": 0, "customer_id": 0, "order_date": 0}
    order_error_rules = {}
    orphan_customer_count = 0

    for idx, row in enumerate(raw_orders):
        row_num = idx + 2
        original_row = dict(row)
        cleaned, errors = validate_order(row, trusted_customers)
        ord_id = cleaned.get("order_id")
        cust_id = cleaned.get("customer_id")

        for field in order_missing_required:
            if not original_row.get(field):
                order_missing_required[field] += 1

        if ord_id:
            if ord_id in seen_order_ids:
                errors.append(f"duplicate order_id '{ord_id}'")
                order_duplicate_count += 1
            else:
                seen_order_ids.add(ord_id)

        if cust_id and cust_id not in trusted_customers:
            orphan_customer_count += 1

        if errors:
            for err in errors:
                order_error_rules[err] = order_error_rules.get(err, 0) + 1
            invalid_order_list.append(make_invalid_row(original_row, "orders_raw.csv", row_num, ord_id or "", errors))
        else:
            valid_order_list.append(cleaned)
            trusted_orders[ord_id] = cleaned

    write_csv(os.path.join(silver_dir, "orders_clean.csv"), valid_order_list)
    write_csv(os.path.join(invalid_dir, "orders_invalid.csv"), invalid_order_list)

    metrics["orders"] = {
        "raw_rows": len(raw_orders),
        "valid_rows": len(valid_order_list),
        "invalid_rows": len(invalid_order_list),
        "duplicate_rows": order_duplicate_count,
        "missing_required": order_missing_required,
        "error_rules": order_error_rules,
        "orphan_records": orphan_customer_count
    }

    # Step 5: Validate Order Items
    print("Validating order items...")
    raw_items = load_csv(os.path.join(bronze_dir, "order_items_raw.csv"))
    valid_items_list = []
    invalid_items_list = []
    seen_item_ids = set()
    item_duplicate_count = 0
    item_missing_required = {"order_item_id": 0, "order_id": 0, "product_id": 0}
    item_error_rules = {}
    orphan_order_count = 0
    orphan_product_count = 0

    for idx, row in enumerate(raw_items):
        row_num = idx + 2
        original_row = dict(row)
        cleaned, errors = validate_order_item(row, trusted_orders, trusted_products)
        item_id = cleaned.get("order_item_id")
        ord_id = cleaned.get("order_id")
        prod_id = cleaned.get("product_id")

        for field in item_missing_required:
            if not original_row.get(field):
                item_missing_required[field] += 1

        if item_id:
            if item_id in seen_item_ids:
                errors.append(f"duplicate order_item_id '{item_id}'")
                item_duplicate_count += 1
            else:
                seen_item_ids.add(item_id)

        if ord_id and ord_id not in trusted_orders:
            orphan_order_count += 1
        if prod_id and prod_id not in trusted_products:
            orphan_product_count += 1

        if errors:
            for err in errors:
                item_error_rules[err] = item_error_rules.get(err, 0) + 1
            invalid_items_list.append(make_invalid_row(original_row, "order_items_raw.csv", row_num, item_id or "", errors))
        else:
            valid_items_list.append(cleaned)

    write_csv(os.path.join(silver_dir, "order_items_clean.csv"), valid_items_list)
    write_csv(os.path.join(invalid_dir, "order_items_invalid.csv"), invalid_items_list)

    metrics["order_items"] = {
        "raw_rows": len(raw_items),
        "valid_rows": len(valid_items_list),
        "invalid_rows": len(invalid_items_list),
        "duplicate_rows": item_duplicate_count,
        "missing_required": item_missing_required,
        "error_rules": item_error_rules,
        "orphan_records": orphan_order_count + orphan_product_count
    }

    # Step 6: Validate Payments
    print("Validating payments...")
    raw_payments = load_csv(os.path.join(bronze_dir, "payments_raw.csv"))
    valid_payments_list = []
    invalid_payments_list = []
    seen_payment_ids = set()
    pay_duplicate_count = 0
    pay_missing_required = {"payment_id": 0, "order_id": 0}
    pay_error_rules = {}
    pay_orphan_count = 0

    for idx, row in enumerate(raw_payments):
        row_num = idx + 2
        original_row = dict(row)
        cleaned, errors = validate_payment(row, trusted_orders)
        pay_id = cleaned.get("payment_id")
        ord_id = cleaned.get("order_id")

        for field in pay_missing_required:
            if not original_row.get(field):
                pay_missing_required[field] += 1

        if pay_id:
            if pay_id in seen_payment_ids:
                errors.append(f"duplicate payment_id '{pay_id}'")
                pay_duplicate_count += 1
            else:
                seen_payment_ids.add(pay_id)

        if ord_id and ord_id not in trusted_orders:
            pay_orphan_count += 1

        if errors:
            for err in errors:
                pay_error_rules[err] = pay_error_rules.get(err, 0) + 1
            invalid_payments_list.append(make_invalid_row(original_row, "payments_raw.csv", row_num, pay_id or "", errors))
        else:
            valid_payments_list.append(cleaned)

    write_csv(os.path.join(silver_dir, "payments_clean.csv"), valid_payments_list)
    write_csv(os.path.join(invalid_dir, "payments_invalid.csv"), invalid_payments_list)

    metrics["payments"] = {
        "raw_rows": len(raw_payments),
        "valid_rows": len(valid_payments_list),
        "invalid_rows": len(invalid_payments_list),
        "duplicate_rows": pay_duplicate_count,
        "missing_required": pay_missing_required,
        "error_rules": pay_error_rules,
        "orphan_records": pay_orphan_count
    }

    # Step 7: Quality Report
    print("Writing data quality reports...")
    generate_quality_report(metrics, report_dir)

    # Step 8: Load to Database
    print("Loading clean data into SQLite database...")
    load_sqlite(silver_dir, db_path)

    # Step 9: Run SQL Report scripts
    print("Running SQL reports and exporting results...")
    from src.sqlite_loader import run_reports
    gold_dir = os.path.dirname(db_path)
    run_reports(db_path, gold_dir)

    print("Pipeline run finished successfully.")
