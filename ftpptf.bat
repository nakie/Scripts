:: Created 10/05/10
:: Nathan Crews
:: This file when called builds a ftpcmd.dat file
:: with FTP commands
:: Launches a FTP Session and executes the commands
:: inside ftpcmd.dat Once Done ftpcmd.dat is removed

@echo off
echo user %2 > ftpcmd.dat
echo %3 >> ftpcmd.dat

:: Begin Commands -->
:: Replace the next 2 lines with echo  `Command` >> Ftpcmd.dat
:: For for each line of commands that need to be in the 
:: FTP CMD File that gets run.

echo bin>> ftpcmd.dat
echo ls >> ftpcmd.dat

:: End Commands
echo quit >> ftpcmd.dat
ftp -n -s:ftpcmd.dat %1
del ftpcmd.dat /q