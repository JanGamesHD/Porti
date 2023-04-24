@echo off
echo Checking for Updates ...
if not exist \Porti\Updater\ md \Porti\Updater\
del \Porti\Updater\remoteversion.sys /Q /F
\Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/version.sys -O\Porti\Updater\remoteversion.sys
type NUL>\Porti\Updater\empty.sys
fc \Porti\Updater\empty.sys \Porti\Updater\remoteversion.sys
if %errorlevel%==0 exit
fc \Porti\Updater\remoteversion.sys \Porti\Updater\localversion.sys
if %errorlevel%==0 exit
\Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/changelog.sys -O\Porti\Updater\changelog.sys
exit