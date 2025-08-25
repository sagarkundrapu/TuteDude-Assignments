# dictionary to store student and their grades
grades = {
    "Alice": 'A',
    "Bob": 'B',
    "Charlie": 'C',
    "David": 'D',
    "Eve": 'F'
}

# main loop to interact with the user
while True:
    print("\nChoose an option:")
    print("1. Add a new student and grade")
    print("2. Update an existing student's grade")
    print("3. Print all student grades")
    print("4. Exit")
    choice = input("Enter your choice (1-4): ")

    # if choice is 1, add a new student and grade
    if choice == '1':
        name = input("Enter student name: ")
        grade = input("Enter grade: ")
        if name in grades:
            print(f"{name} already exists.")
        else:
            grades[name] = grade
            print(f"Added {name} with grade {grade}.")

    # if choice is 2, update an existing student's grade
    elif choice == '2':
        name = input("Enter student name to update: ")
        if name in grades:
            grade = input("Enter new grade: ")
            grades[name] = grade
            print(f"Updated {name}'s grade to {grade}.")
        else:
            print(f"{name} not found.")

    # if choice is 3, print all student grades
    elif choice == '3':
        print("Student Grades:")
        for student, grade in grades.items():
            print(f"{student}: {grade}")

    # if choice is 4, exit the program
    elif choice == '4':
        print("Exiting program.")
        break

    # if choice is invalid, prompt again
    else:
        print("Invalid choice. Please try again.")