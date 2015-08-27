#!/bin/bash
######################################################

DAY=$(date +%Y-%m-%d)
TIME=$(date +%H:%M | cut -c1-4 )

MAILTIME="$DAY $TIME"

echo $MAILTIME
# Exim Date Example format - 2015-08-27 08:3
exigrep "$MAILTIME" /var/log/exim_mainlog | exigrep "courier_login:" | perl -00ne '($from, $auth) = ( /\<\=\s(\S+).*?A\=courier\_login\:(\S+)/);if( uc($from) ne uc($auth) ){ print $from . " " . $auth ."\n" ; }'
