#open a file in write mode
file = open("example.txt", "w")

# Write some lines to the file
file.write("Hello, World!\n")
file.write("This is a test file.\n")

# Write multiple lines at once
file.writelines(["Line 1\n", "Line 2\n", "Line 3\n"])

# Close the file
file.close()