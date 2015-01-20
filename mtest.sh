#!/bin/bash

###############################################
#
# Monitor.sh
# run via cron and checks the mail queue size
# if the queue has more than the specified messages
# a warningn will be sent to the email address.
#
##################################################

# the number of messages in the queue that will trigger a warning email
trigger=800

# the email address to send the warning.
email="webmasters@chooseics.com"

count=`/usr/sbin/exim -bpc`

if test `/usr/sbin/exim -bpc` -ge $trigger
then
		echo $count
        /usr/sbin/exim -bp |
        /usr/sbin/exiqsumm -s |
        /bin/grep -v "<>" |
        /usr/bin/uuencode summary.txt |
        /bin/mail -s "Exim queue currently at " $email
else
:
fi



