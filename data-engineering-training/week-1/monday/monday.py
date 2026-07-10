  
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
]
  

# task 1
print(f"Total students:{len(students)}")
print()


print("Student names:")
for student in students:
    
    print(student["name"])
    
    
print()
print("Student details:")
for student in students:
    print(f"{student["name"]} is from {student["city"] } and is learning {student["course"]}")
    
    


print()








# task 2

print("Students from Vushtrri:")
for student in students:
    if student["city"] == "Vushtrri":
        print(student["name"])
        

print()      
        
print("Students with low attendance:")
for student in students:
    if student["attendance"] < 70:
        print(student["name"])

print()
 
print("Students with homework score above 85:")
for student in students:
    if student["homework_score"] > 85:
        print(student["name"])

        
        

# task 3

sum_attendance = 0

for student in students:
    sum_attendance += student["attendance"]

average = sum_attendance / len(students)

print(f"Average: {average}")


print()


homework_score = 0
for student in students:
    homework_score += student["homework_score"]
    
    
average = homework_score / len(students)
print(f"Average Homework Score {average}")





print()
student_count_city = {}
print("Count Students by city:")

for student in students:
    if student["city"] in student_count_city:
        student_count_city[student["city"]] += 1
    else:
        student_count_city[student["city"]] = 1

for city,count in student_count_city.items():
    print(f"{city}:{count}")



print()

count_student_in_course = {}
print("Count Students by course:")


for student in students:
    if student["course"] in count_student_in_course:
        count_student_in_course[student["course"]] += 1
    else:
        count_student_in_course[student["course"]] = 1

for course,count in count_student_in_course.items():
    print(f"{course}:{count}")






# task 4



for student in students:
    if student["attendance"] >= 80 and student["homework_score"] >= 80:
        print(f"{student["name"]}:Strong")
    elif student["attendance"] >= 60 and student["homework_score"] >= 60:
        print(f"{student["name"]}:Average")
    else:
        print(f"{student["name"]} needs support")



# task 5


for student in students:
    if student["attendance"] >= 80 and student["homework_score"] >= 80:
        print(f"{student["student_id"]} - {student['name']} - {student["course"] } - Strong")
    elif student["attendance"] >= 60 and student["homework_score"] >= 60:
        print(f"{student["student_id"]} - {student['name']} - {student["course"] } - Average")
    
    else:
        print(f"{student["student_id"]} - {student['name']} - {student["course"]} - Needs support")
        