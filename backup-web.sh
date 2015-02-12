#!/bin/bash
######################################################
# Nathan Crews
# backup-web.sh
#
# Automate process for moving backups from remote 
# server to local network for retention. 
# 
# Uses rsync to synchronize remote folder /backup/< daily backup name >
# to Local network server in folder /server5-backup/
#
# The cron job that fires this is:
# 0 5 * * 1-6 /usr/local/bin/ics/test/backup.sh 
# which starts the script at 5 am Sunday through Friday 
# skipping a rename on the Saturday backup.
#
#
#######################################################


########################################################
##         CONFIGURATION / VARIABLES                  ##
########################################################

    # Cpanel Backup Log File Location ( Remote Server ).
log_dir="/usr/local/cpanel/logs/cpbackup"

    # Cpbackup Backup destination location 
remote_dir="/backup/"$(date  +%Y-%m-%d)

    # Local Backup storage location  
local_dir="/server5-backup/"

    # Remote server username
rmt_user="__USER__"

    # Domain/IP to remote server.
rmt_server="__SERVER__"

    # Flag to monitor backup state.
FINNISHED=false

for (( c=1; c<=12; c++ ))
do
        # Retrieve most recent file in backup log directory 
    file=$(ssh "$rmt_user"@"$rmt_server" ls "$log_dir" | sort -n | tail -1)
     
        # Check most recent log file to ensure it is from a
        # backup today. -mmin -720 will confirm the file was
        # Created in the past 12 hours.
    if test `ssh "$rmt_user"@"$rmt_server" find "$log_dir"/"$file" -mmin -720` 
    then  # Today's Log: continue

            # Grab last 2 lines of Today's backup log file
        output=$(ssh "$rmt_user"@"$rmt_server" tail -2 "$log_dir"/"$file")

            # Check if Backup has completed.
            # we'll find the "Completed" text if it has
        if [[ $output =~ .*Completed.* ]]
        then

            # now that we know the backup is for today and has complted
            # we will sync it to ICS's system.
            # rsync -av -delete -e ssh $rmt_user@$rmt_server:$remote_dir $local_dir

            echo "Backup Completed"

                # once backup is synchronized exit loop
            FINNISHED=true

        else 
            # There is a log for today
            # but it does not appear to have finished yet.
            FINNISHED=false
        fi     

    else  
        # A Log for Today was not found.
        FINNISHED=falses        
    fi
    
    
    if $FINNISHED; 
    then
    
        break
    else
    
        sleep 30
        
    fi
    
done


if $FINNISHED; 
then

    echo "Backup synchronization completed"
else

    echo "Backup synchronization failed after 6 hours of trying"
    
fi
# echo "Backup Copy Script Completed:"
# echo $errmsg

