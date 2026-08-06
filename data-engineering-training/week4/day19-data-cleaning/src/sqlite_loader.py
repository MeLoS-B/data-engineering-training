import os
import sqlite3
import csv
from src.io_utils import load_csv, ensure_directory

def load_sqlite(silver_dir: str, db_path: str):
    ensure_directory(os.path.dirname(db_path))

    conn = sqlite3.connect(db_path)
    conn.execute("PRAGMA foreign_keys = ON;")
    
    try:
        # Recreate schema
        sql_setup_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "sql", "setup.sql")
        with open(sql_setup_path, "r", encoding="utf-8") as f:
            setup_sql = f.read()
        conn.executescript(setup_sql)
        conn.commit()
        
        cursor = conn.cursor()
        
        # Load tables
        customers = load_csv(os.path.join(silver_dir, "customers_clean.csv"))
        cursor.executemany(
            """
            INSERT INTO customers (customer_id, full_name, email, city, country, created_at, status)
            VALUES (:customer_id, :full_name, :email, :city, :country, :created_at, :status)
            """,
            customers
        )

        products = load_csv(os.path.join(silver_dir, "products_clean.csv"))
        cursor.executemany(
            """
            INSERT INTO products (product_id, product_name, category, price, currency, stock_quantity, supplier_id, status)
            VALUES (:product_id, :product_name, :category, :price, :currency, :stock_quantity, :supplier_id, :status)
            """,
            products
        )

        orders = load_csv(os.path.join(silver_dir, "orders_clean.csv"))
        cursor.executemany(
            """
            INSERT INTO orders (order_id, customer_id, order_date, status, shipping_city, shipping_country, payment_method)
            VALUES (:order_id, :customer_id, :order_date, :status, :shipping_city, :shipping_country, :payment_method)
            """,
            orders
        )

        order_items = load_csv(os.path.join(silver_dir, "order_items_clean.csv"))
        cursor.executemany(
            """
            INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount_amount, line_total)
            VALUES (:order_item_id, :order_id, :product_id, :quantity, :unit_price, :discount_amount, :line_total)
            """,
            order_items
        )

        payments = load_csv(os.path.join(silver_dir, "payments_clean.csv"))
        cursor.executemany(
            """
            INSERT INTO payments (payment_id, order_id, payment_date, amount, currency, payment_method, status)
            VALUES (:payment_id, :order_id, :payment_date, :amount, :currency, :payment_method, :status)
            """,
            payments
        )
        
        conn.commit()

        # Validate loaded row counts match clean Silver files
        tables = ["customers", "products", "orders", "order_items", "payments"]
        expected_counts = {
            "customers": len(customers),
            "products": len(products),
            "orders": len(orders),
            "order_items": len(order_items),
            "payments": len(payments)
        }
        
        for table in tables:
            cursor.execute(f"SELECT COUNT(*) FROM {table}")
            db_count = cursor.fetchone()[0]
            expected = expected_counts[table]
            if db_count != expected:
                raise ValueError(f"Count mismatch for {table}: DB has {db_count}, expected {expected}")

    except Exception as e:
        conn.rollback()
        print(f"Error loading to SQLite: {e}")
        raise e
    finally:
        conn.close()

def run_reports(db_path: str, report_dir: str):
    ensure_directory(report_dir)
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Reconciliation Report
    reconcile_sql_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "sql", "reconciliation_reports.sql")
    with open(reconcile_sql_path, "r", encoding="utf-8") as f:
        reconcile_sql = f.read()
    
    cursor.execute(reconcile_sql)
    rows = cursor.fetchall()
    headers = [col[0] for col in cursor.description]
    
    reconcile_csv_path = os.path.join(report_dir, "reconciliation_report.csv")
    with open(reconcile_csv_path, "w", encoding="utf-8", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(headers)
        writer.writerows(rows)
    
    # Business Reports
    business_sql_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "sql", "business_reports.sql")
    with open(business_sql_path, "r", encoding="utf-8") as f:
        business_sql = f.read()
        
    queries = business_sql.split(";")
    
    report_names = [
        "revenue_by_customer.csv",
        "revenue_by_city.csv",
        "revenue_by_category.csv",
        "top_products.csv",
        "top_customers.csv",
        "products_never_sold.csv",
        "customers_without_orders.csv",
        "orders_without_payments.csv"
    ]
    
    report_idx = 0
    for q in queries:
        q_strip = q.strip()
        if not q_strip or "select" not in q_strip.lower():
            continue
            
        try:
            cursor.execute(q_strip)
            rows = cursor.fetchall()
            headers = [col[0] for col in cursor.description]
            
            if report_idx < len(report_names):
                name = report_names[report_idx]
                report_idx += 1
            else:
                name = f"business_report_{report_idx}.csv"
                report_idx += 1
                
            csv_path = os.path.join(report_dir, name)
            with open(csv_path, "w", encoding="utf-8", newline="") as f:
                writer = csv.writer(f)
                writer.writerow(headers)
                writer.writerows(rows)
        except Exception as e:
            print(f"Failed to run query: {e}")
            
    conn.close()
