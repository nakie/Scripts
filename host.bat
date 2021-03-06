:##############################################:
: host.bat
: Nathan Crews
: 01/08/2012
: Quick edit of windows host file while
:   testing / developing websites.
:##############################################:
: NetBeans


@echo off
: Look for Notepad ++ installation

start notepad c:\Windows\system32\drivers\etc\hosts
EXIT

: Look for Notepadd++ 32Bit and 
IF EXIST "%ProgramFiles%\Notepad++\notepad++.exe" (
    : Notepad ++ is Installed change to its directory and run
    c:
    cd "%ProgramFiles%\Notepad++"
    start notepad++ c:\Windows\system32\drivers\etc\hosts
    : Host file has been launched with notepad++ jump out of script.
    EXIT
}

: Look for Notepadd++ 64Bit and open What I typically run..
IF EXIST "%ProgramFiles%\Notepad++\notepad++.exe" (
    : Notepad ++ is Installed change to its directory and run
    c:
    cd "%ProgramFiles(x86)%\Notepad++"
    start notepad++ c:\Windows\system32\drivers\etc\hosts
    : Host file has been launched with notepad++ jump out of script.
    EXIT
}
: Look for Notepad 2 Program... 
IF EXIST "%ProgramFiles%\Notepad2\Notepad2.exe" (
	: Notepad2 Is installed change to its directory and run
	c:
	cd "%ProgramFiles%\Notepad2"
	start notepad2 "%SystemRoot%"\system32\drivers\etc\hosts
    EXIT
) ELSE (
	: Notepad2 not installed run with Notepad.
	start notepad c:\Windows\system32\drivers\etc\hosts
)