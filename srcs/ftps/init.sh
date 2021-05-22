#!/bin/sh

telegraf --config /etc/telegraf.conf 1>/dev/null 2>&1 &

ls /etc/vsftpd/flag &>/dev/null
if [ $? -eq 1 ]
then
	touch /etc/vsftpd/flag
	passwd ftpuser -d $FTPS_FTPUSER_PASSWORD
fi
vsftpd
