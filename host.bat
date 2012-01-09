@echo off
: Look for Notepad 2 Program... What I typically run
IF EXIST "%ProgramFiles%\Notepad2\Notepad2.exe" (
	: Notepad2 Is installed change to its directory and run
	c:
	cd "%ProgramFiles%\Notepad2"
	start notepad2 "%SystemRoot%\system32\drivers\etc\hosts
) ELSE (
	: Notepad2 not installed run with Notepad.
	start notepad c:\Windows\system32\drivers\etc\hosts
)

