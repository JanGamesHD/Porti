@echo off
if exist Porti\porti.update del Porti\porti.update /Q /F
if exist Porti\localporti.sys del Porti\localporti.sys /Q /F
if exist Porti\remotehash.porti del Porti\remotehash.porti /Q /F
if exist Porti\update.hash del Porti\update.hash /Q /F
echo Current Directory: %cd%
if not exist Porti\ goto portinotfound
echo Welcome to Porti Updater
rem echo Press any key to search for Updates.
rem pause >NUl
echo Generating Hash: Porti.bat
certutil -hashfile Porti.bat MD5 | findstr /V ":" >Porti\localporti.sys
set /p localporti=<Porti\localporti.sys
echo %localporti: =%>Porti\localporti.sys
echo Downloading remote Hash...
goto downloadremotehash

:portinotfound
echo Unable to find Porti directory.
echo Unable to find: Porti\
pause
exit

:downloadremotehash
Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/portihash.sys -O Porti\remotehash.porti --no-cache
echo Loading values (hashes) into memory...
set /p localversion=<Porti\localporti.sys
set /p remoteversion=<Porti\remotehash.porti
if %localversion%==%remoteversion% goto latest
goto updatefound

:latest
cls
echo You are on the latest version.
pause
:launch
start cmd /c Porti.bat
exit

:updatefound
cls
echo An update has been found.
echo Local Hash: %localversion%
echo Remote Hash: %remoteversion%
echo Do you want to update? (y/n)
set /p opt=Opt: 
if %opt%==y goto getupdate
if %opt%==n goto launch
goto updatefound

:getupdate
cls
echo Downloading Porti ...
Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/Porti.bat -O Porti\Porti.update --no-cache
echo Getting Hash...
certutil -hashfile Porti\Porti.update MD5 | findstr /V ":" >Porti\update.hash
set /p updatehash=<Porti\update.hash
echo %updatehash: =%>Porti\update.hash
echo Loading Hash into memory...
set /p updatehash=<Porti\update.hash
echo Local Hash: %localversion%
echo Remote Version: %remoteversion%
echo Remote Local Hash (Update Hash): %updatehash%
if %updatehash%==%remoteversion% goto installupdate
echo Update Hash does not match Remote Hash.
echo Assuming that the download is corrupt.
echo Do you want to install anyway? (y/n)
set /p opt=Opt: 
if %opt%==y goto installupdate
if %opt%==n goto launch
gozo getupdate

:installupdate
cls
echo Creating Backup ...
copy Porti.bat Porti\Porti.%localversion%
echo Installing update ...
copy Porti\Porti.update Porti.bat
echo Update Done!
pause
goto launch
