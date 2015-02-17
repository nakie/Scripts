#!/bin/bash
######################################################
# ICS
# Nathan Crews
# backup-monitor.sh
#
# this script works along with backup-web.sh to automate the
# the process of off loading copies of backups from the remote
# web/email hosting server to an ICS local network server.
#
# backup-monitor.sh is hooked on to the end of the cpanel backup
# process and updates a file when a backup has completed
# 
#
# Get latest version from github
# wget https://github.com/nakie/Scripts/raw/master/backup-monitor.sh
# chmod +x backup-monitor.sh
#
# This script will be triggered using the cpanel hook system.
# use cpanel's manage_hook to register the hook.
# /usr/local/cpanel/bin/manage_hooks add script /root/backup-monitor.sh --category System --event Backup --stage post
#
#
#######################################################

    # Update access/modified time for the backup check file after cpbackup run finishes.
touch -am /usr/local/ics/cpbackup/lastrun