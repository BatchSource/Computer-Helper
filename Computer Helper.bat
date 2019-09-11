@echo off
mode 50,6
title Starting Computer Helper...

:: Header:
:: -----------------------
:: Storage Cleaner / Antivirus Script
::
:: Written by Alex Irick and Jeremy Jennings
:: -----------------------


cd "%USERPROFILE%\Documents"
if NOT EXIST storcleandat (mkdir storcleandat)
cd storcleandat

set filelocation='%~dpnx0'


:: CHECK FOR PERMS
    net session >nul 2>&1
    if %errorLevel% == 0 (
		REM SUCCESS
    ) else (
		color 04
		echo.
		echo Administrative permissions required.
		echo.
		echo Attempting to gain permissions...
        powershell start-process %filelocation% -verb runas
		exit
    )

mode 50,18

cls
title Computer Helper - By Alex ^& Jeremy

:: Welcome Screen (Change to ASCII ART https://www.noxidsoft.com/otherApps/taag/#p=display&f=Slant&t=)

set filelocation1="%~dpnx0"
if NOT EXIST "%USERPROFILE%\Desktop\Computer Helper.bat" (copy %filelocation1% "%USERPROFILE%\Desktop\Computer Helper.bat" 1>nul 2>nul) 

REM WELCOME SCREEN--------------
color 0a
if NOT EXIST "namedat.bat" (
echo. _       __     __                        
echo.^| ^|     / /__  / /________  ____ ___  ___ 
echo.^| ^| /^| / / _ \/ / ___/ __ \/ __ '__ \/ _ \
echo.^| ^|/ ^|/ /  __/ / /__/ /_/ / / / / / /  __/
echo.^|__/^|__/\___/_/\___/\____/_/ /_/ /_/\___/ 
                                          
    echo.
    timeout 3 >nul
    set nameofuser=%username%
    cls
    echo:set nameofuser^=%username%>>namedat.bat
    msg * /time:1 "Welcome, %username%!" 1>nul 2>nul
) else (call namedat.bat & msg * /time:1 "Welcome back, %username%!" 1>nul 2>nul)

:: -----------------------------------

if EXIST jokedat.bat (call jokedat.bat)

:: SET VARIABLES
set /a user=1
call :varroutine
goto menu

:: VARIABLE ROUTINE
:varroutine
set unselected=.
set selected=#

set /a varid=0
set /a amountofvars=16


set /a amountofvars= %amountofvars% + 1
:varforloop    
    if %varid%==%amountofvars% (set a%user%=%selected%&goto:eof) else (
        set /a varid=%varid% + 1
        set a%varid%=%unselected%
        )
goto varforloop

:: -------------------
:: Main Menu 

:menu
mode 46,18

if DEFINED disablejokes (set jokemenudis=Enable Jokes ) else (set jokemenudis=Disable Jokes)


set "a0="
if EXIST colordat.bat (call colordat.bat) else (color 0a)
cls
REM MENU ------------------------
:: We will add ASCII art here
echo.  ____       __  _             
echo. / __ \___  / /_(_)__  ___  ___
echo./ /_/ / _ \/ __/ / _ \/ _ \(_-^<
echo.\____/ .__/\__/_/\___/_//_/___/
echo . . /_/ . . . . . . . . . . . . . . . . . . .
echo.
:: Main menu
echo: Chrome Cursor    [%a1%] ^| [%a2%] Help Screen
echo: Isolate Programs [%a3%] ^| [%a4%] Tips ^& Tricks
echo: Clear Temp Files [%a5%] ^| [%a6%] View System Info
echo: Antivirus (WIP)  [%a7%] ^| [%a8%] Run on Startup
echo: Refresh Explorer [%a9%] ^| [%a10%] Change Color
echo: Repair System    [%a11%] ^| [%a12%] Not Responding
echo: Sources          [%a13%] ^| [%a14%] File Organizer
echo: %jokemenudis%    [%a15%] ^| [%a16%] About
echo . . . . . . . . . . . . . . . . . . . . . . . 
:: WASD Control
echo Use WASD to navigate options.
choice /c WASD1 /n /m "Press [1] to select."


if "%ERRORLEVEL%"=="5" (goto selected)

if "%ERRORLEVEL%"=="1" (set "equation=- 2")
if "%ERRORLEVEL%"=="2" (set "equation=- 1")
if "%ERRORLEVEL%"=="3" (set "equation=+ 2")
if "%ERRORLEVEL%"=="4" (set "equation=+ 1")

call :isitdefined
REM IF DEFINED
set /a user=%user% %equation%
call :varroutine
goto menu



:: CHECK IF THE CURRENT PLAYER POSITION IS DEFINED
:isitdefined
set /a userif=%user% %equation%
if DEFINED a%userif% (goto:eof) else (goto menu)
:: ----------------------------------------



:selected
cls
:: WHAT I HAVE DONE

if %user%==1 (goto chromefix)
if %user%==2 (goto helpscreen)
if %user%==3 (goto isolation)
if %user%==4 (goto tipstricks)
if %user%==5 (goto tempremover)
if %user%==6 (goto viewsysteminfo)
if %user%==7 (goto antivirus)
if %user%==8 (goto startup)
if %user%==9 (goto refreshos)
if %user%==10 (goto changecolor)
if %user%==11 (goto repairsys)
if %user%==12 (goto notresponding)
if %user%==13 (goto sources)
if %user%==14 (goto fileorganizer)
if %user%==15 (goto togglejokes)
if %user%==16 (goto about)

echo Coming Soon...
timeout 1 >nul
goto menu


:: FILE ORGANIZER
:fileorganizer
set /a runs=0
mode 90,15
echo.   _____ __      ____                     _            
echo.  / __(_) /__   / __ \_______ ____ ____  (_)__ ___ ____
echo. / _// / / -_) / /_/ / __/ _ '/ _ '/ _ \/ /_ // -_) __/
echo./_/ /_/_/\__/  \____/_/  \_, /\_,_/_//_/_//__/\__/_/   
echo.. . . . . . . . . . . . /___/. . . . . . . . . . . . . .
echo.

choice /c BACDEFGHIJKLMNOPQRSTUVWXYZ1234567890 /n /m "Press any letter to start, or press (B) to go back"
if %ERRORLEVEL%==1 (goto menu)


choice /c YN /m "Are you sure you want to start the File Organizer?"
if %ERRORLEVEL%==2 (goto menu)


:scanfiles
set /a runs=%runs% + 1
if %runs%==1 (set folderlocation=%USERPROFILE%\Desktop)
if %runs%==2 (set folderlocation=%USERPROFILE%\Downloads)
if %runs%==3 (call :jokegen&goto menu)

if %runs%==1 (set organizedis=Desktop)
if %runs%==2 (set organizedis=Downloads)

cls

echo Organizing the %organizedis% folder...

echo.

echo Scanning for Pictures...
move "%folderlocation%\*.jpg" "%USERPROFILE%\Pictures" 1>nul 2>nul
move "%folderlocation%\*.jpeg" "%USERPROFILE%\Pictures" 1>nul 2>nul
move "%folderlocation%\*.png" "%USERPROFILE%\Pictures" 1>nul 2>nul
move "%folderlocation%\*.gif" "%USERPROFILE%\Pictures" 1>nul 2>nul
move "%folderlocation%\*.bmp" "%USERPROFILE%\Pictures" 1>nul 2>nul
move "%folderlocation%\*.heic" "%USERPROFILE%\Pictures" 1>nul 2>nul
move "%folderlocation%\*.ico" "%USERPROFILE%\Pictures" 1>nul 2>nul
move "%folderlocation%\*.svg" "%USERPROFILE%\Pictures" 1>nul 2>nul

echo Scanning for Documents...
if NOT EXIST "%USERPROFILE%\Desktop\Documents" (mkdir "%USERPROFILE%\Desktop\Documents" 1>nul 2>nul)
move "%folderlocation%\*.pdf" "%USERPROFILE%\Desktop\Documents" 1>nul 2>nul
move "%folderlocation%\*.xls" "%USERPROFILE%\Desktop\Documents" 1>nul 2>nul
move "%folderlocation%\*.docx" "%USERPROFILE%\Desktop\Documents" 1>nul 2>nul
move "%folderlocation%\*.ppt" "%USERPROFILE%\Desktop\Documents" 1>nul 2>nul
move "%folderlocation%\*.txt" "%USERPROFILE%\Desktop\Documents" 1>nul 2>nul
move "%folderlocation%\*.cfg" "%USERPROFILE%\Desktop\Documents" 1>nul 2>nul

echo Scanning for Audio...
if EXIST "%USERPROFILE%\Music" (set musiclocation="%USERPROFILE%\Music") else (
	mkdir "%USERPROFILE%\Desktop\Music" 1>nul 2>nul
	set musiclocation="%USERPROFILE%\Desktop\Music"
	)
move "%folderlocation%\*.wav" %musiclocation% 1>nul 2>nul
move "%folderlocation%\*.mp3" %musiclocation% 1>nul 2>nul
move "%folderlocation%\*.wma" %musiclocation% 1>nul 2>nul
move "%folderlocation%\*.mid" %musiclocation% 1>nul 2>nul


echo Scanning for Videos...
if EXIST "%USERPROFILE%\Videos" (set videolocation="%USERPROFILE%\Videos") else (
	mkdir "%USERPROFILE%\Desktop\Videos" 1>nul 2>nul
	set videolocation="%USERPROFILE%\Desktop\Videos"
	)
move "%folderlocation%\*.mp4" %videolocation% 1>nul 2>nul
move "%folderlocation%\*.3pg" %videolocation% 1>nul 2>nul
move "%folderlocation%\*.avi" %videolocation% 1>nul 2>nul
move "%folderlocation%\*.mpg" %videolocation% 1>nul 2>nul
move "%folderlocation%\*.wmv" %videolocation% 1>nul 2>nul
move "%folderlocation%\*.mov" %videolocation% 1>nul 2>nul
move "%folderlocation%\*.mkv" %videolocation% 1>nul 2>nul
move "%folderlocation%\*.flv" %videolocation% 1>nul 2>nul

echo Scanning for 3D Objects...
move "%folderlocation%\*.obj" "%USERPROFILE%\3D Objects" 1>nul 2>nul
move "%folderlocation%\*.stl" "%USERPROFILE%\3D Objects" 1>nul 2>nul

echo Scanning for Adobe Project Files...
mkdir "%USERPROFILE%\Desktop\Adobe Projects" 1>nul 2>nul
move "%folderlocation%\*.psd" "%USERPROFILE%\Desktop\Adobe Projects" 1>nul 2>nul
move "%folderlocation%\*.ai" "%USERPROFILE%\Desktop\Adobe Projects" 1>nul 2>nul
move "%folderlocation%\*.fla" "%USERPROFILE%\Desktop\Adobe Projects" 1>nul 2>nul
move "%folderlocation%\*.prproj" "%USERPROFILE%\Desktop\Adobe Projects" 1>nul 2>nul

echo Scanning for Compressed Folders...
mkdir "%USERPROFILE%\Desktop\Zipped Folders" 1>nul 2>nul
move "%folderlocation%\*.7z" "%USERPROFILE%\Desktop\Zipped Folders" 1>nul 2>nul
move "%folderlocation%\*.rar" "%USERPROFILE%\Desktop\Zipped Folders" 1>nul 2>nul
move "%folderlocation%\*.zip" "%USERPROFILE%\Desktop\Zipped Folders" 1>nul 2>nul
move "%folderlocation%\*.bin" "%USERPROFILE%\Desktop\Zipped Folders" 1>nul 2>nul

echo Scanning for Executable Program Files...
mkdir "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.css" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.js" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.html" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.c" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.java" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.json" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.jar" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul

if %username%==AI199864 (
	move "%folderlocation%\*.bat" "%USERPROFILE%\Documents\Batch Files" 1>nul 2>nul
	move "%folderlocation%\*.cmd" "%USERPROFILE%\Documents\Batch Files" 1>nul 2>nul
) else (
	move "%folderlocation%\*.cmd" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
)
move "%folderlocation%\*.py" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.cs" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.otf" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.ttf" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.msi" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul
move "%folderlocation%\*.exe" "%USERPROFILE%\Desktop\Program Files" 1>nul 2>nul

echo.
timeout 1 >nul
echo Complete!
timeout 1 >nul
goto scanfiles

:: CLOSE ALL NOT RESPONDING TASKS
:notresponding

mode 70,16

echo.  _______         _             ______         __            
echo. / ___/ /__  ___ (_)__  ___ _  /_  __/__ ____ / /__ ___      
echo./ /__/ / _ \(_-^</ / _ \/ _ '/   / / / _ '(_-^</  '_/(_-^<_ _ _ 
echo.\___/_/\___/___/_/_//_/\_, /   /_/  \_,_/___/_/\_\/___(_^|_^|_)
echo.. . . . . . . . . . . /___/ . . . . . . . . . . . . . . . . . .
echo.
echo Closing tasks...
timeout 2 >nul
taskkill /fi "status eq not responding" 1>nul 2>nul

echo.
echo Complete!
timeout 1 >nul
call :jokegen
goto menu

:: SOURCES
:sources
mode 120,30
echo.   ____                          _ 
echo.  / __/__  __ _____________ ___ (_)
echo. _\ \/ _ \/ // / __/ __/ -_^|_-^<_   
echo./___/\___/\_,_/_/  \__/\__/___(_)  
echo.. . . . . . . . . . . . . . . . . .
echo.
:: ----WRITE SOURCES HERE (Use Easybib)----
echo - "Keyboard Shortcuts for Windows 10." Support.microsoft.com, support.microsoft.com/en-us/help/12445/windows-keyboard-shortcuts. Accessed 24 Aug. 2019.
echo.
echo - Kyritsis, Angelos. "Run Command: A Complete List for Windows 7, 8.1, and 10." PCsteps.com, 8 May 2017, www.pcsteps.com/1675-run-command-complete-list-windows/.
echo.
echo - "BullGuard Blog." BullGuard, www.bullguard.com/blog/2018/01/where-are-viruses-stored-on-a-computer.
echo.
echo - jpretejprete 3, et al. "How Do Antivirus Programs Detect Viruses?" Stack Overflow, 1 Feb. 1960, stackoverflow.com/questions/1396443/how-do-antivirus-programs-detect-viruses. 
echo.
echo - Bentrup, Keith BentrupKeith. "Delete Temporary Files from Batch Script in Xp." Server Fault, 1 Nov. 1959, serverfault.com/questions/19380/delete-temporary-files-from-batch-script-in-xp.
echo.
echo - "Batch Files &amp; Batch Commands." Batch Files and Batch Commands, www.robvanderwoude.com/batchcommands.php.
echo.
echo - "Learn Batch Script." Edited by Tutorials Point, Batch Script Tutorial, www.tutorialspoint.com/batch_script/index.htm. Accessed 24 Aug. 2019.

:: --------------------------

echo.
echo Press any key to return to menu.
pause >nul
call :jokegen
goto menu


:: STARTUP
:startup
cls

set filelocationcmd=%~dpnx0
set filenamecmd=%~n0%~x0
set startuplocationcmd=%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

echo.   ______           __          
echo.  / __/ /____ _____/ /___ _____ 
echo. _\ \/ __/ _ '/ __/ __/ // / _ \
echo./___/\__/\_,_/_/  \__/\_,_/ .__/
echo.. . . . . . . . . . . . ./_/. . . 
echo.
echo:Press (B) to go back.
echo.
if EXIST "%startuplocationcmd%\Antivirus.bat" (set startupmode=ON) else (set startupmode=OFF)
echo Startup Mode is currently %startupmode%.
echo Press any letter to toggle startup mode.
choice /c BACDEFGHIJKLMNOPQRSTUVWXYZ1234567890 /n
if "%ERRORLEVEL%"=="1" (
   echo Going to menu...
   timeout 1 >nul
   call :jokegen
   goto menu
)


echo.
if %startupmode%==ON (del "%startuplocationcmd%\Antivirus.bat" & echo Startup disabled.) else (goto startupenable)
timeout 1 >nul
goto startup

:startupenable
echo Enabling startup...
copy "%filelocationcmd%" "%startuplocationcmd%" >nul
rename "%startuplocationcmd%\%filenamecmd%" "Antivirus.bat" >nul
echo.
echo Success.
timeout 1 >nul
goto startup



:: SYSTEM INFO
:viewsysteminfo
mode 84,80
echo.   ____         __              ____     ___   
echo.  / __/_ _____ / /____ __ _    /  _/__  / _/__ 
echo. _\ \/ // (_-^</ __/ -_)  ' \  _/ // _ \/ _/ _ \
echo./___/\_, /___/\__/\__/_/_/_/ /___/_//_/_/ \___/                                 
echo:. . /___/ . . . . . . . . . . . . . . . . . . . . 
echo.
systeminfo
echo.
echo Press any key to return to menu.
pause >nul
call :jokegen
goto menu


:: ANTIVIRUS
:antivirus
mode 64,20
echo.   ___        __  _    _   ___            
echo.  / _ ^| ___  / /_(_)__^| ^| / (_)_____ _____
echo. / __ ^|/ _ \/ __/ /___/ ^|/ / / __/ // (_-^<
echo./_/ ^|_/_//_/\__/_/    ^|___/_/_/  \_,_/___/
echo . . . . . . . . . . . . . . . . . . . . . .
echo.
echo Attention!
echo This is in WIP!
echo.
echo Press any key to run the Antivirus anyway.                     
pause >nul
cls
echo.   ___        __  _    _   ___            
echo.  / _ ^| ___  / /_(_)__^| ^| / (_)_____ _____
echo. / __ ^|/ _ \/ __/ /___/ ^|/ / / __/ // (_-^<
echo./_/ ^|_/_//_/\__/_/    ^|___/_/_/  \_,_/___/
echo . . . . . . . . . . . . . . . . . . . . . .
echo.

:: UNDEFINE VARS
set "threat1="

set /a threatlvl=0


echo Scanning for rpcnet (Security threat)...
if EXIST "%systemroot%\SysWOW64\Rpcnet.exe" (set /a threat1=1 & set /a threatlvl=%threatlvl% + 1)


timeout 2 >nul
echo.
echo Complete.
timeout 1 >nul

if "%threatlvl%"=="1" (
   set grammar0=
) else (
   set grammar0=s
)

echo Found %threatlvl% security threat%grammar0%.
echo.
if %threat1%==1 (
	echo.What is Rpcnet?
	echo --------------------------------
	echo.Rpcnet, or computrace, is a security risk built into the BIOS.
	echo.This program was made by Lojack, an anti-theft company.
	echo.When exploited, this program can allow an attacker to gain
	echo.full remote control of the computer.
	echo.Even after a Windows 10 factory reset, this program
	echo.will persist in the BIOS of the laptop or PC.
	echo.It is impossible to remove without clearing the CMOS,
	echo.but you can always endlessly ping a taskkill command to it.
	echo.
)

echo Press any key to go back to the menu.
pause >nul
call :jokegen
goto menu


:: CHANGE COLOR
:changecolor

cls


REM BG
echo.  _____     __        
echo. / ___/__  / /__  ____
echo./ /__/ _ \/ / _ \/ __/
echo.\___/\___/_/\___/_/   
echo . . . . . . . . . . . .
echo. Choose your new background color:
echo.
echo.     0 = Black       8 = Gray
echo.     1 = Blue        9 = Light Blue
echo.     2 = Green       A = Light Green
echo.     3 = Aqua        B = Light Aqua
echo.     4 = Red         C = Light Red
echo.     5 = Purple      D = Light Purple
echo.     6 = Yellow      E = Light Yellow
echo.     7 = White       F = Bright White      
choice /c 1234567890ABCDEF /n /m "Option: "
echo.
if "%ERRORLEVEL%"=="1" (
	set "fgcol=1"  
) else if "%ERRORLEVEL%"=="2" (set bgcol=2
) else if "%ERRORLEVEL%"=="3" (set bgcol=3
) else if "%ERRORLEVEL%"=="4" (set bgcol=4
) else if "%ERRORLEVEL%"=="5" (set bgcol=5
) else if "%ERRORLEVEL%"=="6" (set bgcol=6
) else if "%ERRORLEVEL%"=="7" (set bgcol=7
) else if "%ERRORLEVEL%"=="8" (set bgcol=8
) else if "%ERRORLEVEL%"=="9" (set bgcol=9
) else if "%ERRORLEVEL%"=="10" (set bgcol=0
) else if "%ERRORLEVEL%"=="11" (set bgcol=A
) else if "%ERRORLEVEL%"=="12" (set bgcol=B
) else if "%ERRORLEVEL%"=="13" (set bgcol=C
) else if "%ERRORLEVEL%"=="14" (set bgcol=D
) else if "%ERRORLEVEL%"=="15" (set bgcol=E
) else if "%ERRORLEVEL%"=="16" (set bgcol=F)
cls

echo.  _____     __        
echo. / ___/__  / /__  ____
echo./ /__/ _ \/ / _ \/ __/
echo.\___/\___/_/\___/_/   
echo . . . . . . . . . . . .
echo. Choose your new text color:
echo.
echo.     0 = Black       8 = Gray
echo.     1 = Blue        9 = Light Blue
echo.     2 = Green       A = Light Green
echo.     3 = Aqua        B = Light Aqua
echo.     4 = Red         C = Light Red
echo.     5 = Purple      D = Light Purple
echo.     6 = Yellow      E = Light Yellow
echo.     7 = White       F = Bright White                      
choice /c 1234567890ABCDEF /n /m "Option: "
echo.
if "%ERRORLEVEL%"=="1" (
	set "fgcol=1"  
) else if "%ERRORLEVEL%"=="2" (set fgcol=2
) else if "%ERRORLEVEL%"=="3" (set fgcol=3
) else if "%ERRORLEVEL%"=="4" (set fgcol=4
) else if "%ERRORLEVEL%"=="5" (set fgcol=5
) else if "%ERRORLEVEL%"=="6" (set fgcol=6
) else if "%ERRORLEVEL%"=="7" (set fgcol=7
) else if "%ERRORLEVEL%"=="8" (set fgcol=8
) else if "%ERRORLEVEL%"=="9" (set fgcol=9
) else if "%ERRORLEVEL%"=="10" (set fgcol=0
) else if "%ERRORLEVEL%"=="11" (set fgcol=A
) else if "%ERRORLEVEL%"=="12" (set fgcol=B
) else if "%ERRORLEVEL%"=="13" (set fgcol=C
) else if "%ERRORLEVEL%"=="14" (set fgcol=D
) else if "%ERRORLEVEL%"=="15" (set fgcol=E
) else if "%ERRORLEVEL%"=="16" (set fgcol=F)

if EXIST colordat.bat (del colordat.bat)
echo color %bgcol%%fgcol%>>colordat.bat
echo Saving Changes...
timeout 1 >nul
call :jokegen
goto menu

:: REPAIR SYSTEM32
:repairsys
mode 70,18
echo.   ___                _    
echo.  / _ \___ ___  ___ _(_)___
echo. / , _/ -_) _ \/ _ '/ / __/
echo./_/^|_^|\__/ .__/\_,_/_/_/   
echo . . . . /_/ . . . . . . . . . . 
echo.
echo Are you sure you want to repair system files?
echo This may take a while.
choice /c YN                     
if "%ERRORLEVEL%"=="2" (goto menu)
cls
msg * "Do not use your computer while this is happening. If you want to quit, press Ctrl+C on the verification screen."

sfc /scannow
echo.
:: IF COMPLETE
echo Complete!
msg * "Complete."
timeout 1 >nul
call :jokegen
goto menu

:: ABOUT PAGE
:about
mode 70,18
echo.   ___   __             __ 
echo.  / _ ^| / /  ___  __ __/ /_
echo. / __ ^|/ _ \/ _ \/ // / __/
echo./_/ ^|_/_.__/\___/\_,_/\__/ 
echo . . . . . . . . . . . . . . .
echo.
echo. ----------------------------
echo. Storage Cleaner / Antivirus
echo.
echo. Written by Alex Irick ^& Jeremy Jennings
echo. (c) 2019 Alex Irick ^& Jeremy Jennings. All rights reserved.
echo. ----------------------------                            
echo. Press any key to return to menu...
pause >nul
call :jokegen
goto menu

:: REFRESH EXPLORER.EXE
:refreshos
echo.   ___      ___            __ 
echo.  / _ \___ / _/______ ___ / / 
echo. / , _/ -_) _/ __/ -_^|_-^</ _ \
echo./_/^|_^|\__/_//_/  \__/___/_//_/
echo . . . . . . . . . . . . . . . . .
echo.
choice /c YN /m "Would you like to refresh Windows?"
if "%errorlevel%"=="2" (
   goto menu
)
echo.
echo Refreshing...
taskkill /f /im explorer.exe 1>nul 2>nul
start explorer.exe
echo.
echo Complete.
timeout 1 >nul
call :jokegen
goto menu

:: TEMP REMOVER ------------------------
:tempremover
mode 90,20
echo. ______                 ___                            
echo./_  __/__ __ _  ___    / _ \___ __ _  ___ _  _____ ____
echo. / / / -_)  ' \/ _ \  / , _/ -_)  ' \/ _ \ ^|/ / -_) __/
echo./_/  \__/_/_/_/ .__/ /_/^|_^|\__/_/_/_/\___/___/\__/_/
echo. . . . . . . /_/ . . . . . . . . . . . . . . . . . . . .
echo.
echo Welcome to temp file remover!
echo This will delete unnessecary temp files such as 
echo your recycling bin and your temp folder! Press any key to start!
pause >nul

