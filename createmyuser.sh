#!/bin/sh
# First param: mysql username
# Second param: mysql password (optional)
# Third param: mysql user to create
# Fourth param: mysql password for created user (optional)

MYSQL_PATH=`which mysql`

if [ "${MYSQL_PATH}" = "" ]; then
	echo "Couldn't find mysql binary"
	echo
	exit 1
fi

if [ $# -gt 6 ] || [ $# -lt 3 ]; then
	echo "Usage:"
	echo "	./createmyuser.sh -u mysqlusername (-p mysqlpassword) usertocreate@host (passwordforuser)"
	echo
	exit 2
fi

if [ "${3}" = "-p" ]; then

	MYSQL_PASSWD="-p'${4}'"
	USER_TO_CREATE=${5}

	if [ $# -eq 6 ]; then
		IDENTIFIED_BY="IDENTIFIED BY '${6}'"
	fi

else

	USER_TO_CREATE=${3}

	if [ $# -eq 4 ]; then
		IDENTIFIED_BY="IDENTIFIED BY '${4}'"
	fi

fi

echo "CREATE USER ${USER_TO_CREATE} ${IDENTIFIED_BY}" | ${MYSQL_PATH} ${1} ${2} "${MYSQL_PASSWD}"
