students = [
    {
        "student_id":1,
        "name":"Arta",
        "city":"Vushtrri",
        "course":"Python",
        "age":17,
        "attendance":90,
        "homework_score":85
    },
    {
        "student_id":2,
        "name":"Blend",
        "city":"Prishtina",
        "course":"React",
        "age":18,
        "attendance":60,
        "homework_score":70
    },
    {
        "student_id":3,
        "name":"Dion",
        "city":"Vushtrri",
        "course":"Python",
        "age":16,
        "attendance":75,
        "homework_score":95
    },
    {
        "student_id":4,
        "name":"Elira",
        "city":"Mitrovica",
        "course":"React",
        "age":17,
        "attendance":80,
        "homework_score":60
    },
    {
        "student_id":5,
        "name":"Faton",
        "city":"Vushtrri",
        "course":"Data engineering",
        "age":19,
        "attendance":100,
        "homework_score":90
    },
    {
        "student_id":6,
        "name":"Gresa",
        "city":"Prishtina",
        "course":"Python",
        "age":18,
        "attendance":55,
        "homework_score":88
    },
    {
        "student_id":7,
        "name":"Melos",
        "city":"Vushtrri",
        "course":"Data engineering",
        "age":16,
        "attendance":74,
        "homework_score":95
    },
]



if not students:
    print("No students available.")
else:

    def total_students(students):
        print("Student Report")
        print(f"Total Students {len(students)}")
        print()


    def average_attendance(students):
        sum_attendance = 0

        for student in students:
            sum_attendance += student["attendance"]

        average = sum_attendance / len(students)

        print(f"Average attendance: {average}")
        print()


    def average_homework(students):
        homework_score = 0

        for student in students:
            homework_score += student["homework_score"]

        average = homework_score / len(students)

        print(f"Average Homework Score {average}")
        print()


    def count_by_city(students):
        student_count_city = {}

        print("Count Students by city:")

        for student in students:
            if student["city"] in student_count_city:
                student_count_city[student["city"]] += 1
            else:
                student_count_city[student["city"]] = 1

        for city, count in student_count_city.items():
            print(f"{city}:{count}")

        print()


    def count_by_course(students):
        count_student_in_course = {}

        print("Count Students by course:")

        for student in students:
            if student["course"] in count_student_in_course:
                count_student_in_course[student["course"]] += 1
            else:
                count_student_in_course[student["course"]] = 1

        for course, count in count_student_in_course.items():
            print(f"{course}:{count}")

        print()


    def low_attendance_students(students):
        print("Students with low attendance:")
        for student in students:
            if student["attendance"] < 70:
                print(student["name"])
        print()


    def strong_students(students):
        print("Strong students:")
        for student in students:
            if student["attendance"] >= 80 and student["homework_score"] >= 80:
                print(f"{student['name']}:Strong")
        print()


    def students_need_support(students):
        print("Students that need support:")

        for student in students:
            if student["attendance"] >= 80 and student["homework_score"] >= 80:
                pass
            elif student["attendance"] >= 60 and student["homework_score"] >= 60:
                pass
            else:
                print(f"{student['name']} needs support")

        print()



    def top_3_students(students):
        print("Top 3 students (attendance + homework_score):")

        students_copy = students.copy()
        ranked = []

        while students_copy:
            best = students_copy[0]

            for student in students_copy:
                if (student["attendance"] + student["homework_score"]) > (best["attendance"] + best["homework_score"]):
                    best = student

            ranked.append(best)
            students_copy.remove(best)

        for student in ranked[:3]:
            total = student["attendance"] + student["homework_score"]
            print(f"{student['name']} -> {total}")

        print()


    total_students(students)
    average_attendance(students)
    average_homework(students)
    count_by_city(students)
    count_by_course(students)
    low_attendance_students(students)
    strong_students(students)
    students_need_support(students)
    top_3_students(students)


    print()

    sorted_students = []

    students_copy = students.copy()

    while students_copy:
        highest = students_copy[0]

        for student in students_copy:
            if student["homework_score"] > highest["homework_score"]:
                highest = student

        sorted_students.append(highest)
        students_copy.remove(highest)

    for student in sorted_students:
        print(student["name"], student["homework_score"])