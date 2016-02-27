#!/bin/bash
export ORACLE_BASE=/home/db
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=ISTSDBTEST01
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export PATH=$ORACLE_HOME/bin:/bin:/usr/bin:/usr/sbin
# ORA_OWNER=oracle
# Name: backup_ebanking.sh
# This program is used to backup EBANKING database, dump file is copied to ftp server at 10.10.1.14
# Author: Thang Duong

day=$(date +%d_%m_%y)
HOST='10.10.1.14'
USER=(administrator demoebanking backend_dev epurse)
PASS=(123456a@ demoebanking backend_dev epurse)
DIR=('/home/oracle' '/u01/app/oracle')

# export file
/home/db/product/11.2.0/dbhome_1/bin/exp demoebanking/demoebanking file=${DIR[0]}/${USER[1]}_${day}.dmp
FILE=${USER[1]}_${day}.dmp

# upload to ftp server
ftp -n -v $HOST << EOT
ascii
user ${USER[0]} ${PASS[0]}
prompt
cd Backup
cd Oracle_DB
cd ${USER[1]}
put ${FILE}
bye
EOT
