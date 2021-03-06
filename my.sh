#!/bin/bash

user=$USER
dir=$(pwd)
host=$(hostname)
day=$(date)
freespace=$(df -h / | grep -E "\/$" | awk '{print $4}')
greentext="\033[32m"
bold="\033[1m"
normal="\033[0m"
logdate=$(date +"%Y_%m_%d")
logfile="$logdate"_report.log
blink="\033[5m"

echo -e $bold"Quick system report for "$greentext$blink"$HOSTNAME"$normal
printf "\tSystem type:\t%s\n" $MACHTYPE
printf "\tBash Version:\t%s\n" $BASH_VERSION
printf "\tFree Space:\t%s\n" $freespace
printf "\tFiles in dir:\t%s\n" $(ls | wc -l)
printf "\tGenerated on:\t%s\n" $(date +"%m/%d/%y")
echo -e $greentext"A summary of this info has been saved to $logfile"$normal

cat <<- EOF > $logfile
	This report was automatically generated by my script.
	It contains a brief summary of some system information.
EOF

echo "Your current logged on user: " $user >> $logfile
echo "Your current working directory: " $dir >> $logfile
echo "Your hostname: " $host >> $logfile

i=1
while read f; do
        echo "Line $i: $f"
        ((i++))
done < $logfile
