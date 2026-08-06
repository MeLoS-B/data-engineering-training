import os
from src.pipeline import run_pipeline

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Define directory paths
    raw_dir = os.path.join(base_dir, "data", "raw")
    bronze_dir = os.path.join(base_dir, "data", "bronze")
    silver_dir = os.path.join(base_dir, "data", "silver")
    invalid_dir = os.path.join(base_dir, "data", "invalid")
    db_path = os.path.join(base_dir, "data", "gold", "trusted_data.db")
    report_dir = os.path.join(base_dir, "reports")
    
    # Run pipeline
    run_pipeline(
        raw_dir=raw_dir,
        bronze_dir=bronze_dir,
        silver_dir=silver_dir,
        invalid_dir=invalid_dir,
        db_path=db_path,
        report_dir=report_dir
    )