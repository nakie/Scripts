#!/bin/bash
######################################################

DAY=$(date +%Y-%m-%d)
FULLTIME=$(date +%H:%M)
TIME=`$FULLTIME| cut -c1-4`
echo $DAY $TIME
# Exim Date Example format - 2015-08-27 08:3
#exigrep "" /var/log/exim_mainlog | exigrep "courier_login:" | perl -00ne '($from, $auth) = ( /\<\=\s(\S+).*?A\=courier\_login\:(\S+)/);if( uc($from) ne uc($auth) ){ print $from . " " . $auth ."\n" ; }'
