#!/bin/bash

i=0
j=0

while [[ $i -le 10 ]]; do
	echo i: $i
	((i++))
done


until [[ $j -gt 10 ]]; do
	echo j: $j
	((j++))
done
