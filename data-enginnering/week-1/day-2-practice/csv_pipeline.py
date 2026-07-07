def count_raw_records(file):
    count = 0

    with open(file) as f:
        f.readline()

        for line in f:
            count += 1

    return count



def inspect_csv(file):
    print("CSV Inspection")

    count_rows = count_raw_records(file)

    print(f"Total raw records {count_rows}")

    print("Columns:")
    with open(file) as f:
        print(f.readline())


    print("First 3 records:")

    with open(file) as f:
        f.readline()

        for _ in range(3):
            row = f.readline().strip().split(",")

            print(f"{row[0]} - {row[1]} - {row[2]} - {row[3]}")



def check_data_quality(file):

    issues = []
    issues_found = 0

    issues.append("Data Quality Report")

    with open(file) as f:
        f.readline()

        for line in f:

            data = line.strip().split(",")

            student_id = data[0]

            attendance = data[5]
            homework_score = data[6]
            city = data[2]
            age = data[4]
            register_date = data[7]
            course = data[3]


            columns = {
                "attendance": attendance,
                "homework_score": homework_score,
                "city": city,
                "age": age,
                "register_date": register_date,
                "course": course
            }


            for column,value in columns.items():

                if value == "":
                    print(f"student_id={student_id},column={column}")

                    issues_found += 1

                    issues.append(
                        f"student_id={student_id},column={column}"
                    )



    print("Invalid numeric values:")

    issues.append("Invalid numeric values:")


    with open(file) as f:

        f.readline()

        for line in f:

            data = line.strip().split(",")

            attendance = data[5]


            if not attendance.isdigit() and attendance != "":

                print(
                    f"student_id={data[0]},column=attendance"
                )

                issues_found += 1

                issues.append(
                    f"student_id={data[0]},column=attendance"
                )



    print("Inconsistent text values:")

    issues.append("Inconsistent text values:")


    with open(file) as f:

        f.readline()

        for line in f:

            data = line.strip().split(",")


            if data[2] != data[2].title():

                print(
                    f"student_id={data[0]}, column=city, value={data[2]}"
                )

                issues_found += 1

                issues.append(
                    f"student_id={data[0]}, column=city, value={data[2]}"
                )


            if data[3] != data[3].title():

                print(
                    f"student_id={data[0]}, column=course, value={data[3]}"
                )

                issues_found += 1

                issues.append(
                    f"student_id={data[0]}, column=course, value={data[3]}"
                )



    print(f"Total issues found: {issues_found}")

    issues.append(f"Total issues found: {issues_found}")


    with open("output/data_quality_report.txt","w") as f:

        for issue in issues:

            f.write(issue + "\n")


    return issues_found




def clean_students(file):

    cleaned_data = []


    with open(file) as f:

        f.readline()

        for line in f:

            data = line.strip().split(",")


            student_id = int(data[0])
            name = data[1]

            city = data[2]
            course = data[3]

            age = data[4]
            attendance = data[5]
            homework_score = data[6]
            register_date = data[7]



            if city == "":
                city = "Unknown"

            if city == "VUSHTRRI":
                city = "Vushtrri"

            if city == "prishtina":
                city = "Prishtina"



            if course == "":
                course = "Not Assigned"

            if course == "Data engineering":
                course = "Data Engineering"



            if age == "":
                age = 0


            if attendance == "" or not attendance.isdigit():

                attendance = 0


            if homework_score == "":

                homework_score = 0


            if register_date == "":

                register_date = "Unknown Date"



            age = int(age)
            attendance = int(attendance)
            homework_score = int(homework_score)



            total_score = attendance + homework_score



            if attendance <= 60 or homework_score <= 60:

                risk_flag = "At Risk"

            else:

                risk_flag = "OK"



            cleaned_data.append(
                f"{student_id},{name},{city},{course},{age},{attendance},{homework_score},{register_date},{total_score},{risk_flag}\n"
            )


    with open("output/students_clean.csv","w") as f:

        f.write(
            "student_id,name,city,course,age,attendance,homework_score,register_date,total_score,risk_flag\n"
        )

        for row in cleaned_data:

            f.write(row)



    return len(cleaned_data)



def get_average(file,column):

    total = 0
    count = 0


    with open(file) as f:

        f.readline()

        for line in f:

            data = line.strip().split(",")

            total += int(data[column])

            count += 1


    return total / count




def count_by_column(file,column):

    result = {}


    with open(file) as f:

        f.readline()


        for line in f:

            data = line.strip().split(",")

            value = data[column]


            if value in result:

                result[value] += 1

            else:

                result[value] = 1


    return result




def get_students_by_status(file):

    strong = []
    support = []
    risk = []


    with open(file) as f:

        f.readline()


        for line in f:

            data = line.strip().split(",")


            name = data[1]
            total_score = int(data[8])
            risk_flag = data[9]


            if total_score >= 160 and risk_flag == "OK":

                strong.append(name)


            if total_score < 150:

                support.append(name)


            if risk_flag == "At Risk":

                risk.append(name)


    return strong,support,risk




def get_top_students(file):

    students = []


    with open(file) as f:

        f.readline()


        for line in f:

            data = line.strip().split(",")

            students.append(
                [data[1], int(data[8])]
            )


    students.sort(reverse=True, key=get_score)


    return students[:3]



def get_score(student):

    return student[1]




def create_summary_report(raw,cleaned,issues):

    report = []


    report.append("Final Student Data Report")

    report.append(f"Total raw records:{raw}")

    report.append(f"Total cleaned records:{cleaned}")

    report.append(f"Total data quality issues found:{issues}")



    report.append(
        f"Average attendance:{get_average('output/students_clean.csv',5):.2f}"
    )


    report.append(
        f"Average homework score:{get_average('output/students_clean.csv',6):.2f}"
    )



    report.append("Students by city:")

    for city,count in count_by_column("output/students_clean.csv",2).items():

        report.append(f"{city}:{count}")



    report.append("Students by course:")

    for course,count in count_by_column("output/students_clean.csv",3).items():

        report.append(f"{course}:{count}")



    strong,support,risk = get_students_by_status(
        "output/students_clean.csv"
    )


    report.append("Strong students:")

    for student in strong:

        report.append(student)



    report.append("Students that need support:")

    for student in support:

        report.append(student)



    report.append("At Risk students:")

    for student in risk:

        report.append(student)



    report.append("Top 3 students by total_score:")


    for student in get_top_students("output/students_clean.csv"):

        report.append(
            f"{student[0]}: {student[1]}"
        )



    with open("output/summary_report.txt","w") as f:

        for row in report:

            f.write(row + "\n")






raw_records = count_raw_records("data/students_raw.csv")

inspect_csv("data/students_raw.csv")

issues = check_data_quality("data/students_raw.csv")

cleaned_records = clean_students("data/students_raw.csv")

create_summary_report(
    raw_records,
    cleaned_records,
    issues
)