#!/bin/bash

read -p "Enter an animal: " a

case $a in
	cat)
		echo "Meow";;
	dog|puppy)
		echo "Woof";;
	dog|bull)
		echo "Yum";;
	*)
		echo "No match!";;
esac
