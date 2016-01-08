#!/bin/bash
# This program is used to backup database Oracle, dump file is copied to ftp server at 10.10.1.14
# Author: Thang Duong

day=$(date +%F)
HOST='10.10.1.14'
USER=(administrator demoebanking backend_dev epurse)
PASS=(123456a@ demoebanking backend_dev epurse)
DIR=('/home/oracle/backup' '/u01/app/oracle')


# export file
exp ${USER[1]}/${PASS[1]} file=${DIR[0]}/${USER[1]}_${day}.dmp full=y && FILE=${USER[1]}_${day}.dmp

# upload to ftp server
ftp -n -v $HOST << EOT
ascii
user ${USER[0]} ${PASS[0]}
prompt
cd Backup
cd Oracle_DB
cd ${USER[1]}
put $FILE
bye
EOT
