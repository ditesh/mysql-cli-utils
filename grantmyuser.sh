#!/bin/sh
# First param: mysql username
# Second param: mysql password (optional)

CUSTOM_GRANT=0
MYSQL_PATH=`which mysql`

if [ "${MYSQL_PATH}" = "" ]; then
        echo "Couldn't find mysql binary"
        echo
        exit 1
fi

if [ $# -lt 4 ]; then
	echo "Usage:"
	echo "	./grantmyuser.sh -u mysqlusername (-p mysqlpassword) usertogrant@host database.tables grants"
	echo
	echo "Valid grants:"
	echo "  all: All grants will be given"
	echo "  none: All grants will be removed"
	echo "  read: Read only access to the grants"
	echo "  standard: SELECT, INSERT, UPDATE, DELETE"
	echo "  extended: SELECT, INSERT, UPDATE, DELETE, DROP, SHOW CREATE VIEW, TRIGGER, INDEX, CREATE VIEW, ALTER"
	echo "  custom: comma delimited list of grants"
	echo "  	  example: ./grantmyuser.sh -u mysqlu -p mysqlp user@localhost \"*.*\" custom \"SELECT, INSERT\""
	echo
	exit 2
fi

if [ "${3}" = "-p" ]; then
	DB=${5}
	GRANT=${7}
	USER_TO_GRANT=${6}
	MYSQL_PASSWD="-p'${4}'"

	if [ "${6}" = "custom" ]; then
		CUSTOM_GRANT=1
	fi

else
	DB=${4}
	GRANT=${5}
	USER_TO_GRANT=${3}

	if [ "${5}" = "custom" ]; then
		CUSTOM_GRANT=1
	fi
fi

if [ ${CUSTOM_GRANT} -eq 0 ]; then

	if [ "${GRANT}" = "all" ]; then
		CUSTOM_GRANT="ALL"
		SQL="GRANT ${CUSTOM_GRANT} ON ${DB} TO ${USER_TO_GRANT}"
	elif [ "${GRANT}" = "none" ]; then
		SQL="REVOKE ALL PRIVILEGES ON ${DB} FROM ${USER_TO_GRANT}"
	elif [ "${GRANT}" = "standard" ]; then
		CUSTOM_GRANT="SELECT, INSERT, UPDATE, DELETE"
		SQL="GRANT ${CUSTOM_GRANT} ON ${DB} TO ${USER_TO_GRANT}"
	elif [ "${GRANT}" = "extended" ]; then
		CUSTOM_GRANT="SELECT, INSERT, UPDATE, DELETE, DROP, SHOW CREATE VIEW, TRIGGER, INDEX, CREATE VIEW, ALTER"
		SQL="GRANT ${CUSTOM_GRANT} ON ${DB} TO ${USER_TO_GRANT}"
	else
		echo "Usage:"
		echo "	./grantmyuser.sh -u mysqlusername (-p mysqlpassword) usertogrant@host database.tables grants"
		echo
		echo "Valid grants:"
		echo "  all: All grants will be given"
		echo "  none: All grants will be removed"
		echo "  read: Read only access to the grants"
		echo "  standard: SELECT, INSERT, UPDATE, DELETE"
		echo "  extended: SELECT, INSERT, UPDATE, DELETE, DROP, SHOW CREATE VIEW, TRIGGER, INDEX, CREATE VIEW, ALTER"
		echo "  custom: comma delimited list of grants"
		echo "  	  example: ./grantmyuser.sh -u mysqlu -p mysqlp user@localhost \"*.*\" custom \"SELECT, INSERT\""
		echo
		exit 2

	fi
fi

echo "$SQL"
echo "${SQL}" | ${MYSQL_PATH} ${1} ${2} "${MYSQL_PASSWD}"
