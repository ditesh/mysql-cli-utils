#!/bin/sh
# First param: mysql username
# Second param: mysql password (optional)

MYSQL_PATH=`which mysql`

if [ "${MYSQL_PATH}" = "" ]; then
        echo "Couldn't find mysql binary"
        echo
        exit 1
fi

if [ $# -gt 5  ] && [ $# -lt 3 ]; then
	echo "Usage:"
	echo "	./showmygrants.sh -u mysqlusername (-p mysqlpassword) user@host"
	echo
	exit 2
fi

if [ "${3}" = "-p" ]; then
	MYSQL_PASSWD="-p'${4}'"
	USER=${5}
else
	USER=${3}
fi

if [ "z${USER}" = "z" ]; then
	USER=""
else
	USER="FOR ${USER}"
fi

SQL="SHOW GRANTS ${USER}"

echo ${SQL} | ${MYSQL_PATH} ${1} ${2} "${MYSQL_PASSWD}" -N
echo
