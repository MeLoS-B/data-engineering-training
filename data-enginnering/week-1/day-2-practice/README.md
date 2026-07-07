# Day 2 Practice - CSV Mini Data Pipeline

This project reads raw student data from a CSV file, checks data quality issues, cleans the data, saves a cleaned CSV file, and generates a summary report.

## Input

* `data/students_raw.csv`

The input file contains raw student records with missing values, invalid values, and inconsistent text formatting. The raw data is kept unchanged, and all cleaning is done using Python.

## Output Files

The program generates the following files inside the `output` folder:

* `students_clean.csv`

  * Contains all cleaned student records.
  * Includes cleaned values, total score, performance status, and risk flag.

* `data_quality_report.txt`

  * Contains a report of all detected data quality issues.
  * Includes missing values, invalid numeric values, and inconsistent text values.

* `summary_report.txt`

  * Contains a final summary of the dataset.
  * Includes averages, students by city, students by course, performance groups, risk students, and top students.

## How to Run

Open the terminal inside the `day-2-practice` folder and run:

```bash
python csv_pipeline.py
```

The program will read the CSV file, process the data, print reports in the terminal, and save the generated files inside the `output` folder.

## Main Concepts Practiced

During this project, the following data engineering concepts were practiced:

* Reading and processing CSV files with Python
* Working with dictionaries and lists
* Data quality checking
* Detecting missing and invalid data
* Data cleaning and transformation
* Creating reusable functions
* Building a simple data pipeline
* Generating reports from processed data
* Writing cleaned data back to CSV files
* Organizing a project structure professionally for GitHub
