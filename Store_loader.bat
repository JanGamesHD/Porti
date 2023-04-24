@echo off
echo Tauser Store loader
echo made by JanGames and FBW81C
echo Current CD: %cd%
cd \
echo Current CD: %cd%
echo System Drive: %systemdrive%
set oldsystemdrive=%systemdrive%
set systemdrive=%cd:\=%
set systemdrive=%systemdrive%\Porti\Store
md %systemdrive%
echo Changed System Drive from %oldsystemdrive% to %systemdrive%
echo Loading Tauser Store...
set useporti=1
call %cd%\PORTI\Store.bat
