# enter your marks here
marks = int(input("Enter your marks: "))

# if marks are greater than or equal to 90
if marks >= 90:
    print("Grade: A")

# if marks are between 80 and 89
elif marks >= 80:
    print("Grade: B")

# if marks are between 70 and 79
elif marks >= 70:
    print("Grade: C")

# if marks are between 60 and 69
elif marks >= 60:
    print("Grade: D")

# if marks are below 60
else:
    print("Grade: F")