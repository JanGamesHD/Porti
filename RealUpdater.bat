@echo off
echo Downloading Porti ...
\Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/Porti.bat -O\Porti\Updater\NewPorti.bat
echo Checking ....
find /i "@echo off" "\Porti\Updater\NewPorti.bat" >NUL
if not %errorlevel%==0 goto downloaderror
cls
echo Installing ...
copy \Porti\Updater\NewPorti.bat \Porti.bat
cd \
start \Porti.bat
exit