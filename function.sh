#!/bin/sh

function service_command() {
    # Need env PLATFORM
    if [ "${PLATFORM}" = "centos6" -o "${PLATFORM}" = "aws" ]; then
        service $2 $3
    elif [ "${PLATFORM}" = "centos7" ]; then
        systemctl $3 $2
    else
        echo "Usage : service_command [package-name] [action]"
        echo "Example: service_command sshd restart"
    fi
}

function package_command() {
    # Need env PLATFORM
    if [ "${PLATFORM}" = "centos6" -o "${PLATFORM}" = "aws" ]; then
        chkconfig $2 $3
    elif [ "${PLATFORM}" = "centos7" ]; then

        if [ "$3" = "enable" -o "$3" = "disable" ]; then
            ACT=$3
        elif [ "$3" = "on" ]; then
            ACT="enable"
        elif [ "$3" = "off" ]; then
            ACT="disable"
        fi

        systemctl $ACT $2
    else
        echo "Usage : package_command [package-name] [action]"
        echo "Example: package_command sshd on"
    fi
}