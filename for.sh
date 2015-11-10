#!/bin/bash

myarr=("apple" "banana" "cherry")
declare -A arr
arr["name"]="Thang"
arr["dob"]="30/10/1993"

# c-style loop
for ((i=0; i <= 10; i++)); do
	echo $i
done

# loop in array
for i in ${myarr[@]}; do
	echo $i
done

# loop in declarative array
for i in "${!arr[@]}"; do
	echo "$i: ${arr[$i]}"
done 

# loop with commands substitute
for i in $(ls); do
	echo $i
done
