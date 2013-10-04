
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

if test `/usr/sbin/exim -bpc` -ge $trigger
then
        echo "Exim queue at `/usr/sbin/exim -bpc` " | /bin/mail -s "Exim Queue Warning" $email

else
:
fi
