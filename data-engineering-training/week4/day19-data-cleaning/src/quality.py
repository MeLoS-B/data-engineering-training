import os
import json
from src.io_utils import ensure_directory

def generate_quality_report(metrics: dict, report_dir: str):
    ensure_directory(report_dir)

    for dataset, data in metrics.items():
        raw = data.get("raw_rows", 0)
        valid = data.get("valid_rows", 0)
        data["cleaning_success_rate"] = round((valid / raw * 100), 2) if raw > 0 else 0.0

    json_path = os.path.join(report_dir, "quality_metrics.json")
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(metrics, f, indent=4)

    txt_path = os.path.join(report_dir, "quality_summary.txt")
    with open(txt_path, "w", encoding="utf-8") as f:
        f.write("========================================================================\n")
        f.write("                    DATA QUALITY REPORT SUMMARY                          \n")
        f.write("========================================================================\n\n")
        
        f.write(f"{'Dataset':<15} | {'Raw Rows':<10} | {'Valid Rows':<10} | {'Invalid Rows':<12} | {'Duplicates':<10} | {'Success Rate':<12}\n")
        f.write("-" * 80 + "\n")
        for dataset, data in metrics.items():
            f.write(
                f"{dataset:<15} | "
                f"{data['raw_rows']:<10} | "
                f"{data['valid_rows']:<10} | "
                f"{data['invalid_rows']:<12} | "
                f"{data['duplicate_rows']:<10} | "
                f"{data['cleaning_success_rate']:.1f}%\n"
            )
        f.write("\n" + "="*80 + "\n\n")

        for dataset, data in metrics.items():
            f.write(f"### Dataset: {dataset.upper()}\n")
            f.write(f"  - Raw rows ingested: {data['raw_rows']}\n")
            f.write(f"  - Valid rows stored: {data['valid_rows']}\n")
            f.write(f"  - Invalid rows rejected: {data['invalid_rows']}\n")
            f.write(f"  - Duplicate rows isolated: {data['duplicate_rows']}\n")
            if "orphan_records" in data:
                f.write(f"  - Orphan parent records: {data['orphan_records']}\n")
            f.write(f"  - Success rate: {data['cleaning_success_rate']:.2f}%\n\n")

            f.write("  - Missing required fields:\n")
            has_missing = False
            for field, count in data.get("missing_required", {}).items():
                if count > 0:
                    f.write(f"    * {field}: {count}\n")
                    has_missing = True
            if not has_missing:
                f.write("    * None\n")

            f.write("  - Validation failures by rule:\n")
            has_errors = False
            for rule, count in data.get("error_rules", {}).items():
                f.write(f"    * {rule}: {count}\n")
                has_errors = True
            if not has_errors:
                f.write("    * None\n")
            
            f.write("-" * 50 + "\n\n")

    print(f"Quality reports written to reports/")
