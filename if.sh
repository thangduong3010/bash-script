#!/bin/bash


read -p "Enter a number: " numb
read -p "Enter a string: " string

if [[ $numb =~ [0-9] ]]; then
	if [[ $numb -gt 10 ]]; then
		echo "$numb is greater than 10"
	elif [[ $numb -lt 10 ]]; then
		echo "$numb is less than 10"
	else
		echo "$numb is the thing"
	fi
else
	echo "This is not a number"
fi


if [[ $string =~ [0-9] ]]; then
	echo "There is a number in there"
else
	echo "Oops, ain't number in there"
fi
