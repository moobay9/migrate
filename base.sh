#!/bin/sh
### CentOS Install shell script
### Author      : M.Oobayashi
### Create      : 2015/08/18 Funaffect Inc.
### Last Update : 2012/04/11 M.Oobayashi

#-----------------------------------------------------------
# Parameter
#-----------------------------------------------------------
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
LANG=C
TMPFILE=/tmp/installshell.tmp

HOMEDIR=/home/backup/`date +%Y%m%d`

PG=`ping -c 1 www.yahoo.co.jp -w 2 2> /dev/null | tail -n 2 | head -n 1 | cut -f6 -d' ' | sed -e 's/%//'`


#-----------------------------------------------------------
# Install shell
#-----------------------------------------------------------

#-- Check --------------------------------------------------
if [ -e $TMPFILE ] ;then
	echo "Abort... Install shell already running."
	exit 1
fi

if [ "${PG}" != "0" ] ;then
	echo "Abort... Not Connect Internet."
	exit 1
fi




#-- Make Home Directory ------------------------------------
if [ ! -d $HOMEDIR ] ;then
	mkdir -p $HOMEDIR
fi

#-- YUM baseurl change -------------------------------------
# cp -p $YUMBASE $HOMEDIR

# sed -i "s/mirrorlist=/#mirrorlist=/g" $YUMBASE
# sed -i "s/os\/\$basearch\//os\/\$basearch\/\nbaseurl=http:\/\/ftp.riken.jp\/Linux\/centos\/\$releasever\/os\/\$basearch\//g" ${YUMBASE}
# sed -i "s/updates\/\$basearch\//updates\/\$basearch\/\nbaseurl=http:\/\/ftp.riken.jp\/Linux\/centos\/\$releasever\/updates\/\$basearch\//g" $YUMBASE
# sed -i "s/addons\/\$basearch\//addons\/\$basearch\/\nbaseurl=http:\/\/ftp.riken.jp\/Linux\/centos\/\$releasever\/addons\/\$basearch\//g" $YUMBASE
# sed -i "s/extras\/\$basearch\//extras\/\$basearch\/\nbaseurl=http:\/\/ftp.riken.jp\/Linux\/centos\/\$releasever\/extras\/\$basearch\//g" $YUMBASE
# sed -i "s/centosplus\/\$basearch\//centosplus\/\$basearch\/\nbaseurl=http:\/\/ftp.riken.jp\/Linux\/centos\/\$releasever\/centosplus\/\$basearch\//g" $YUMBASE

#-- Package Upgrade ----------------------------
yum -y update




#-- Sudo --------------------------------------------------- 
echo "SU_WHEEL_ONLY  yes" >> /etc/login.defs

sed -i "s/\#auth.*required.*pam_wheel.so/auth\t\trequired\tpam_wheel.so/g" /etc/pam.d/su
sed -i "s/\# %wheel\tALL=(ALL)\tALL/%wheel\tALL=(ALL)\tALL/g" /etc/sudoers



#-- Logwatch -----------------------------------------------
mv /etc/cron.daily/*logwatch $HOMEDIR


echo "Finish Install shell script."

touch $TMPFILE

exit 0
