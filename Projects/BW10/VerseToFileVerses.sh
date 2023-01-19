# It sends the verse from one common file of verses each to its own file, file with the name of its verse.

awk '{fname=$1" "$2;}NR>0
	{print $0 > fname;}'
 RcV
