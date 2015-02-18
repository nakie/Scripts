#!/bin/bash
######################################################
# ICS
# Nathan Crews
# backup-web.sh
#
# Automate process for moving backups from remote 
# server to local network for retention. 
# 
# Uses rsync to synchronize the remote folder /backup/< daily backup name >
# to Local network server in folder /server5-backup/
#
# Get latest version from github
# wget https://github.com/nakie/Scripts/raw/master/backup-web.sh
# chmod +x backup-web.sh
#
# The cron job that fires this is:
# 0 4 * * 1-6 /usr/local/ics/backup-web.sh 
# which starts the script at 4 am Sunday through Friday 
# skipping a download on the Saturday backup.
#
#
#######################################################


########################################################
##         CONFIGURATION / VARIABLES                  ##
########################################################

    # Number of runs to try the backup
ATTEMPTS=12

    # Delay between attempts in minutes.
MINUTES=30

    # Location of backup completion check file( Remote Server ).
log_dir="/usr/local/cpanel/logs/cpbackup"

    # Name of backup check file
    # the presence and access/modify time
    # of this file indicate the last run of cpbackup
file="lastrun"

    # Cpbackup Backup destination location 
remote_dir="/backup/"$(date  +%Y-%m-%d)

    # Local Backup storage location  
local_dir="/server5-backup/"

    # Remote server username
rmt_user="__USER__"

    # Domain/IP to remote server.
rmt_server="__SERVER__"


for (( c=1; c<=$ATTEMPTS; c++ ))
do
    
    # Confirm the Backup for today has completed.
    if test `ssh "$rmt_user"@"$rmt_server" find "$log_dir"/"$file" -mmin -720`
    then
        # now that we know the backup is for today and has completed
        # we will sync it to ICS's system.
        # rsync -av -delete -e ssh $rmt_user@$rmt_server:$remote_dir $local_dir

        echo "Backup Synchronization Started"

        echo $remote_dir
        
        echo "Backup Synchronization Completed"
            # once backup is synchronized exit loop
        break
        
    else # Backup has not finished.. now what?
    
  
        if [ $c!=12 ]
        then
        
            #sleep $MINUTESm
            
                # Use seconds rather than minutes while testing
            sleep $MINUTES
            
        else
            
            # on last loop send backup failure notification.
            echo "Backup synchronization failed after " $ATTEMPTS " attempts"
            
        fi
        
    fi
    
done

# echo "Backup Copy Script Completed:"
# echo $errmsg

