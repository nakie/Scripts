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
TRIGGER=800

# the email address to send the warning.
EMAIL="webmasters@chooseics.com"

# get message count from queue
COUNT=`/usr/sbin/exim -bpc`

# send warning if count is greater than
# the predefined trigger
if [ $COUNT -ge $TRIGGER ]
then

        # Attach exim summary to email
        # and put count in subject.
        /usr/sbin/exim -bp |
        /usr/sbin/exiqsumm -s |
        /bin/grep -v "<>" |
        /usr/bin/uuencode summary.txt |
        /bin/mail -s "Exim queue currently at $COUNT " $EMAIL
else
:
fi
