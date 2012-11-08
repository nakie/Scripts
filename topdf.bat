@echo off
REM - Nathan Crews :: 11/08/2012
REM - Batch file to run pandoc conversion on currently active text file
REM - This version will convert a textfile structured in MarkDown to a PDF document
REM - Notepad++ Environment Variables found at
REM - http://sourceforge.net/apps/mediawiki/notepad-plus/index.php?title=External_Programs

REM - RUN BY calling C:\notepadtest.bat  "$(CURRENT_DIRECTORY)" "$(NAME_PART)" "$(EXT_PART)"
REM - From Notepadd++ run command.

cd %1

REM - confirm file exists
if not exist %2%3 (

    echo The file %2%3 does not exist!
	echo Please save the document and try again.

	pause
	exit
)

ECHO Creating PDF File...

REM - Convert Markdown to PDF document
pandoc "%2%3" -o "%2.pdf"

pause