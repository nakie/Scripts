#!/bin/bash
######################################################
# Nathan Crews
# backup.sh
#
# Automate process for creating backup copies 
# 
# Removes Oldest Backup - daily the oldest non Friday 
# backup is  removed.  On Friday backups the oldest 
# Friday backup is removed.
# Backup creation/removal is 1 for 1 so if the total 
# number of backups retained needs to change it will 
# need to be done manually.
#
# The cron job that fires this is:
# 0 5 * * 1-6 /usr/local/bin/ics/test/backup.sh 
# this starts the script at 5 am Sunday through Friday 
# skipping a rename on the saturday backup.
#
#
#######################################################


   #check backup files
   #ls /usr/local/cpanel/logs/cpbackup
   #read filelist
   #echo $filelist

########################################################
########################################################
#############   CONFIGURATION OPTIONS  #################
########################################################

  # Friday Backup Count.
  # This value controls how many individual Friday
  # Backup files are retained.
CFRIDAY=3

  # Backup Count.
  # This value controls how many individual NON Friday
  # Backup files are retained.
CDAILY=6

  # Cpanel Backup Log File Location.
log_dir="/usr/local/cpanel/logs/cpbackup"

  # Cpbackup Backup destination location 
bak_dir="/cpbackup/cpbackup"

  # Today's backup folder name
folder="eod"$(date --date="1 day ago" +%y%m%d%a)

  # Day part of backup folder name
  # Used to search for backup to remove
day=$(date --date="1 day ago" +%a)

  # Retrieve most recent file in log directory 
file=$(ls "$log_dir" | sort -n | tail -1)
 
  # Test most recent log file to confirm it's Today's Log 
if test `find "$log_dir"/"$file" -mmin -1200` 
then  # Today's Log: continue
    
  output=$(tail -2 "$log_dir"/"$file")
  
    # Check if Backup has completed.
  if [[ $output =~ .*Completed.* ]]
  then

       # Does a Backup Dir for today already exist?
     if [ -d $bak_dir/$folder ]
     then
          # Backup folder exists: ERROR
        errmsg="A folder for today's backup already exists"
     else
        echo "RUNNING BACKUP COPY SCRIPT!"

          # RUN BACKUP!!!!!!
   	  # Local Backup
	  # New Server uses rsync old server still needs a mv command
	  # rsync -avz $bak_dir/daily/. $bak_dir/$folder | tail -3

	mv $bak_dir/daily $bak_dir/$folder
        
          #Remove backup 
        if [ $day == "Fri" ]
        then
            # Get name of oldest Friday backup to be Removed.
            remove=$(ls "$bak_dir" | grep "eod" | grep -m 1 "$day") 

            if test $(ls "$bak_dir" | grep "Fri" | wc -l) -gt $CFRIDAY
            then
                echo "Friday Backup"
                rm -rf $bak_dir/$remove
                #removed="YES"	
                echo "Removing"
                echo $remove
            fi
        else
		  # Get name of oldest NON Friday backup to be removed.
		remove=$(ls "$bak_dir" | grep "eod" | grep -v "Fri")

		if test $(ls "$bak_dir" | grep "eod" | wc -l) -gt $CDAILY
		then
                        echo "Daily Backup"
			rm -rf $bak_dir/$remove
			removed="YES"
                fi
        fi

	if [ $removed == "YES" ]
	then
		echo "Removing old backup named:"
		echo $remove

		#rm -rf $bak_dir/$remove
	fi

     fi

   else
       # Backup has not Finished: ERROR
     errmsg="Backup did not complete, come back later."

   fi
      

else  # This log is not for today: ERROR

  errmsg="No Backup log generated in the last 12 Hours."

fi

echo "Backup Copy Script Completed:"
echo $errmsg
