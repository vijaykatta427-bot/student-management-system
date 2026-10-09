import mysql.connector


# -------------------------------
# DATABASE CONNECTION
# -------------------------------

def connect_database():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Vijay@1379",
        database="students_management"
    )


# -------------------------------
# ADD STUDENT
# -------------------------------

def add_student():

    name = input("Enter student name: ")
    email = input("Enter email: ")
    phone = input("Enter phone: ")
    course = input("Enter course: ")
    department = input("Enter department: ")
    year = int(input("Enter year: "))

    connection = connect_database()
    cursor = connection.cursor()

    query = """
    INSERT INTO students
    (name, email, phone, course, department, year)
    VALUES (%s, %s, %s, %s, %s, %s)
    """

    values = (
        name,
        email,
        phone,
        course,
        department,
        year
    )

    cursor.execute(query, values)

    connection.commit()

    print("\nStudent added successfully!")

    cursor.close()
    connection.close()


# -------------------------------
# VIEW STUDENTS
# -------------------------------

def view_students():

    connection = connect_database()
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM students")

    students = cursor.fetchall()

    print("\n--------- STUDENT LIST ---------")

    if len(students) == 0:
        print("No students found.")

    else:
        for student in students:
            print(
                "ID:", student[0],
                "| Name:", student[1],
                "| Email:", student[2],
                "| Phone:", student[3],
                "| Course:", student[4],
                "| Department:", student[5],
                "| Year:", student[6]
            )

    cursor.close()
    connection.close()


# -------------------------------
# SEARCH STUDENT
# -------------------------------

def search_student():

    student_id = int(input("Enter student ID: "))

    connection = connect_database()
    cursor = connection.cursor()

    query = "SELECT * FROM students WHERE id = %s"

    cursor.execute(query, (student_id,))

    student = cursor.fetchone()

    if student:
        print("\nStudent Found")
        print("ID:", student[0])
        print("Name:", student[1])
        print("Email:", student[2])
        print("Phone:", student[3])
        print("Course:", student[4])
        print("Department:", student[5])
        print("Year:", student[6])

    else:
        print("Student not found.")

    cursor.close()
    connection.close()


# -------------------------------
# UPDATE STUDENT
# -------------------------------

def update_student():

    student_id = int(input("Enter student ID: "))

    name = input("Enter new name: ")
    email = input("Enter new email: ")
    phone = input("Enter new phone: ")
    course = input("Enter new course: ")
    department = input("Enter new department: ")
    year = int(input("Enter new year: "))

    connection = connect_database()
    cursor = connection.cursor()

    query = """
    UPDATE students
    SET name = %s,
        email = %s,
        phone = %s,
        course = %s,
        department = %s,
        year = %s
    WHERE id = %s
    """

    values = (
        name,
        email,
        phone,
        course,
        department,
        year,
        student_id
    )

    cursor.execute(query, values)

    connection.commit()

    if cursor.rowcount > 0:
        print("Student updated successfully!")
    else:
        print("Student not found.")

    cursor.close()
    connection.close()


# -------------------------------
# DELETE STUDENT
# -------------------------------

def delete_student():

    student_id = int(input("Enter student ID: "))

    connection = connect_database()
    cursor = connection.cursor()

    query = "DELETE FROM students WHERE id = %s"

    cursor.execute(query, (student_id,))

    connection.commit()

    if cursor.rowcount > 0:
        print("Student deleted successfully!")
    else:
        print("Student not found.")

    cursor.close()
    connection.close()


# -------------------------------
# MAIN MENU
# -------------------------------

while True:

    print("\n================================")
    print("   STUDENT MANAGEMENT SYSTEM")
    print("================================")

    print("1. Add Student")
    print("2. View Students")
    print("3. Search Student")
    print("4. Update Student")
    print("5. Delete Student")
    print("6. Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        add_student()

    elif choice == "2":
        view_students()

    elif choice == "3":
        search_student()

    elif choice == "4":
        update_student()

    elif choice == "5":
        delete_student()

    elif choice == "6":
        print("Thank you!")
        break

    else:
        print("Invalid choice.")
