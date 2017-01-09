#!/bin/bash
# This program is used to backup database Oracle, dump file is copied to ftp server at 10.10.1.14

# source profile
. ~/bash_profile

day=$(date +%d_%m_%y)
HOST='10.10.1.14'
USER=(administrator system)
PASS=('123456a@' '123456')
SCHEMA=(ILENDINGPRO_DEV epurse ILENDINGPRO)
DIR=('/home/oracle' '/u01/app/oracle')

# export file
$ORACLE_HOME/bin/expdp ${USER[1]}/${PASS[1]} schemas=${SCHEMA[0]} directory=MY_DIR dumpfile=${SCHEMA[0]}_${day}.dmp logfile=${SCHEMA[0]}_${day}.log
FILE=${SCHEMA[0]}_${day}.dmp


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
