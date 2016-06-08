#!/bin/bash

cmd=$(nc -z 10.10.1.38 1521 > /dev/null; echo $?)

if [[ $cmd -eq 0 ]]
then
        echo "Connected"
        echo $cmd
else
        echo "Error"
        echo $cmd
fi