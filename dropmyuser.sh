#!/bin/sh
# First param: mysql username
# Second param: mysql password (optional)
# Third param: mysql user to drop

MYSQL_PATH=`which mysql`

if [ "${MYSQL_PATH}" = "" ]; then
        echo "Couldn't find mysql binary"
        echo
        exit 1
fi

if [ $# -gt 6 ] || [ $# -lt 3 ]; then
        echo "Usage:"
        echo "  ./dropmyuser.sh -u mysqlusername (-p mysqlpassword) usertodrop@host"
        echo
        exit 2
fi

if [ "${3}" = "-p" ]; then

        MYSQL_PASSWD="-p ${4}"
       	USER_TO_DROP=${5}

else

       	USER_TO_DROP=${3}
fi

echo "DROP USER ${USER_TO_DROP}" | ${MYSQL_PATH} ${1} ${2} ${MYSQL_PASSWD}

