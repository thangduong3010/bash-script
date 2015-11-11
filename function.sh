#!/bin/bash

read -p "What's your name? " name

function greeting {
	echo "Hi, $1"
}

greeting $name


function listing {
	i=1
	printf "Here's your files, $1\n"
	for f in $(ls); do
		echo $i: $f
		((i++))
	done 
}

listing $name
