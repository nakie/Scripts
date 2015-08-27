#!/bin/bash
######################################################

# Create properly formatted date string
# to match Exim's date format 
DAY=$(date +%Y-%m-%d)
TIME=$(date --date="5 minutes ago" +%H:%M | cut -c1-4 )
MAILTIME="$DAY $TIME"

#echo $MAILTIME

# Exim Date Example format - 2015-08-27 08:3
exigrep "$MAILTIME" /var/log/exim_mainlog | exigrep "courier_login:" | perl -00ne '($from, $auth) = ( /\<\=\s(\S+).*?A\=courier\_login\:(\S+)/);if( uc($from) ne uc($auth) ){ print $from . " " . $auth ."\n" ; }'
