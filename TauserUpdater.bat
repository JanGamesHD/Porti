@echo off
if not exist Porti\TauserUpdater md Porti\TauserUpdater
set newuserprofile=Porti\Store\User
echo Tauser Store Application Updater
echo Technical Details for Support
echo CD: %cd%
echo ACD: %acd%
echo CURCD: %curcd%
echo PORTIWORKDIR: %portiworkdir%
echo BANANAMODE: %bananamode%
echo NewUserProfile: %newuserprofile%
if exist Porti\Applications goto checkforupdates
echo Unable to find folder: Porti\Applications in %cd%
echo Make sure to launch this script from Porti directly or from the Porti.bat directory.
pause
exit

:checkforupdates
echo Checking Porti Applications list...
set cur=0
:check
set /a cur=%cur%+1
if exist Porti\Applications\%cur%\AppID.tauserstore goto loadandcheck
if not exist Porti\Applications\%cur%\ goto donewithlist
set curappname=UNKNOWN
set /p curappname=<Porti\Applications\%cur%\name.sys
echo Application %cur% with name %curappname% is not an Tauser Store Application. Skipping...
goto check

:loadandcheck
set /p appid=<Porti\Applications\%cur%\AppID.tauserstore
set curappname=UNKNOWN
set /p curappname=<Porti\Applications\%cur%\name.sys
set /p curappver=<Porti\Applications\%cur%\version.tauserstore
echo Checking for Updates: %curappname% (%appid%) Ver: %curappver% Local App ID: %cur%
rem echo App ID would be 1/7
Porti\wget.exe https://raw.githubusercontent.com/FBW81C/TauserStore/main/%appid%/version.sys -O Porti\TauserUpdater\%cur%.sys -q
type NUL>Porti\empty.sys
fc Porti\TauserUpdater\%cur%.sys Porti\empty.sys >NUL
if %errorlevel%==0 goto unabletogetremoteversion
set remver=%curappver%
set /p remver=<Porti\TauserUpdater\%cur%.sys
if not %curappver%==%remver% goto updatefound
echo Application "%curappname%" is on the latest version.
goto check

:unabletogetremoteversion
echo Unable to get remote Version of Application "%curappname%" with local version %curappver% with Tauser Store ID: %appid%
echo Local Installation ID: %cur%
echo Press any key to continue or wait 5 seconds. 
timeout 5 >NUL
goto check

:updatefound
echo Update found: "%curappname%" LV: %curappver% RV: %remver%
if defined updateall goto doupdate
echo Available Options: (y=YES, s=SKIP, a=ALL)
set /p uptopt=Do you want to update "%curappname%" ? 
if %uptopt%==y goto doupdate
if %uptopt%==s goto check
if %uptopt%==a goto updateall
goto updatefound

:updateall
set updateall=1
goto doupdate

:doupdate
if exist Porti\TauserUpdater\%cur%.uplink del Porti\TauserUpdater\%cur%.uplink /Q /F
echo Downloading Update information: "%curappname%
Porti\wget.exe https://raw.githubusercontent.com/FBW81C/TauserStore/main/%appid%/updateloc.sys -O Porti\TauserUpdater\%cur%.uplink -q
fc Porti\TauserUpdater\%cur%.uplink Porti\empty.sys >NUL
if %errorlevel%==0 goto unabletodownloadupdateinfo
set /p updatelink=<Porti\TauserUpdater\%cur%.uplink
:redownloadupdate
if exist Porti\TauserUpdater\%cur%-Updater.bat del Porti\TauserUpdater\%cur%-Updater.bat /Q /F
echo Downloading Update: "%curappname%" from "%updatelink%"
Porti\wget %updatelink% -O Porti\TauserUpdater\%cur%-Updater.bat
fc Porti\TauserUpdater\%cur%-Updater.bat Porti\empty.sys >NUL
if %errorlevel%==0 goto unabletodownloadupdate
echo Updating "%curappname%" from Version %curappver% to %remver% using Update-Script: Porti\TauserUpdater\%cur%-Updater.bat
echo Downloaded from: %updatelink%
set updatecompleted=27
set useporti=1
call Porti\TauserUpdater\%cur%-Updater.bat
if %updatecompleted%==27 goto noreturncode
if %updatecompleted%==1 goto updatesuccessful
if %updatecompleted%==0 goto updatefailed
:unknownreturn
echo Unknown Update Return Code reveived: %updatecompleted%
echo p=PROCEED, d=DEBUG INFO, c=CANCEL UPDATER
set /p proopt=Do you want to proceed? (p/d/c) 
if %proopt%==p goto check
if %proopt%==d goto debug
if %proopt%==c exit
goto unknownreturn

:debug
echo -------------------------------------------------------------
echo.
echo Debug Information
set
echo.
echo Debug Information
echo -------------------------------------------------------------
echo 1) Continue with Updates
echo 2) Cancel
set /p opt=Opt: 
if %opt%==1 goto check
if %opt%==2 exit
goto debug

:donewithlist
echo Done!
pause
exit

:noreturncode
echo Update script did not notify if update was successful.
echo Proceeding in 5 seconds
timeout 5
goto check

:updatesuccessful
echo Update has been installed successfully.
goto check

:updatefailed
echo Update failed.
set
echo Proceeding in 10 seconds
timeout 10
goto check

:unabletodownloadupdateinfo
cls
echo Unable to download Update information.
echo 1) Try again
echo 2) Skip
echo 3) Cancel
set /p opt=Opt: 
if %opt%==1 goto doupdate
if %opt%==2 goto check
if %opt%==3 exit
goto unabletodownloadupdateinfo

:unabletodownloadupdate
cls
echo Unable to download Update
echo 1) Try again
echo 2) Skip
echo 3) Cancel
set /p opt=Opt: 
if %opt%==1 goto redownloadupdate
if %opt%==2 goto check
if %opt%==3 exit
goto unabletodownloadupdate