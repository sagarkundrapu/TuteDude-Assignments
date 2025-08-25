# opens a file in read mode and prints its contents
file = open("example.txt", "r")

# Read the entire file
print(file.read())

# Reset file pointer to the beginning
file.seek(0)  

# Read the first 10 characters
print(file.read(10))

# Reset file pointer to the beginning
file.seek(0)  

# Read the first line
print(file.readline())

# Reset file pointer to the beginning
file.seek(0)  

# Read all lines into a list
print(file.readlines())

# Close the file
file.close()