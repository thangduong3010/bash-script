#!/bin/bash
# Name: cleanup.sh
# This program is used to remove dump file
# Author: Thang Duong


MONTH=$(date +%m)
USER=(backend_dev demoebanking epurse)

rm -f ${USER[1]}_*-${MONTH}-*.dmp
