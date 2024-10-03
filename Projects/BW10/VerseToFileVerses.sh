# It sends the verse from one common file of verses each to its own file, file with the name of its verse.

awk '{fname=$1" "$2;}NR>0
	{print $0 > fname;}'
 RcV


==========================

The provided `awk` command is a script that processes a file named `RcV` and creates separate files for each verse based on the first two fields of each line. Let's break down the command step by step:

1. **`awk`**: This is a powerful text processing tool in Unix/Linux that allows you to manipulate and analyze text files.

2. **`'{fname=$1" "$2;}`**: This part of the script sets a variable `fname` to the concatenation of the first and second fields of the current line. In `awk`, fields are typically separated by whitespace, so `$1` refers to the first field and `$2` refers to the second field. The space between `$1` and `$2` is included in the filename.

3. **`NR>0`**: This condition is always true since `NR` (Number of Records) is a built-in variable in `awk` that counts the number of input records (lines) processed. This part of the script doesn't actually filter any lines; it simply ensures that the following block is executed for every line.

4. **`{print $0 > fname;}`**: This block prints the entire current line (`$0`) to the file named in `fname`. The `>` operator is used to redirect the output to a file. If the file specified by `fname` does not exist, it will be created. If it does exist, the content will be overwritten.

5. **`RcV`**: This is the input file that `awk` is processing. It is expected to contain lines of text where the first two fields can be used to create filenames.

### Summary
In summary, this `awk` command reads each line from the file `RcV`, extracts the first two fields to create a filename, and then writes the entire line to that file. Each unique combination of the first two fields will result in a separate file containing the corresponding lines from the input file. If multiple lines share the same first two fields, they will all be written to the same file.
