STATUS=0
if [ -f /etc/current_status ]
then
	STATUS=$(diff /etc/crontab /etc/current_status | wc -m)
else
	cat /etc/crontab > /etc/current_status
fi

if [ $STATUS -eq 0 ]
then
	echo "no change in cron"
else
	echo "Subject: Crontab Notification \n\nBe careful the cron daemon have been modified.\nIf is not made by a regular user it could be an attack." | sudo sendmail -v root@localhost
fi

cat /etc/crontab > /etc/current_status
