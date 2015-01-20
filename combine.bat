@echo off
REM - combine.bat
REM - Combine all files that meet the MATCH Filter un the
REM - FOLDER Directory into a single OUTFILE
REM - 9/26/2013 - Nathan Crews, ICS

REM - Directory of the Files to are combine
SET FOLDER="C:\Scripts\"

REM - Name of output file
SET OUTFILE="outfile.txt"

REM - Pattern to match when looking for 
REM - which files to combine in a directory
SET MATCH="delete*"

REM - If the outfile exists remove it prior to running 
if exist "%FOLDER%%OUTFILE%" (
    del "%FOLDER%%OUTFILE%"
)

REM - Loop and create outfile
for %%a in ( "%FOLDER%%MATCH%" ) do (

	REM - Move contents of file into OUTFILE
	more "%%a" >> "%FOLDER%%OUTFILE%"
	REM - copy /b used in place of more to prevent extra
	REM - SUB character from being appended to the end of the file
	REM - TODO:: this needs to be udpated to reflect the current script.
	
	REM - Delete the file once it is copied 
	REM - /P Prompts for confirmation before deleting.
	del /P "%%a"
	
)

REM - Echo blank line
echo.

REM - Echo completed message and await user
REM - confirmation before closing the window
echo New output file created.
pause