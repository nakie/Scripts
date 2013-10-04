:: File: ptflist.bat
:: Created  4/18/2013
:: This file creates a list of PTF Save files
:: in a given directry by getting all sub directories
:: then building a file path to the save file within
:: each subdirectory.

:: Do not print out commands
@echo off

:: set
setlocal EnableDelayedExpansion

:: Uncomment if we need to count directories.
::set /a count=0

:: Clear/Create file with a blank line
echo. > ptflist.dat

:: Loop directores and build file path to SAVF File
for /d %%d in (*) do (

	:: Incrament counter
    ::set /a count+=1
	
	:: Put file path in dat file.
    echo PUT %CD%\%%d\%%d.savf QUOTE RCMD CRTSAVF FILE^(V71PREQ/%%d^)  >> ptflist.dat
)