del /s /q "%tmp%\*" 1>nul 2>nul
rd /s /q %systemdrive%\$Recycle.bin

echo.
echo Complete!
timeout 2 >nul
choice /c YN /m "Would you like to open a disk cleanup tool to furthermore clean your drive?"
if "%ERRORLEVEL%"=="1" (
   start cleanmgr
)
call :jokegen
goto menu



:: TIPS AND TRICKS ----------------------
:tipstricks
cls
mode 140,15
set /a randomnumber=%RANDOM% * 208 / 32768 + 1
:skiprandomize
echo. _______                         __  ______    _     __      
echo./_  __(_)__  ___   ___ ____  ___/ / /_  __/___(_)___/ /__ ___
echo. / / / / _ \(_-^<  / _ '/ _ \/ _  /   / / / __/ / __/  '_/(_-^<
echo./_/ /_/ .__/___/  \_,_/_//_/\_,_/   /_/ /_/ /_/\__/_/\_\/___/
echo.. . ./_/. . . . . . . . . . . . . . . . . . . . . . . . . .                             
echo.
if %randomnumber% LSS 1 (goto tipstricks)
if %randomnumber% GTR 208 (goto tipstricks)

:: TIPS GO HERE ---------------------------------

if %randomnumber%==1 (echo You can use Ctrl+Shift+Esc to open task manager& goto endoftip
) else if %randomnumber%==2 (echo You can use the Windows Key/Ctrl + Esc to open Cortana& goto endoftip
) else if %randomnumber%==3 (echo You can use Alt+F4 to quickly exit an application& goto endoftip
) else if %randomnumber%==4 (echo Press the Windows Key + E and to quickly open the file explorer& goto endoftip
) else if %randomnumber%==5 (echo Press Alt + Tab to quickly switch between tabs& goto endoftip
) else if %randomnumber%==6 (echo Press the Windows Key + Break/Pause to view basic PC info& goto endoftip
) else if %randomnumber%==7 (echo Press the Windows Key + Up Arrow to Maximize the current tab& goto endoftip
) else if %randomnumber%==8 (echo Press the Windows Key + F and to quickly open the file search/feedback& goto endoftip
) else if %randomnumber%==9 (echo Press the Windows Key + D and to quickly minimize and visualize all tabs& goto endoftip
) else if %randomnumber%==10 (echo Press Alt + Letter to open menu options in the current app[alt+f to open the file menu]& goto endoftip
) else if %randomnumber%==11 (echo Press Ctrl + F4 to quickly close the current document& goto endoftip
) else if %randomnumber%==12 (echo Press Alt + Spacebar to quickly open options for the current application& goto endoftip
) else if %randomnumber%==13 (echo Press Ctrl + right or left arrow keys to quickly move back and forth by one word& goto endoftip
) else if %randomnumber%==14 (echo Press Ctrl + up or down arrow keys to quickly move up and down by one paragraph& goto endoftip
) else if %randomnumber%==15 (echo Press Ctrl + the Windows Key + ?/? to quickly move between desktops& goto endoftip
) else if %randomnumber%==16 (echo Press F1 to quickly open the help menu for the current tab& goto endoftip
) else if %randomnumber%==17 (echo Press the Windows Key + M to quickly minimize all tabs& goto endoftip
) else if %randomnumber%==18 (echo Press the Windows Key + Tab to quickly open task view& goto endoftip
) else if %randomnumber%==19 (echo Press Left Alt + Left Shift + Prnt Screen to bring up the High Contrast Menu& goto endoftip
) else if %randomnumber%==20 (echo Hold Right Shift for 8 seconds to bring up the Filter Keys Menu& goto endoftip
) else if %randomnumber%==21 (echo Press Shift 5 times quickly to open up the Sticky Keys Menu& goto endoftip
) else if %randomnumber%==22 (echo Hold Num Lock for 5 seconds to open the Toggle Keys Menu& goto endoftip
) else if %randomnumber%==23 (echo Press Ctrl + Enter to send an email, respond to a Windows 10 notification, and much more.& goto endoftip
) else if %randomnumber%==24 (echo Press the Windows Key + R and type "calc" to quickly open calculator& goto endoftip
) else if %randomnumber%==25 (echo Press the Windows Key + R and type "taskmgr" to quickly open task manager& goto endoftip
) else if %randomnumber%==26 (echo Press the Windows Key + R and type "%appdata%" to quickly open the appdata folder& goto endoftip
) else if %randomnumber%==27 (echo Press the Windows Key + R and type "dxdiag" to find out info about your PC& goto endoftip
) else if %randomnumber%==28 (echo Press the Windows Key + R and type "cleanmgr" to quickly open disk cleanup& goto endoftip
) else if %randomnumber%==29 (echo Press the Windows Key + R and type "devmgmt.msc/hdwwiz.cpl" to open the Device Manager& goto endoftip
) else if %randomnumber%==30 (echo Press the Windows Key + R and type "msinfo32" to quickly open System Information& goto endoftip
) else if %randomnumber%==31 (echo Press the Windows Key + R and type "mmc" to quickly open the Microsoft Management Console& goto endoftip
) else if %randomnumber%==32 (echo Press the Windows Key + R and type "notepad" to quickly open Notepad& goto endoftip
) else if %randomnumber%==33 (echo Press the Windows Key + R and type "wordpad" to quickly open Wordpad& goto endoftip
) else if %randomnumber%==34 (echo Press the Windows Key + R and type "mspaint" to quickly open Microsoft Paint& goto endoftip
) else if %randomnumber%==35 (echo Press the Windows Key + R and type "rstrui" to quickly open Restore the System& goto endoftip
) else if %randomnumber%==36 (echo Press the Windows Key + R and type "control" to quickly open the Control Panel& goto endoftip
) else if %randomnumber%==37 (echo Press the Windows Key + R and type "control printers" to quickly open the Printer Panel& goto endoftip
) else if %randomnumber%==38 (echo Press the Windows Key + R and type "hdwwiz" to quickly add a hardware wizard& goto endoftip
) else if %randomnumber%==39 (echo Press the Windows Key + R and type "devicepairingwizard" to quickly add a new device [Like Printers]& goto endoftip
) else if %randomnumber%==40 (echo Press the Windows Key + R and type "azman.msc/netplwiz" to quickly open the Advanced User Account Menu& goto endoftip
) else if %randomnumber%==41 (echo Press the Windows Key + R and type "sdclt" to quickly Backup and Restore files of your choice& goto endoftip
) else if %randomnumber%==42 (echo Press the Windows Key + R and type "certmgr.msc" to view all Certificates& goto endoftip
) else if %randomnumber%==43 (echo Press the Windows Key + R and type "charmap" to quickly open the Character Map& goto endoftip
) else if %randomnumber%==44 (echo Press the Windows Key + R and type "cttune" to quickly make text smoother& goto endoftip
) else if %randomnumber%==45 (echo Press the Windows Key + R and type "colorcpl" to quickly open the Color Management Menu& goto endoftip
) else if %randomnumber%==46 (echo Press the Windows Key + R and type "cmd" to quickly open the Command Prompt& goto endoftip
) else if %randomnumber%==47 (echo Press the Windows Key + R and type "comexp.msc/dcomcnfg" to quickly open the Component Services Menu& goto endoftip
) else if %randomnumber%==48 (echo Press the Windows Key + R and type "compmgmt.msc/compmgmtlauncher" to quickly open Computer Management& goto endoftip
) else if %randomnumber%==49 (echo Press the Windows Key + R and type "displayswitch" to quickly open the Monitor Options [Double Monitors, Projectors, etc.]& goto endoftip
) else if %randomnumber%==50 (echo Press the Windows Key + R and type "credwiz" to quickly open the Credential Backup and Restore Wizard& goto endoftip
) else if %randomnumber%==51 (echo Press the Windows Key + R and type "systempropertiesdataexecutionprevention" to quickly open the Data Execution Prevention Menu& goto endoftip
) else if %randomnumber%==52 (echo Press the Windows Key + R and type "timedate.cpl" to quickly check the time and date& goto endoftip
) else if %randomnumber%==53 (echo Press the Windows Key + R and type "msdt" to quickly open the Diagnostics Troubleshooting Wizard& goto endoftip
) else if %randomnumber%==54 (echo Press the Windows Key + R and type "tabcal" to quickly open the Digitizer Calibration Tool& goto endoftip
) else if %randomnumber%==55 (echo Press the Windows Key + R and type "dfrgui" to quickly open the Disk Defragmenter& goto endoftip
) else if %randomnumber%==56 (echo Press the Windows Key + R and type "ncpa.cpl" to quickly open Network Connections& goto endoftip
) else if %randomnumber%==57 (echo Press the Windows Key + R and type "diskmgmt.msc" to quickly open the Disk Manager& goto endoftip
) else if %randomnumber%==58 (echo Press the Windows Key + R and type "dpiscaling" to quickly open the Display Options& goto endoftip
) else if %randomnumber%==59 (echo Press the Windows Key + R and type "dccw" to quickly open Display Color Calibration& goto endoftip
) else if %randomnumber%==60 (echo Press the Windows Key + R and type "dpapimig" to quickly open the DPAPI Key Migration Wizard& goto endoftip
) else if %randomnumber%==61 (echo Press the Windows Key + R and type "verifier" to quickly open the Driver Verifier Manager& goto endoftip
) else if %randomnumber%==62 (echo Press the Windows Key + R and type "utilman" to quickly open the Ease of Access Center& goto endoftip
) else if %randomnumber%==63 (echo Press the Windows Key + R and type "eventvwr.msc" to quickly open the Event Viewer& goto endoftip
) else if %randomnumber%==64 (echo Press the Windows Key + R and type "joy.cpl" to quickly open the Game Controllers Menu& goto endoftip
) else if %randomnumber%==65 (echo Press the Windows Key + R and type "irprops.cpl" to quickly open the Infrared Manager& goto endoftip
) else if %randomnumber%==66 (echo Press the Windows Key + R and type "iexpress" to quickly open the iExpress Wizard& goto endoftip
) else if %randomnumber%==67 (echo Press the Windows Key + R and type "iexplore" to quickly open Internet Explorer& goto endoftip
) else if %randomnumber%==68 (echo Press the Windows Key + R and type "inetcpl.cpl" to quickly open Internet Options& goto endoftip
) else if %randomnumber%==69 (echo Press the Windows Key + R and type "lpksetup" to quickly open the Language Pack Installer& goto endoftip
) else if %randomnumber%==70 (echo Press the Windows Key + R and type "lsrmgr.msc" to quickly open Local Users and Groups& goto endoftip
) else if %randomnumber%==71 (echo Press the Windows Key + R and type "magnify" to quickly open the Screen Magnifier& goto endoftip
) else if %randomnumber%==72 (echo Press the Windows Key + R and type "mip" to quickly open the Math Input Panel& goto endoftip
) else if %randomnumber%==73 (echo Press the Windows Key + R and type "mmc" to quickly open the Microsoft Management Console& goto endoftip
) else if %randomnumber%==74 (echo Press the Windows Key + R and type "main.cpl" to quickly open Mouse Settings& goto endoftip
) else if %randomnumber%==75 (echo Press the Windows Key + R and type "appwiz.cpl" to quickly open the Uninstall Menu& goto endoftip
) else if %randomnumber%==76 (echo Press the Windows Key + R and type "napclcfg.msc" to quickly open NAP Client Configuration& goto endoftip
) else if %randomnumber%==77 (echo Press the Windows Key + R and type "narrator" to quickly open the Narrator [Text To Speech]& goto endoftip
) else if %randomnumber%==78 (echo Press the Windows Key + R and type "wiaacmgr" to quickly open the New Scan Wizar& goto endoftip
) else if %randomnumber%==79 (echo Press the Windows Key + R and type "osk" to quickly turn on the On-Screen Keyboard& goto endoftip
) else if %randomnumber%==80 (echo Press the Windows Key + R and type "documents" to quickly open the Documents Folder& goto endoftip
) else if %randomnumber%==81 (echo Press the Windows Key + R and type "downloads" to quickly open the Downloads Folder& goto endoftip
) else if %randomnumber%==82 (echo Press the Windows Key + R and type "favorites" to quickly open the Favorites Folder& goto endoftip
) else if %randomnumber%==83 (echo Press the Windows Key + R and type "pictures" to quickly open the Pictures Folder& goto endoftip
) else if %randomnumber%==84 (echo Press the Windows Key + R and type "recent" to quickly open the Recents Folder& goto endoftip
) else if %randomnumber%==85 (echo Press the Windows Key + R and type "videos" to quickly open the Videos Folder& goto endoftip
) else if %randomnumber%==86 (echo Press the Windows Key + R and type "tabletpc.cpl" to quickly open Pen and Touch& goto endoftip
) else if %randomnumber%==87 (echo Press the Windows Key + R and type "collab.cpl" to quickly open People Near Me& goto endoftip
) else if %randomnumber%==88 (echo Press the Windows Key + R and type "perfmon.msc" to quickly open the Perfomance Monitor& goto endoftip
) else if %randomnumber%==89 (echo Press the Windows Key + R and type "systempropertiesperformance" to quickly open the Performance Options& goto endoftip
) else if %randomnumber%==90 (echo Press the Windows Key + R and type "telephon.cpl" to quickly open the Phone Connections& goto endoftip
) else if %randomnumber%==91 (echo Press the Windows Key + R and type "dialer" to quickly open the Phone Dialer& goto endoftip
) else if %randomnumber%==92 (echo Press the Windows Key + R and type "powercfg.cpl" to quickly open Computer Power Options& goto endoftip
) else if %randomnumber%==93 (echo Press the Windows Key + R and type "printui" to quickly open the Printer User Interface& goto endoftip
) else if %randomnumber%==94 (echo Press the Windows Key + R and type "eudcedit" to quickly open the Private Character Editor& goto endoftip
) else if %randomnumber%==95 (echo Press the Windows Key + R and type "psr" to quickly open the Problem Steps Recorder& goto endoftip
) else if %randomnumber%==96 (echo Press the Windows Key + R and type "intl.cpl" to quickly open Region ^& Language& goto endoftip
) else if %randomnumber%==97 (echo Press the Windows Key + R and type "regedit" to quickly open the Registry Editor& goto endoftip
) else if %randomnumber%==98 (echo Press the Windows Key + R and type "rasphone" to quickly open the Remote Access Phonebook& goto endoftip
) else if %randomnumber%==99 (echo Press the Windows Key + R and type "mstsc" to quickly open the Remote Desktop Connection& goto endoftip
) else if %randomnumber%==100 (echo Press the Windows Key + R and type "resmon" to quickly open the Resource Monitor& goto endoftip
) else if %randomnumber%==101 (echo Press the Windows Key + R and type "desk.cpl" to quickly open the Screen Resolution Settings& goto endoftip
) else if %randomnumber%==102 (echo Press the Windows Key + R and type "services.msc" to quickly open Services& goto endoftip
) else if %randomnumber%==103 (echo Press the Windows Key + R and type "computerdefaults" to quickly set Program Access and Computer Defaults& goto endoftip
) else if %randomnumber%==104 (echo Press the Windows Key + R and type "shrpubw" to quickly open the Shared Folder Wizard& goto endoftip
) else if %randomnumber%==105 (echo Press the Windows Key + R and type "fsmgmt.msc" to quickly open Shared Folders& goto endoftip
) else if %randomnumber%==106 (echo Press the Windows Key + R and type "snippingtool" to quickly open the Snipping Tool& goto endoftip
) else if %randomnumber%==107 (echo Press the Windows Key + R and type "mmsys.cpl" to quickly open Sound Settings& goto endoftip
) else if %randomnumber%==108 (echo Press the Windows Key + R and type "soundrecorder" to quickly open the Sound Recorder& goto endoftip
) else if %randomnumber%==109 (echo Press the Windows Key + R and type "stikynot" to quickly open Sticky Notes& goto endoftip
) else if %randomnumber%==110 (echo Press the Windows Key + R and type "msconfig" to quickly open System Configuration& goto endoftip
) else if %randomnumber%==111 (echo Press the Windows Key + R and type "sysedit" to quickly open the System Configuration Editor& goto endoftip
) else if %randomnumber%==112 (echo Press the Windows Key + R and type "sysdm.cpl" to quickly open System Properties& goto endoftip
) else if %randomnumber%==113 (echo Press the Windows Key + R and type "systempropertiesadvanced" to quickly open System Properties Advanced& goto endoftip
) else if %randomnumber%==114 (echo Press the Windows Key + R and type "systempropertieshardware" to quickly open System Properties Hardware& goto endoftip
) else if %randomnumber%==115 (echo Press the Windows Key + R and type "systempropertiesremote" to quickly open System Properties Remote& goto endoftip
) else if %randomnumber%==116 (echo Press the Windows Key + R and type "systempropertiesprotection" to quickly open System Properties Protection& goto endoftip
) else if %randomnumber%==117 (echo Press the Windows Key + R and type "wmplayer" to quickly open the Windows Media Player& goto endoftip
) else if %randomnumber%==118 (echo Press the Windows Key + R and type "ms-settings:windowsupdate" to quickly open the Windows Update Tab& goto endoftip
) else if %randomnumber%==119 (echo Ctrl+Insert will copy an item& goto endoftip
) else if %randomnumber%==120 (echo Shift+Insert will paste an item& goto endoftip
) else if %randomnumber%==121 (echo Windows Key + L will lock the PC& goto endoftip
) else if %randomnumber%==122 (echo F2 will rename a selected item& goto endoftip
) else if %randomnumber%==123 (echo F3 will search for a file/folder in file explorer& goto endoftip
) else if %randomnumber%==124 (echo F4 will display the address bar list in file explorer& goto endoftip
) else if %randomnumber%==125 (echo F5 will refresh the active window& goto endoftip
) else if %randomnumber%==126 (echo F6 will cycle through screen elements in a window or on the desktop& goto endoftip
) else if %randomnumber%==127 (echo F10 will activate the menu bar in the active app& goto endoftip
) else if %randomnumber%==128 (echo Alt + F8 will show the current typed in password in the sign-in screen& goto endoftip
) else if %randomnumber%==129 (echo Alt + Esc will cycle through open applications in the order they were oppened& goto endoftip
) else if %randomnumber%==130 (echo Alt + Spacebar will open the shortcut menu for the current focused window& goto endoftip
) else if %randomnumber%==131 (echo Alt + Left or Right arrow keys will let you go back or forward in any browser& goto endoftip
) else if %randomnumber%==132 (echo Alt + Page Up/Page Down will let you go up/down one screen& goto endoftip
) else if %randomnumber%==133 (echo Ctrl + A will select all text& goto endoftip
) else if %randomnumber%==134 (echo Ctrl + D will move a selected file to the recycling bin& goto endoftip
) else if %randomnumber%==135 (echo Ctrl + R/F5 will refresh Windows& goto endoftip
) else if %randomnumber%==136 (echo Replacing the youtube URL with "youtube.com/watch?=example123" to "youtube.com/embed/example123" will embed the video in the browser& goto endoftip
) else if %randomnumber%==137 (echo Ctrl + Arrow key will let you skip words& goto endoftip
) else if %randomnumber%==138 (echo Ctrl + Alt + Tab will let you see all of your tabs
) else if %randomnumber%==139 (echo Ctrl + Arrow key while the start menu is open will allow you to resize it& goto endoftip
) else if %randomnumber%==140 (echo Ctrl + Esc or the Windows Key will open the start menu& goto endoftip
) else if %randomnumber%==141 (echo Ctrl + Shift + Esc will open task manager& goto endoftip
) else if %randomnumber%==142 (echo Ctrl + Shift will let you switch your keyboard language when other languages are downloaded& goto endoftip
) else if %randomnumber%==143 (echo Shift + F10 will let you display the shortcut menu for the selected item& goto endoftip
) else if %randomnumber%==144 (echo Shift + Arrow key will let you select more than one window, or select text in a text document& goto endoftip
) else if %randomnumber%==145 (echo Shift + Ctrl + Arrow key will let you select words in a text document& goto endoftip
) else if %randomnumber%==146 (echo Shift + Delete will perminatly delete the selected file without moving it to the recycling bin& goto endoftip
) else if %randomnumber%==147 (echo Prt Sc or FN + Prt Sc will take a screenshot& goto endoftip
) else if %randomnumber%==148 (echo Windows key will Open or close Start.& goto endoftip
) else if %randomnumber%==149 (echo Windows key + A will Open Action center.& goto endoftip
) else if %randomnumber%==150 (echo Windows key + B will Set focus in the notification area.& goto endoftip
) else if %randomnumber%==151 (echo Windows key + C will Open Cortana in listening mode.& goto endoftip
) else if %randomnumber%==152 (echo Windows key + Shift + C will Open the charms menu.& goto endoftip
) else if %randomnumber%==153 (echo Windows key + D will Display and hide the desktop.& goto endoftip
) else if %randomnumber%==154 (echo Windows key + Alt + D will Display and hide the date and time on the desktop.& goto endoftip
) else if %randomnumber%==155 (echo Windows key + E will Open File Explorer.& goto endoftip
) else if %randomnumber%==156 (echo Windows key + F will Open Feedback Hub and take a screenshot.& goto endoftip
) else if %randomnumber%==157 (echo Windows key + G will Open Game bar when a game is open.& goto endoftip
) else if %randomnumber%==158 (echo Windows key + H will Start dictation.& goto endoftip
) else if %randomnumber%==159 (echo Windows key + I will Open Settings.& goto endoftip
) else if %randomnumber%==160 (echo Windows key + J will Set focus to a Windows tip when one is available.& goto endoftip
) else if %randomnumber%==161 (echo Windows key + K will Open the Connect quick action.& goto endoftip
) else if %randomnumber%==162 (echo Windows key + L will Lock your PC or switch accounts.& goto endoftip
) else if %randomnumber%==163 (echo Windows key + M will Minimize all windows.& goto endoftip
) else if %randomnumber%==164 (echo Windows key + O will Lock device orientation.& goto endoftip
) else if %randomnumber%==165 (echo Windows key + P will Choose a presentation display mode.& goto endoftip
) else if %randomnumber%==166 (echo Windows key + Ctrl + Q will Open Quick Assist.& goto endoftip
) else if %randomnumber%==167 (echo Windows key + R will Open the Run dialog box.& goto endoftip
) else if %randomnumber%==168 (echo Windows key + S will Open search.& goto endoftip
) else if %randomnumber%==169 (echo Windows key + Shift + S will Take a screenshot of part of your screen.& goto endoftip
) else if %randomnumber%==170 (echo Windows key + T will Cycle through apps on the taskbar.& goto endoftip
) else if %randomnumber%==171 (echo Windows key + U will Open Ease of Access Center.& goto endoftip
) else if %randomnumber%==172 (echo Windows key + V will Open the clipboard& goto endoftip
) else if %randomnumber%==173 (echo Windows key + Shift + V will Cycle through notifications.& goto endoftip
) else if %randomnumber%==174 (echo Windows key + X will Open the Quick Link menu.& goto endoftip
) else if %randomnumber%==175 (echo Windows key + Y will Switch input between Windows Mixed Reality and your desktop.& goto endoftip
) else if %randomnumber%==176 (echo Windows key + Z will Show the commands available in an app in full-screen mode.& goto endoftip
) else if %randomnumber%==177 (echo Windows key + period ^. or semicolon ^; will Open emoji panel.& goto endoftip
) else if %randomnumber%==178 (echo Windows key + comma ^, will Temporarily peek at the desktop.& goto endoftip
) else if %randomnumber%==179 (echo Windows key + Pause will Display the System Properties dialog box.& goto endoftip
) else if %randomnumber%==180 (echo Windows key + Ctrl + F will Search for PCs if you're on a network.& goto endoftip
) else if %randomnumber%==181 (echo Windows key + Shift + M will Restore minimized windows on the desktop.& goto endoftip
) else if %randomnumber%==182 (echo Windows key + number will Open the desktop and start the app pinned to the taskbar in the position indicated by the number. If the app is already running, switch to that app.& goto endoftip
) else if %randomnumber%==183 (echo Windows key + Shift + number will Open the desktop and start a new instance of the app pinned to the taskbar in the position indicated by the number.& goto endoftip
) else if %randomnumber%==184 (echo Windows key + Ctrl + number will Open the desktop and switch to the last active window of the app pinned to the taskbar in the position indicated by the number.& goto endoftip
) else if %randomnumber%==185 (echo Windows key + Alt + number will Open the desktop and open the Jump List for the app pinned to the taskbar in the position indicated by the number.& goto endoftip
) else if %randomnumber%==186 (echo Windows key + Ctrl + Shift + number will Open the desktop and open a new instance of the app located at the given position on the taskbar as an administrator.& goto endoftip
) else if %randomnumber%==187 (echo Windows key + Tab	will Open Task view.& goto endoftip
) else if %randomnumber%==188 (echo Windows key + Up arrow will Maximize the window.& goto endoftip
) else if %randomnumber%==189 (echo Windows key + Down arrow will Remove current app from screen or minimize the desktop window.& goto endoftip
) else if %randomnumber%==190 (echo Windows key + Left arrow will Maximize the app or desktop window to the left side of the screen.& goto endoftip
) else if %randomnumber%==191 (echo Windows key + Right arrow will Maximize the app or desktop window to the right side of the screen.& goto endoftip
) else if %randomnumber%==192 (echo Windows key + Home will Minimize all except the active desktop window restores all windows on second stroke& goto endoftip
) else if %randomnumber%==193 (echo Windows key + Shift + Up arrow will Stretch the desktop window to the top and bottom of the screen.& goto endoftip
) else if %randomnumber%==194 (echo Windows key + Shift + Down arrow will Restore/minimize active desktop windows vertically, maintaining width.& goto endoftip
) else if %randomnumber%==195 (echo Windows key + Shift + Left arrow or Right arrow will Move an app or window in the desktop from one monitor to another.
) else if %randomnumber%==196 (echo Windows key + Spacebar will Switch input language and keyboard layout.& goto endoftip
) else if %randomnumber%==197 (echo Windows key + Ctrl + Spacebar will Change to a previously selected input.& goto endoftip
) else if %randomnumber%==198 (echo Windows key + Ctrl + Enter will Turn on Narrator.& goto endoftip
) else if %randomnumber%==199 (echo Windows key + Plus + will Open Magnifier.& goto endoftip
) else if %randomnumber%==200 (echo Windows key + forward slash ^/ will Begin IME reconversion.& goto endoftip
) else if %randomnumber%==201 (echo Windows key + Ctrl + V will Open shoulder taps.& goto endoftip
) else if %randomnumber%==202 (echo Windows key + Ctrl + Shift + B will Wake PC from blank or black screen& goto endoftip
) else if %randomnumber%==203 (echo Pressing Shift + click a taskbar button will Open an app or quickly open another instance of an app.& goto endoftip
) else if %randomnumber%==204 (echo Pressing Ctrl + Shift + click a taskbar button will Open an app as an administrator.& goto endoftip
) else if %randomnumber%==205 (echo Pressing Shift + right-click a taskbar button will Show the window menu for the app.& goto endoftip
) else if %randomnumber%==206 (echo Pressing Shift + right-click a grouped taskbar button will Show the window menu for the group.& goto endoftip
) else if %randomnumber%==207 (echo Pressing Ctrl + click on a grouped taskbar button will Cycle through the windows of the group.& goto endoftip)
goto tipstricks

:endoftip
echo Tip ID: %randomnumber%
:: ----------------------------------------------


echo.
choice /c 123 /m "Press (1) to go back to menu, (2) to generate another tip, and (3) to teleport to a tip"
if "%errorlevel%"=="1" (
	call :jokegen
    goto menu 
)
if "%errorlevel%"=="3" (
    goto tiptp
)
goto tipstricks


:tiptp
echo.
echo (NUMBERS ONLY)
set /P randomnumber=Type the tip ID: 
cls
goto skiprandomize



:: ISOLATION ------------------
:isolation
mode 85,25
echo.   ____         __     __  _         
echo.  /  _/__ ___  / /__ _/ /_(_)__  ___ 
echo. _/ /(_-^</ _ \/ / _ '/ __/ / _ \/ _ \
echo./___/___/\___/_/\_,_/\__/_/\___/_//_/
echo . . . . . . . . . . . . . . . . . . . .                                     
echo.
echo Type in the full path the the file you would like to open (REMOVE QUOTES): 
set /p isolateprogram=Program: 
if NOT EXIST "%isolateprogram%" (echo.& echo "%isolateprogram%" does not exist. & timeout 1 >nul & goto menu)
echo.
echo Isolating...
powershell start-process '%isolateprogram%'
taskkill /f /im explorer.exe
msg * /time:1 Sucessfully entered isolation mode.
:resetthing
cls
echo.   ____         __     __  _         
echo.  /  _/__ ___  / /__ _/ /_(_)__  ___ 
echo. _/ /(_-^</ _ \/ / _ '/ __/ / _ \/ _ \
echo./___/___/\___/_/\_,_/\__/_/\___/_//_/
echo . . . . . . . . . . . . . . . . . . . .   
	echo Press Alt+Tab to switch between programs.
	echo Press "X" in this prompt to exit isolation mode.
	echo Press "V" in this prompt to open the volume mixer.
	echo Press "A" in this prompt to open autoclicker.
	echo Press "C" in this prompt to enter calculator.
	echo.
	echo You can minimize this prompt and come back to it later.
	choice /c XVAC /n
	IF %ERRORLEVEL% EQU 2 (
		start %systemroot%\System32\sndvol.exe
		set volumekill=taskkill /f /im sndvol.exe
		goto resetthing
	)
	IF %ERRORLEVEL% EQU 1 (
		goto exitmode
	)
	IF %ERRORLEVEL% EQU 3 (
		goto autoclick
	)
	IF %ERRORLEVEL% EQU 4 (
		goto calculatortime
	)
REM ------------------------------------
:calculatortime
cls
echo NUMBERS ONLY
set /p num1=What is your first number? : 
cls
    echo What operation?
    echo Press 1 for addition
    echo Press 2 for subtraction
    echo Press 3 for multiplication
    echo Press 4 for division
choice /c 12345 /n /m "Select your operation: "
cls
if "%errorlevel%"=="1" (
   set thing=goto addition
)
if "%errorlevel%"=="2" (
   set thing=goto subtraction
)
if "%errorlevel%"=="3" (
   set thing=goto multiplication
)
if "%errorlevel%"=="4" (
   set thing=goto division
)
if "%errorlevel%"=="5" (
   set thing=goto secretthing
)
echo NUMBERS ONLY
set /p num2=What is your second number? : 
cls
%thing%
:addition
set /a result= %num1% + %num2%
goto end
:subtraction
set /a result= %num1% - %num2%
goto end
:multiplication
set /a result= %num1% * %num2%
goto end
:division
set /a result= %num1% / %num2%
goto end
:secretthing
set /a result1= %num1% / %num2%
set /a result= %num1% - (%result1% * %num2%)
set /a remainder=1
goto end
:end
cls
if "%remainder%"=="1" (
   echo Your remainder is %result%.
) else (
   echo Your answer is %result%.
)
timeout 5 >nul
goto resetthing
REM -----------------------------
:autoclick
cls
cd %USERPROFILE%\Documents
if NOT EXIST isolationscriptdata (goto scanforit) else (
	call %USERPROFILE%\Documents\isolationscriptdata\cache.bat
	set clickerkill=taskkill /f /im autoclicker.exe
	cls
	goto resetthing
)
:scanforit
choice /c YN /m "Are you sure you want to scan the %USERPROFILE% directories for AutoClicker.exe?"
IF %ERRORLEVEL% EQU 2 (
	goto resetthing
)
echo Scanning user library for "AutoClicker.exe"...
echo.
echo Scanning %USERPROFILE%...
if EXIST "%USERPROFILE%\AutoClicker.exe" (
	echo Found %USERPROFILE%\AutoClicker.
	set shouldiuseit="%USERPROFILE%\AutoClicker.exe"
	goto scancomplete
)
echo Scanning %USERPROFILE%\Desktop...
if EXIST "%USERPROFILE%\Desktop\AutoClicker.exe" (
	echo Found %USERPROFILE%\Desktop\AutoClicker.
	set shouldiuseit="%USERPROFILE%\Desktop\AutoClicker.exe"
	goto scancomplete
)
echo Scanning %USERPROFILE%\Documents...
if EXIST "%USERPROFILE%\Documents\AutoClicker.exe" (
	echo Found %USERPROFILE%\Documents\AutoClicker.
	set shouldiuseit="%USERPROFILE%\Documents\AutoClicker.exe"
	goto scancomplete
)
echo Scanning %USERPROFILE%\Downloads...
if EXIST "%USERPROFILE%\Downloads\AutoClicker.exe" (
	echo Found %USERPROFILE%\Downloads\AutoClicker.
	set shouldiuseit="%USERPROFILE%\Downloads\AutoClicker.exe"
	goto scancomplete
)
REM If could not find
cls
echo Could not locate AutoClicker.exe
echo.
echo Would you like to go to the download page of AutoClicker.exe?
choice /c YN
IF %ERRORLEVEL% EQU 1 (
	start https://sourceforge.net/projects/orphamielautoclicker/
)
cls
goto resetthing
:scancomplete
cls
echo Found %shouldiuseit%.
echo.
echo Saving data...
cd %USERPROFILE%\Documents
mkdir isolationscriptdata
cd isolationscriptdata
echo:powershell start-process %shouldiuseit% >> cache.bat
timeout 3 >nul
cls
goto resetthing
:exitmode
%volumekill%
%clickerkill%
start explorer.exe
	msg * /time:1 Sucessfully exited isolation mode. 1>nul 2>nul
call :jokegen
goto menu

:: -----------------------------------------------------------

:: HELP
:helpscreen
mode 101,25
if DEFINED disablejokes (set jokemenudis=Enable Jokes: ) else (set jokemenudis=Disable Jokes:)
if DEFINED disablejokes (set onoroff=ON) else (set onoroff=OFF)
echo.   __ __    __   
echo.  / // /__ / /__ 
echo. / _  / -_) / _ \
echo./_//_/\__/_/ .__/
echo . . . . . /_/ . . . . . . . . . . . . . . .
echo.
echo. Chrome Cursor:    Fix the invisible cursor gitch in Google Chrome
echo. Help Screen:      Shows this screen
echo. Isolate Programs: Close out of Windows to get maximum focus on a specific task
echo. Tips ^& Tricks:    Windows 10 tips and tricks generator
echo. Clear Temp Files: Removes unnessecary files that bloat your system
echo. View System Info: Shows all system information
echo. Antivirus (WIP):  Simple virus remover thats scans for common viruses, malwares, and security risks
echo. Run on Startup:   Run this program on startup
echo. Refresh Explorer: Refreshes the Windows OS (so you don't have to restart)
echo. Change Color:     Change the default color of this program
echo. Repair System:    Repairs system files in case of corruption (will take a while)
echo. Not Responding:   Close all not responding tasks
echo. Sources:          Displays our research sources
echo. File Organizer:   Organizes files in your Desktop and Downloads folder
echo. %jokemenudis%    Toggles Jokes %onoroff%
echo. About:            Opens about screen
echo.
echo . . . . Press any key to return to menu . . . .
pause >nul
call :jokegen
goto menu

:: Invisible Chrome Cursor Fix
:chromefix
echo.  _____                        _____     
echo. / ___/_ _________ ___  ____  / __(_)_ __
echo./ /__/ // / __(_-^</ _ \/ __/ / _// /\ \ /
echo.\___/\_,_/_/ /___/\___/_/   /_/ /_//_\_\
echo . . . . . . . . . . . . . . . . . . . . . .
echo.

echo Are you sure you want to close out of Chrome?
echo (Please save all of your work before continuing.)
choice /c YN

if "%ERRORLEVEL%"=="2" (goto menu)

echo.
echo Loading...
:: Close out of chrome
taskkill /f /im chrome.exe 1>nul 2>nul
timeout 3 >nul
start chrome.exe


call :jokegen
goto menu


:: Disable jokes
:togglejokes

if DEFINED disablejokes (goto enablejoke)


:: Disable Joke
	if EXIST jokedat.bat (del jokedat.bat)
	echo:set disablejokes=1 >>jokedat.bat 
	call jokedat.bat
	goto menu

:: Enable Joke
:enablejoke
	if EXIST jokedat.bat (del jokedat.bat)
	echo:set "disablejokes=" >>jokedat.bat 
	call jokedat.bat
	goto menu

:: ---------------------------------

:jokegen

if DEFINED disablejokes (goto:eof)


set /a randomjoke=%RANDOM% * 197 / 32768 + 1

if %randomjoke%==1 (msg * "What's the tallest building in the world?  The library, cause it has the most stories."
) else if %randomjoke%==2 (msg * "How do trees get online?  They log in."
) else if %randomjoke%==3 (msg * "Why did the scarecrow keep getting promoted? Because he was outstanding in his field."
) else if %randomjoke%==4 (msg * "What car does Jesus drive?  A Christler."
) else if %randomjoke%==5 (msg * "What does a grape say after it's stepped on?  Nothing.  It just lets out a little wine."
) else if %randomjoke%==6 (msg * "Why don't teddy bears ever order dessert. Because they're always stuffed."
) else if %randomjoke%==7 (msg * "What do you call a bear with no teeth?  A gummy bear."
) else if %randomjoke%==8 (msg * "Why did the man put his money in the freezer?  He wanted cold hard cash!"
) else if %randomjoke%==9 (msg * "What did the porcupine say to the cactus?  "Is that you mommy?""
) else if %randomjoke%==10 (msg * "What do you get when you cross a snowman with a vampire?  Frostbite."
) else if %randomjoke%==11 (msg * "How do crazy people go through the forest?  They take the psycho path."
) else if %randomjoke%==12 (msg * "What do prisoners use to call each other?  Cell phones."
) else if %randomjoke%==13 (msg * "What do you get from a pampered cow?  Spoiled milk."
) else if %randomjoke%==14 (msg * "What happens when a frog's car breaks down?  It gets toad away."
) else if %randomjoke%==15 (msg * "Why didn't the melons get married?  Because they cantaloupe."
) else if %randomjoke%==16 (msg * "Why shouldn't you write with a broken pencil?  There's no point."
) else if %randomjoke%==17 (msg * "Why are barns so noisy? Because all the cows have horns."
) else if %randomjoke%==18 (msg * "What do you call someone wearing a belt with a watch attached to it? A waist of time."
) else if %randomjoke%==19 (msg * "Why can't you trust an atom? Because they make up literally everything."
) else if %randomjoke%==20 (msg * "What do computers snack on? Microchips."
) else if %randomjoke%==21 (msg * "What do you call a cow eating grass in a paddock?  A lawn mooer."
) else if %randomjoke%==22 (msg * "Why didn't the skeleton go to the dance?  Because he had no-body to go with."
) else if %randomjoke%==23 (msg * "What did the penny say to the other penny?  We make perfect cents."
) else if %randomjoke%==24 (msg * "Why did the man with one hand cross the road?  To get to the second hand shop."
) else if %randomjoke%==25 (msg * "How come oysters never donate to charity? Because they're shellfish."
) else if %randomjoke%==26 (msg * "How do baseball players stay cool?  Sit next to their fans."
) else if %randomjoke%==27 (msg * "What gets wetter the more it dries?  A towel."
) else if %randomjoke%==28 (msg * "Why was the math book sad?  Because it had too many problems."
) else if %randomjoke%==29 (msg * "What runs but doesn't get anywhere?  A refrigerator."
) else if %randomjoke%==30 (msg * "What do you do with a blue whale?  Try to cheer him up!"
) else if %randomjoke%==31 (msg * "How do you communicate with a fish?  Drop him a line!"
) else if %randomjoke%==32 (msg * "What do you call two Mexicans playing basketball? A Juan on Juan."
) else if %randomjoke%==33 (msg * "A man got hit in the head with a can of Coke. Thank goodness it was a soft drink."
) else if %randomjoke%==34 (msg * "I never wanted to believe that my Dad was stealing from his job as a road worker. But when I got home, all the signs were there."
) else if %randomjoke%==35 (msg * "What's the difference between roast beef and pea soup? Anyone can roast beef but nobody can pee soup"
) else if %randomjoke%==36 (msg * "Did you hear about the guy who broke both his left arm and left leg? He's all right now."
) else if %randomjoke%==37 (msg * "Which weighs more, a ton of feathers or a ton of bricks?  Neither, they both weigh a ton!"
) else if %randomjoke%==38 (msg * "What has four eyes but can't see?  Mississippi!"
) else if %randomjoke%==39 (msg * "Where does wood come from?  A guy named woody."
) else if %randomjoke%==40 (msg * "What has one horn and gives milk? A milk truck."
) else if %randomjoke%==41 (msg * "Where do bulls get their messages? On a bull-etin board."
) else if %randomjoke%==42 (msg * "What runs but can't walk?  The faucet!"
) else if %randomjoke%==43 (msg * "What kind of bed does a mermaid sleep in?  A water bed!"
) else if %randomjoke%==44 (msg * "What kind of crackers do firemen like in their soup?  Firecrackers!"
) else if %randomjoke%==45 (msg * "What did the teddy bear say when he was offered dessert?  No thanks, I'm stuffed!"
) else if %randomjoke%==46 (msg * "Why did the barber win the race?  Because he took a short cut."
) else if %randomjoke%==47 (msg * "What's taken before you get it?  Your picture."
) else if %randomjoke%==48 (msg * "What do you call a midget psychic who just escaped from prison?  A small medium at large."
) else if %randomjoke%==49 (msg * "Why does Humpty Dumpty love autumn?  Because he had a great fall."
) else if %randomjoke%==50 (msg * "What disappears when you stand up?  Your lap."
) else if %randomjoke%==51 (msg * "What did the big firecracker say to the little firecracker?  My pop is bigger than yours."
) else if %randomjoke%==52 (msg * "What do you call a surgeon with eight arms?  A doctopus!"
) else if %randomjoke%==53 (msg * "Why did the teacher jump into the lake?  Because she wanted to test the waters!"
) else if %randomjoke%==54 (msg * "People wonder why I call my toilet "the Jim" instead of "the John. "I do it so I can say "I go to the Jim first thing every morning. ""
) else if %randomjoke%==55 (msg * "I was wondering why the ball kept getting bigger and bigger... And then it hit me."
) else if %randomjoke%==56 (msg * "Money doesn't grow on trees, right? So why does every bank have so many branches?"
) else if %randomjoke%==57 (msg * "Why did the pig leave the party early? Because everyone thought he was a boar."
) else if %randomjoke%==58 (msg * "Why was the pelican kicked out of the hotel?  Because he had a big bill!"
) else if %randomjoke%==59 (msg * "What do cats eat for breakfast?  Mice Crispies!"
) else if %randomjoke%==60 (msg * "What kind of dog tells time?  A watch dog!"
) else if %randomjoke%==61 (msg * "Why can't a leopard hide?  Because he's always spotted!"
) else if %randomjoke%==62 (msg * "What do you give a dog with a fever?  Mustard, its the best thing for a hot dog!"
) else if %randomjoke%==63 (msg * "What do you get when you cross a cat with a lemon?  A sour puss!"
) else if %randomjoke%==64 (msg * "What's the difference between a teacher and a train? One says, "Spit out your gum" and the other says, "Choo choo choo. ""
) else if %randomjoke%==65 (msg * "What did the janitor yell after he jumped out of the closet?"Supplies!""
) else if %randomjoke%==66 (msg * "How can you get four suits for a dollar? Buy a deck of cards."
) else if %randomjoke%==67 (msg * "Why did the boy tiptoe past the medicine cabinet?  He didn't want to wake the sleeping pills!"
) else if %randomjoke%==68 (msg * "How do you tease fruit?  Banananananananana!"
) else if %randomjoke%==69 (msg * "Why did Goofy put a clock under his desk?  Because he wanted to work over-time!"
) else if %randomjoke%==70 (msg * "Why did Tommy throw the clock out of the window?  Because he wanted to see time fly!"
) else if %randomjoke%==71 (msg * "How does a moulded fruit-flavoured dessert answer the phone?  Jell-o!"
) else if %randomjoke%==72 (msg * "When do you stop at green and go at red?  When you're eating a watermelon!"
) else if %randomjoke%==73 (msg * "What's the difference between a cat and a complex sentence? A cat has claws at the end of its paws.  A complex sentence has a pause at the end of its clause."
) else if %randomjoke%==74 (msg * "How do you repair a broken tomato?  Tomato Paste!"
) else if %randomjoke%==75 (msg * "Why did the baby strawberry cry?  Because his parents were in a jam!"
) else if %randomjoke%==76 (msg * "What did the hamburger name his daughter?  Patty!"
) else if %randomjoke%==77 (msg * "What kind of egg did the bad chicken lay?  A deviled egg!"
) else if %randomjoke%==78 (msg * "Where do polar bears vote?  The North Poll"
) else if %randomjoke%==79 (msg * "What did Geronimo say when he jumped out of the airplane?  ME!!!"
) else if %randomjoke%==80 (msg * "Where do snowmen keep their money?  In snow banks."
) else if %randomjoke%==81 (msg * "Why do sea-gulls fly over the sea?  Because if they flew over the bay they would be bagels!"
) else if %randomjoke%==82 (msg * "What dog keeps the best time?  A watch dog."
) else if %randomjoke%==83 (msg * "Why did the tomato turn red?  It saw the salad dressing!"
) else if %randomjoke%==84 (msg * "What kind of key opens the door on Thanksgiving?  A turkey!"
) else if %randomjoke%==85 (msg * "What kind of cake do you get at a cafeteria?  A stomach-cake!"
) else if %randomjoke%==86 (msg * "Why did the cookie go to the hospital?  He felt crummy."
) else if %randomjoke%==87 (msg * "Dad, did you get a haircut? No I got them all cut."
) else if %randomjoke%==88 (msg * "What do you call a Mexican who has lost his car? Carlos."
) else if %randomjoke%==89 (msg * "Dad, can you put my shoes on? No, I don't think they'll fit me."
) else if %randomjoke%==90 (msg * "Can I watch the TV? Dad Yes, but don't turn it on."
) else if %randomjoke%==91 (msg * "I would avoid the sushi if I was you. It's a little fishy."
) else if %randomjoke%==92 (msg * "What do you call a fake noodle? An Impasta."
) else if %randomjoke%==93 (msg * "You know, people say they pick their nose, but I feel like I was just born with mine."
) else if %randomjoke%==94 (msg * ""Every time I hurt myself, even to this day, my dad says, 'The good news is..it'll feel better when it quits hurting.'""
) else if %randomjoke%==95 (msg * "What's brown and sticky? A stick."
) else if %randomjoke%==96 (msg * "Want to hear a joke about paper? Nevermind it's tearable."
) else if %randomjoke%==97 (msg * "Did you hear about the restaurant on the moon? Great food, no atmosphere."
) else if %randomjoke%==98 (msg * ""I'll call you later!"- "Please don't do that. I've always asked you to call me Dad!""
) else if %randomjoke%==99 (msg * "Q Why did the cookie cry? A Because his father was a wafer so long!"
) else if %randomjoke%==100 (msg * "What did the mountain climber name his son? Cliff."
) else if %randomjoke%==101 (msg * "This graveyard looks overcrowded. People must be dying to get in there."
) else if %randomjoke%==102 (msg * ""Whenever the cashier at the grocery store asks my dad if he would like the milk in a bag he replies, 'No, just leave it in the carton!'""
) else if %randomjoke%==103 (msg * "I got so angry the other day when I couldn't find my stress ball."
) else if %randomjoke%==104 (msg * "If I had a dime for every book I've ever read, I'd say "Wow, that's coincidental.""
) else if %randomjoke%==105 (msg * "I'm not indecisive. Unless you want me to be."
) else if %randomjoke%==106 (msg * "How many apples grow on a tree? All of them."
) else if %randomjoke%==107 (msg * "How does a penguin build it's house? Igloos it together."
) else if %randomjoke%==108 (msg * "'Make me a sandwich!''Poof, You're a sandwich!'"
) else if %randomjoke%==109 (msg * "A steak pun is a rare medium well done."
) else if %randomjoke%==110 (msg * ""How can you tell if a ant is a boy or a girl? They're all girls, otherwise they'd be uncles.""
) else if %randomjoke%==111 (msg * "Milk is also the fastest liquid on earth - its pasteurized before you even see it"
) else if %randomjoke%==112 (msg * ""What's Forrest Gump's password? forrest""
) else if %randomjoke%==113 (msg * "The only thing worse than having diarrhea is having to spell it."
) else if %randomjoke%==114 (msg * "I asked my friend to help me with a math problem. He said "Don't worry; this is a piece of cake." I said "No, it's a math problem.""
) else if %randomjoke%==115 (msg * "I keep trying to lose weight, but it keeps finding me."
) else if %randomjoke%==116 (msg * "I don't play soccer because I enjoy the sport. I'm just doing it for kicks."
) else if %randomjoke%==117 (msg * "Did I tell you the time I fell in love during a backflip? I was heels over head."
) else if %randomjoke%==118 (msg * "I used to work in a shoe recycling shop. It was sole destroying."
) else if %randomjoke%==119 (msg * "Why do you never see elephants hiding in trees? Because they're so good at it."
) else if %randomjoke%==120 (msg * "Where did the one-legged waitress work? IHOP!"
) else if %randomjoke%==121 (msg * "What happened when the two antennas got married? Well, the ceremony was kinda boring, but the reception was great!"
) else if %randomjoke%==122 (msg * "What did one snowman say to the other one?  "Do you smell carrots?""
) else if %randomjoke%==123 (msg * "How do you make a tissue dance?  You put a little boogie in it!"
) else if %randomjoke%==124 (msg * "Why did the blonde stare at the orange juice container?  It said concentrate!"
) else if %randomjoke%==125 (msg * "If your nose runs and your feet smell, you are built upside down!"
) else if %randomjoke%==126 (msg * "I went to buy some camouflage trousers the other day, but I couldn't find any."
) else if %randomjoke%==127 (msg * "Q How do you organize an outer space party? A You planet."
) else if %randomjoke%==128 (msg * "Q What do you call a belt with a watch on it? A A waist of time."
) else if %randomjoke%==129 (msg * "What kind of shoes does a thief wear? Sneakers"
) else if %randomjoke%==130 (msg * "A jumper cable walks into a bar. The bartender says, "I'll serve you, but don't start anything.""
) else if %randomjoke%==131 (msg * "An invisible man marries an invisible woman. The kids were nothing to look at either."
) else if %randomjoke%==132 (msg * "I went to a seafood disco last week... and pulled a mussel."
) else if %randomjoke%==133 (msg * "Did you hear about the man who stole a calendar? He got  months."
) else if %randomjoke%==134 (msg * "Do you know where you can get chicken broth in bulk? The stock market."
) else if %randomjoke%==135 (msg * "What did the ocean say to the shore? Nothing, it just waved."
) else if %randomjoke%==136 (msg * "Why do crabs never give to charity? Because they're shellfish."
) else if %randomjoke%==137 (msg * "What do you call an Argentinian with a rubber toe? Roberto"
) else if %randomjoke%==138 (msg * ""What do you call a man with no nose and no body? Nobody nose.""
) else if %randomjoke%==139 (msg * "I cut my finger chopping cheese, but I think that I may have greater problems."
) else if %randomjoke%==140 (msg * "What do you call a fish with no eyes? A fshhhh."
) else if %randomjoke%==141 (msg * ""What do you call a man with no arms and no legs lying in front of your door? Matt.""
) else if %randomjoke%==142 (msg * "My cat was just sick on the carpet, I don't think it's feline well."
) else if %randomjoke%==143 (msg * "I dreamed about drowning in an ocean made out of orange soda last night. It took me a while to work out it was just a Fanta sea."
) else if %randomjoke%==144 (msg * "Without geometry life is pointless."
) else if %randomjoke%==145 (msg * "A termite walks into a bar and asks "Is the bar tender here?""
) else if %randomjoke%==146 (msg * "I gave all my dead batteries away today... Free of charge."
) else if %randomjoke%==147 (msg * "I needed a password eight characters long so I picked Snow White and the Seven Dwarfs."
) else if %randomjoke%==148 (msg * "I am terrified of elevators. I'm going to start taking steps to avoid them."
) else if %randomjoke%==149 (msg * "What's the advantage of living in Switzerland? Well, the flag is a big plus."
) else if %randomjoke%==150 (msg * "Why did the octopus beat the shark in a fight? Because it was well armed."
) else if %randomjoke%==151 (msg * "A red and a blue ship have just collided in the Caribbean. Apparently the survivors are marooned."
) else if %randomjoke%==152 (msg * "Last night my friend and I watched three DVDs back to back. Luckily I was the one facing the TV."
) else if %randomjoke%==153 (msg * "Q What did daddy spider say to baby spider? A You spend too much time on the web."
) else if %randomjoke%==154 (msg * "How much does a hipster weigh? An instagram."
) else if %randomjoke%==155 (msg * "What do you call a group of killer whales playing instruments? An Orca-stra."
) else if %randomjoke%==156 (msg * "Why was the big cat disqualified from the race? Because it was a cheetah."
) else if %randomjoke%==157 (msg * "Bicycles can't stand on their own, they're two tired."
) else if %randomjoke%==158 (msg * "Breaking news! Energizer Bunny arrested - charged with battery"
) else if %randomjoke%==159 (msg * "A Sandwich walks into a bar, the bartender says "Sorry, we don't serve food here""
) else if %randomjoke%==160 (msg * ""Doctor, I've broken my arm in several places" Doctor "Well don't go to those places.""
) else if %randomjoke%==161 (msg * ""Why did the Clydesdale give the pony a glass of water? Because he was a little horse!""
) else if %randomjoke%==162 (msg * "There's a new type of broom out, it's sweeping the nation."
) else if %randomjoke%==163 (msg * "Slept like a log last night ... woke up in the fireplace."
) else if %randomjoke%==164 (msg * ""We were getting fast food when the lady at the window said, 'Any condiments?' My dad responded, 'Compliments? You look very nice today!'""
) else if %randomjoke%==165 (msg * "What cheese can never be yours? Nacho cheese."
) else if %randomjoke%==166 (msg * "A police officer caught two kids playing with a firework and a car battery. He charged one and let the other one off."
) else if %randomjoke%==167 (msg * "I'm reading a book on the history of glue - can't put it down."
) else if %randomjoke%==168 (msg * "What did the daddy tomato say to the baby tomato? A catch up!"
) else if %randomjoke%==169 (msg * "Q What's 0 Cent's name in Zimbabwe? A 00 Million Dollars."
) else if %randomjoke%==170 (msg * "Q What did baby corn say to mama corn? A Where's popcorn?"
) else if %randomjoke%==171 (msg * "What do you call a cow with no legs? Ground beef."
) else if %randomjoke%==172 (msg * "What did the Buffalo say to his little boy when he dropped him off at school? Bison."
) else if %randomjoke%==173 (msg * "So a duck walks into a pharmacy and says "Give me some chap-stick... and put it on my bill""
) else if %randomjoke%==174 (msg * "Why did the scarecrow win an award? Because he was outstanding in his field."
) else if %randomjoke%==175 (msg * "Why did the boy smear peanut butter on the road? To go with the traffic jam."
) else if %randomjoke%==176 (msg * "Why does a chicken coop only have two doors? Because if it had four doors it would be a chicken sedan."
) else if %randomjoke%==177 (msg * "Why don't seagulls fly over the bay? Because then they'd be bay-gulls!"
) else if %randomjoke%==178 (msg * ""Two peanuts were walking down the street. One was a salted.""
) else if %randomjoke%==179 (msg * "How do you make a hankie dance? Put a little boogie in it."
) else if %randomjoke%==180 (msg * "Where does batman go to the bathroom? The batroom."
) else if %randomjoke%==181 (msg * "What's the difference between an African elephant and an Indian elephant? About 1000 miles"
) else if %randomjoke%==182 (msg * "I'm on a seafood diet... I see food and I eat it."
) else if %randomjoke%==183 (msg * "A man walks into a bar and orders helicopter flavor chips. The barman replies "sorry mate we only do plain""
) else if %randomjoke%==184 (msg * "Commissar! Commissar! The troops are revolting! Commissar Well, you're pretty repulsive yourself."
) else if %randomjoke%==185 (msg * "What do you call a sheep with no legs? A cloud."
) else if %randomjoke%==186 (msg * "I knew I shouldn't have ate that seafood. Because now I'm feeling a little... Eel"
) else if %randomjoke%==187 (msg * "What did the 0 say to the 8? Nice belt."
) else if %randomjoke%==188 (msg * "Why are skeletons so calm? Because nothing gets under their skin."
) else if %randomjoke%==189 (msg * "Why don't skeletons ever go trick or treating? Because they have nobody to go with."
) else if %randomjoke%==190 (msg * "Why do scuba divers fall backwards into the water? Because if they fell forwards they'd still be in the boat."
) else if %randomjoke%==191 (msg * "Have you ever heard of a music group called Cellophane? They mostly wrap."
) else if %randomjoke%==192 (msg * "What kind of magic do cows believe in? MOODOO."
) else if %randomjoke%==193 (msg * "Why does Superman gets invited to dinners? Because he is a Supperhero."
) else if %randomjoke%==194 (msg * ""Hold on, I have something in my shoe"  "I'm pretty sure it's a foot""
) else if %randomjoke%==195 (msg * "Dad I'm hungry ... "Hi hungry" I'm dad"
) else if %randomjoke%==196 (msg * "When phone ringing Dad says 'If it's for me don't answer it."
) else if %randomjoke%==197 (msg * "Where's the bin? Dad I haven't been anywhere.") else (goto jokegen)


goto:eof