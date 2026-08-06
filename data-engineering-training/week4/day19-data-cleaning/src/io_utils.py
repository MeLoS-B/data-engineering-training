import csv
import os
from typing import List, Dict


def ensure_directory(path: str):
    """Create directory if it doesn't exist."""
    os.makedirs(path, exist_ok=True)


def load_csv(filepath: str, required_columns: List[str] = None) -> List[Dict]:
    """
    Load a CSV file and return rows as dictionaries.
    Optionally checks that all required_columns exist in the file header.
    """

    if not os.path.exists(filepath):
        raise FileNotFoundError(f"File not found: {filepath}")

    with open(filepath, "r", encoding="utf-8", newline="") as file:
        reader = csv.DictReader(file)
        rows = list(reader)

    if required_columns and rows:
        missing = [col for col in required_columns if col not in rows[0]]
        if missing:
            raise ValueError(f"{filepath} is missing required columns: {missing}")

    return rows


def write_csv(filepath: str, rows: List[Dict]):
    """
    Write rows to CSV.
    """

    if not rows:
        return

    ensure_directory(os.path.dirname(filepath))

    with open(filepath, "w", encoding="utf-8", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)


def copy_file(source: str, destination: str):
    """
    Copy a CSV file exactly (Bronze layer).
    """

    ensure_directory(os.path.dirname(destination))

    with open(source, "r", encoding="utf-8") as src:
        with open(destination, "w", encoding="utf-8") as dst:
            dst.write(src.read())