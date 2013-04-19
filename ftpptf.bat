:: Created 10/05/10
:: Nathan Crews
:: This file when called builds a ftpcmd.dat file
:: with FTP commands
:: Launches a FTP Session and executes the commands
:: inside ftpcmd.dat Once Done ftpcmd.dat is removed

:: Do not print out commands
@echo off

:: Put username / password authentication commands into  dat file.
echo user %2 > ftpcmd.dat
echo %3 >> ftpcmd.dat

:: Begin Commands -->
:: Replace the next 2 lines with echo  `Command` >> Ftpcmd.dat
:: For for each line of commands that need to be in the 
:: FTP CMD File that gets run.

echo bin>> ftpcmd.dat
echo ls >> ftpcmd.dat

:: End FTP Commands

:: Add Quit FTP Command to dat file
echo quit >> ftpcmd.dat

:: Lauch FTP from command dat file.
ftp -n -s:ftpcmd.dat %1

:: Delete FTP command dat file when through.
del ftpcmd.dat /q