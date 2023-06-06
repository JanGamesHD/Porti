@echo off
echo Tauser Store loader
echo made by JanGames and FBW81C
echo Current CD: %cd%
rem cd \
echo Current CD: %cd%
echo System Drive: %systemdrive%
rem set oldsystemdrive=%systemdrive%
rem set systemdrive=%cd:\=%
set systemdrive=Porti\Store
md %systemdrive%
echo Changed System Drive from %oldsystemdrive% to %systemdrive%
echo Loading Tauser Store...
set useporti=1
if not exist PORTI\Store.bat goto 2
call PORTI\Store.bat
set error=%errorlevel%
goto aftercall
exit
:2
call Store.bat
set error=%errorlevel%
:aftercall
echo Tause Store exited with error code %error%.
pause
exit
