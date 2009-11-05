#!/bin/sh
# First param: mysql username
# Second param: mysql password (optional)

MYSQL_PATH=`which mysql`

if [ "${MYSQL_PATH}" = "" ]; then
        echo "Couldn't find mysql binary"
        echo
        exit 1
fi

SQL="SELECT concat(user,'@',host) FROM mysql.user"

echo ${SQL} | ${MYSQL_PATH} ${1} ${2} ${MYSQL_PASSWD} -N
echo
