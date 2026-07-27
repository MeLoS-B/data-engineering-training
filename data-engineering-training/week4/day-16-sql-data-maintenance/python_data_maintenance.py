


students = [
    {"student_id": 1, "name": "Rijon", "city": "Vushtrri", "status": "active"},
    {"student_id": 2, "name": "Eljesa", "city": "Prishtina", "status": "active"},
    {"student_id": 3, "name": "Urim", "city": "Mitrovica", "status": "active"}
]




def update_student_city(student_id,new_city):
    
    for student in students:
        if student["student_id"] == student_id:
            student["city"] = new_city
    return students
            
def update_student_status(student_id,new_status):
    for student in students:
        if student["student_id"] == student_id:
            student["status"] = new_status
    return students


def hard_delete_student(student_id):
    new_students = []
    
    for student in students:
        if not student["student_id"] == student_id:
            new_students.append(student)
    
    return new_students
            
            
def soft_delete_student(student_id):
    
    for student in students:
        if student["student_id"] == student_id:
            student["status"] = 'deleted'
    
    return students
    

city_students = update_student_city(1,"Prizren")
status_students = update_student_status(3,"deactive")
new_students = hard_delete_student(3)
new_soft_student = soft_delete_student(2)
print(new_soft_student)
print(students)




# **• Explain how SQL UPDATE is similar to changing a dictionary value in Python.**

# SQL `UPDATE` is similar to changing a value inside a Python dictionary because both modify existing data without creating a new record. In SQL, `UPDATE` changes the values of one or more columns in a table, while in Python you change the value of a specific key in a dictionary. The original record still exists; only its data is updated.

# **• Explain how SQL DELETE is similar to removing an item from a list.**

# SQL `DELETE` is similar to removing an item from a Python list because both permanently remove data from a collection. In SQL, `DELETE` removes rows from a database table. In Python, methods like `remove()` or `pop()` delete an item from a list. After the item is removed, it is no longer part of the collection unless it is added back.

# **• Explain why soft delete is often safer than removing an item completely.**

# A soft delete is often safer because it keeps the data in the database instead of removing it permanently. The record is usually marked with a status such as `"deleted"` or `"inactive"`, allowing it to be recovered later if needed. This helps prevent accidental data loss, preserves historical information, and maintains relationships with other records that may still reference the deleted item.
