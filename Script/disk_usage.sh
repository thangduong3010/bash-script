#!/bin/bash

if [[ -z "$1" ]]; then
        echo "1 argument needed"
        exit 1
fi

limit=40
usage=$(du -sh $1 | awk -F ' ' '{print $1}' | awk -F '.' '{print $1}' | tr -d [MGBK.])
usage_full=$(du -sh $1 | awk -F ' ' '{print $1}')


diff=$(echo "$usage - $limit" | bc)

if [[ "$diff" -gt 0 ]]; then
        echo "Message: Usage:" $usage_full
        echo "Statistic: 2"
        exit 2
else
        echo "Message: Usage:" $usage_full
        echo "Statistic: 0"
        exit 0
fi