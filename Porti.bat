@echo off
set version=1.6
rem if exist \Porti\Porti.bat goto loadporti
:boot
:boot
if not "%cd%"=="%cd: =%" goto spacewarning
echo Github: https://github.com/JanGamesHD/Porti
echo Welcome to Porti!
echo Init... Please wait!
:reload
:reload
title Porti: Loading...
set curcd=%cd%
cd \
set acd=%cd%
cd "%curcd%"
set bananamode=0
if "%cd%"=="%acd%" set bananamode=1
if %bananamode%==0 if exist wget.exe set portiworkdir=%cd%
if %bananamode%==0 if exist Porti\wget.exe set portiworkdir=%cd%\Porti
if %bananamode%==1 if exist wget.exe set portiworkdir=%cd%
if %bananamode%==1 set cd=%cd:\=%
if %bananamode%==1 set curcd=%cd::\=:%
if %bananamode%==1 set acd=%cd::\=:%
if %bananamode%==1 if exist Porti\wget.exe set portiworkdir=%cd%\Porti
cls
echo ROOT-MODE: %bananamode%
if %bananamode%==1 (
echo NOTE: Porti is in the root folder.
echo Porti automatically removed the \ from %cd%, to increase compatibility with programs, which use ^%cd^%\
echo Otherwise Programs would be looking for ^%cd^%\\ instead of ^%cd^%\ because the CD Variable includes a backslash if you are in the root folder.
)
echo Welcome to Porti!
echo Version %version%
if not exist Porti md Porti
if not exist Porti\Applications md Porti\Applications
if not exist Porti\setupcomplete.sys goto setup
goto continue1

:setup
title Porti: Setup
cls
echo Welcome to Porti
echo Your Porti Installation path is: %cd%
echo If you want to change the installation path, move the Porti.bat file to the right location.
echo Please note that Porti uses the 3rd party software wget to download files.
echo Porti is licensed under the MIT license, however
echo WGET is licensed under the GNU GENERAL PUBLIC LICENSE
echo By proceeding, you agree to the licenses.
echo GPL: https://www.gnu.org/licenses/gpl-3.0.txt (will automatically be downloaded into the Porti working directory)
echo Do you want to continue with the installation? (y/n)
set /p opt=Opt: 
if %opt%==y goto install
if %opt%==n exit
goto setup

:install
cls
echo Downloading WGET from https://eternallybored.org/misc/wget/1.19.4/32/wget.exe using Powershell
echo Note: Since Powershell is showing the progress bar, this download might take longer.
powershell Invoke-WebRequest https://eternallybored.org/misc/wget/1.19.4/32/wget.exe -OutFile %cd%\Porti\wget.exe
:recheckhashwget
echo Generating MD5 Hash...
certutil -hashfile Porti\wget.exe MD5 | findstr /V ":" >Porti\wgethash.sys
set /p wgethash=<Porti\wgethash.sys
echo %wgethash: =%>Porti\wgethash.sys
echo Writing Original Hash to file...
echo 3dadb6e2ece9c4b3e1e322e617658b60>Porti\wgethash.org
fc Porti\wgethash.sys Porti\wgethash.org
if %errorlevel%==0 goto everythingfine
set /p wgethash23=<Porti\wgethash.sys
if 3dadb6e2ece9c4b3e1e322e617658b60==%wgethash23% goto everythingfine
echo MD5-Hash verification failed!
if not defined didbitsdownload goto askdownloader
set /p remotehash=<Porti\wgethash.sys
echo Expected Hash: 3dadb6e2ece9c4b3e1e322e617658b60
echo Returned Hash: %remotehash%
:ask1
echo Do you want to ignore and continue? (y/n)
set /p opt=Opt: 
if %opt%==y goto everythingfine
if %opt%==n goto setup
goto ask1

:everythingfine
title Porti: WGET Download Done!
cls
echo WGET has been downloaded.
echo Downloading the following files:
echo 1. Tauser Store
echo 2. Tauser Store patcher
echo 3. Porti Updater
echo 4. Tauser Store Updater
echo 5. GNU GENERAL PUBLIC LICENSE
echo 6. unzip.exe
cls
title Porti: Downloading... (1/6)
echo Downloading Tauser Store... (1/6)
Porti\wget.exe https://raw.githubusercontent.com/FBW81C/TauserStore/main/Store.bat -O Porti\Store.bat -q
title Porti: Downloading... (2/6)
echo Downloading Tauser Store loader... (2/6)
Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/Store_loader.bat -O Porti\Store_loader.bat -q
title Porti: Downloading... (3/6)
echo Downloading Porti Updater... (3/6)
Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/Updater.bat -O Porti\Updater.bat -q
title Porti: Downloading... (4/6)
echo Downloading Tauser Application Updater... (4/6)
Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/TauserUpdater.bat -O Porti\TauserUpdater.bat -q
echo Downloading wget license... (5/6)
Porti\wget.exe https://www.gnu.org/licenses/gpl-3.0.txt -O Porti\wget_license.txt -q
:unzipdownload
echo Downloading unzip... (6/6)
title Porti: Downloading... (6/6)
Porti\wget.exe http://stahlworks.com/dev/unzip.exe -O Porti\unzip.exe -q
echo Verifying hash...
set comp=75375c22c72f1beb76bea39c22a1ed68
certutil -hashfile Porti\unzip.exe MD5 | findstr /V ":" >Porti\unziplocalhash.sys
set /p unziphash=<Porti\unziplocalhash.sys
set unziphash=%unziphash: =%
if not %unziphash%==%comp% goto unziphashfailed
:setupcompt
echo Done!
:setupcomplete
cls
echo The setup is now completed.
echo You can now use Porti.
echo.
echo Porti will ask you if you want to check for updates regularly
echo You can also check for updates manually in the Settings page.
echo.
echo You can use the Tauser Store to Download Applications, or add applications manually using the option in the Applications menu.
echo Have fun exploring and using Porti!
echo.
echo Press any key to start using Porti!
pause >NUL
:comepletsetup
cls
echo Completing setup... Please wait!
echo a>Porti\setupcomplete.sys
goto reload

:continue1
:continue1
cls
echo Checking Update information...
if not exist Porti\updatetimer.sys goto setupdatetimer
set /p updatetimer=<Porti\updatetimer.sys
set /a updatetimer=%updatetimer%-1
if %updatetimer%==0 goto askifcheck4updates
cls
echo Writing update information...
echo %updatetimer% >Porti\updatetimer.sys
cls
echo Checking for missing files...
if not defined dontcheck if not exist Porti\TauserUpdater.bat goto missingfiles
if not defined dontcheck if not exist Porti\Store.bat goto missingfiles
if not defined dontcheck if not exist Porti\Store_loader.bat goto missingfiles
if not defined dontcheck if not exist Porti\Updater.bat goto missingfiles
if not defined dontcheck if not exist Porti\wget_license.txt goto missingfiles
:menu
:menu
color e0
cls
if not exist Porti\portitext.sys goto getportitext
type Porti\portitext.sys
type NUL
type NUL
echo.
title Porti: Main Menu
echo 1) My Applications
echo 2) Tauser Store (Application Store)
echo 3) Settings
echo 4) Exit
set /p opt=Opt: 
if %opt%==1 goto myapps
if %opt%==2 goto tauserstore
if %opt%==3 goto settings
if %opt%==4 exit
echo The selected option "%opt%" was not found.
pause
goto menu

:myapps
:myapps
title Porti: In Progress...
cls
echo --- Application List ---
set counter=1
:conlisting
:conlisting
if not exist Porti\Applications\%counter%\name.sys if exist Porti\Applications\%counter%\ goto brokenappfound
if not exist Porti\Applications\%counter%\name.sys goto donelisting
set /p applicationname=<Porti\Applications\%counter%\name.sys
echo %counter%. %applicationname%
set applicationname=?????????
set /a counter=%counter%+1
goto conlisting

:donelisting
:donelisting
title Porti: Applications
echo --- Application List ---
echo ..) Back to Main Menu
echo a) Install an external Zip Package
echo Type the Application number and hit Enter to continue.
set /p app=Opt: 
if %app%==a goto installzip
if %app%==.. goto menu
:loadapplication
:loadapplication
echo Loading Details ... please wait!
if not exist Porti\Applications\%app%\name.sys goto applicationnotfound
set /p applicationname=<Porti\Applications\%app%\name.sys
cls
title Porti: Manage %applicationname% (%app%)
echo 1) Start %applicationname%
echo 2) More details
echo 3) Uninstall %applicationname%
echo 4) Back...
set /p opt=Opt: 
if %opt%==1 goto launchapp
if %opt%==2 goto moredetails
if %opt%==3 goto uninstall
if %opt%==4 goto myapps
goto loadapplication


:launchapp
:launchapp
echo Loading exec...
set appdir=Porti\Applications\%app%
set /p exec=<Porti\Applications\%app%\exec.sys
start cmd /c "%exec%"
goto menu

:moredetails
:moredetails
cls
set appdir=Porti\Applications\%app%
set /p exec=<Porti\Applications\%app%\exec.sys
echo App-Dir: %appdir%
echo Exec: %exec%
echo App: %app%
echo Application Name: %applicationname%
if exist Porti\Applications\%app%\version.tauserstore set /p tauserver=<Porti\Applications\%app%\version.tauserstore
if exist Porti\Applications\%app%\appid.tauserstore set /p tauserappid=<Porti\Applications\%app%\appid.tauserstore
if exist Porti\Applications\%app%\version.tauserstore (
echo TS-Version: %tauserver%
echo TS-ID: %tauserappid%
echo If you want to check for Updates:
echo Porti Main Menu --^> Settings --^> Check for Tauser-Application Updates
)
pause
goto loadapplication

:uninstall
:uninstall
cls
echo Are you sure you want to uninstall %applicationname%? (y/n)
set /p opt=Opt: 
if %opt%==y goto confirmuninstall
if %opt%==n goto loadapplication
goto uninstall

:confirmuninstall
:confirmuninstall
cls
echo %time%: Started uninstallation for %applicationname%...
echo %time%: Deleting files in Porti\Applications\%app%\ ...
del Porti\Applications\%app%\* /Q /S /F
echo %time%: Removing directorys ...
rd Porti\Applications\%app% /Q /S
echo %time%: Removed %applicationname% from "My Applications"
echo Defragmenting list... This might take a while depending on how much Applications you have installed.
echo Current Application ID: %app%
set curapp=%app%
set curapp2=%app%
:moveloop
:moveloop
set curapp2=%curapp%
set /a curapp=%curapp%+1
if not exist Porti\Applications\%curapp% goto movedone
if exist Porti\Applications\%curapp% ren Porti\Applications\%curapp% %curapp2%
echo Moved Application with ID %curapp% to %curapp2%
goto moveloop
:movedone
:movedone
echo Complete!
paue
goto menu

:tauserstore
:tauserstore
cls
start Porti\Store_loader.bat
goto menu

:applicationnotfound
:applicationnotfound
cls
echo The selected application does not exist or contains no name information.
pause
goto menu

:settings
:settings
title Porti: Settings
cls
echo Welcome to Porti-Settings!
echo.
echo 1) Check for Porti-Updates
echo 2) Check for Tauser-Application Updates
echo 3) Reset Porti Data
echo 4) Porti Info
echo 5) go back ...
echo.
set /p opt=Opt: 
if %opt%==1 goto check4updates
if %opt%==2 goto tauserappupdates
if %opt%==3 goto reset
if %opt%==4 goto portisysinfo
if %opt%==5 goto menu
goto settings

:reset
cls
echo -- Porti Data Resetter --
echo 1) Restart Porti Setup
echo 2) Wipe Porti Dependencies
echo 3) Delete All Applications
echo 4) Wipe Porti System Data
echo 5) Return to Settings
set /p opt=Opt: 
if %opt%==1 goto resetupnote
if %opt%==2 goto depenreset
if %opt%==3 goto applicationreset
if %opt%==4 goto completeresetter
if %opt%==5 goto settings
echo No valid option has been specified.
pause
goto reset

:resetupnote
cls
echo Are you sure you want to Restart Porti Setup?
echo The Setup will re-download dependencies, this will not delete any user data or application
echo Do you want to continue? (y/n)
set /p opt=Opt: 
if %opt%==y goto setup
if %opt%==n goto reset
goto resetupnote

:depenreset
cls
echo WARNING: THIS WILL DELETE FILES IN %cd%\Porti
echo SUB-FOLDERS WILL NOT BE DELETED!
echo Do you want to continue? (y/n)
set /p opt=Opt: 
if %opt%==y goto depenresetconfirmed
if %opt%==n goto reset
goto depenreset

:applicationreset
cls
echo WARNING: EVERYTHING IN %cd%\Porti\Applications WILL BE DELETED!
echo THIS WILL NOT DELETE THE JAVA JDK FROM PORTI, YOU NEED TO DELETE IT MANUALLY FROM %cd%\Porti\Java
echo Are you sure you want to continue anyway? (y/n)
set /p opt=Opt: 
if %opt%==y goto appresetconfirmed
if %opt%==n goto reset
goto applicationreset

:depenresetconfirmed
:depenresetconfirmed
cls
echo Deleting... Please wait!
del %cd%\Porti\* /Q /F
goto restart2apply

:applicationreset
:applicationreset
cls
echo Deleting Applications... Please wait!
del %cd%\Porti\Applications\* /Q /S /F
echo Deleting Folders...
rd %cd%\Porti\Applications /Q /S
goto restart2apply

:completeresetter
:completeresetter
cls
echo WARNING: THIS WILLL COMPLETLY RESET PORTI!
echo EVERYTHING IN %cd%\Porti WILL BE DELETED!
echo Are you sure you want to to this? (y/n)
set /p opt=Opt: 
if %opt%==y goto resetconfirmed
if %opt%==n goto settings

:resetconfirmed
:resetconfirmed
cls
echo Deleting...
del "%cd%\Porti\*" /Q /S /F
rd "%cd%\Porti" /Q /S
echo Done!
goto restart2apply

:check4updates
echo 14 >Porti\updatetimer.sys
start cmd /c "Porti\Updater.bat"
exit

:installzip
title Porti: ZIP Installer
cls
echo Here you can install a 3rd party zip file.
echo Please drag and Drop the ZIP file in this CMD window.
set /p file=File: 


if not exist %file% goto notfoundfileforinstall
echo Searching for an empty Application space...
set current=0
:searchappspace
:searchappspace
set /a current=%current%+1
if not exist Porti\Applications\%current% goto foundemptyspace
goto searchappspace

:foundemptyspace
:foundemptyspace
cls
echo Found empty application space: %current%
echo Extracting ZIP Package ...
if exist "%portiworkdir%\unzip.exe" goto useunzipforadd
powershell Expand-Archive %file% -DestinationPath "%portiworkdir%\Applications\%current%"
:afterzipunzip
echo Looking for required files...
if not exist "%portiworkdir%\Applications\%current%\exec.sys" goto notfoundadd
if not exist "%portiworkdir%\Applications\%current%\name.sys" goto notfoundadd
cls
echo All required files found.
echo Application has been added.
echo Press any key to return to the Porti Main Menu.
pause >NUL
goto menu

:notfoundadd
:notfoundadd
rem cls
echo Unable to locate files.
echo Required files are:
echo - "%portiworkdir%\Applications\%current%\exec.sys"
echo - "%portiworkdir%\Applications\%current%\name.sys"
echo Please select an option.
echo 1) Ignore
echo 2) Delete application
set /p opt=Opt. 
if %opt%==1 goto menu
if %opt%==2 goto deloldapp
goto notfoundadd

:deloldapp
:deloldapp
echo Removing Application...
del "%portiworkdir%\Applications\%current%\*" /Q /S /F
rd "%portiworkdir%\Applications\%current%" /Q /S
echo Removed application.
pause
goto menu

:setupdatetimer

:setupdatetimer
:resetupdater
echo 14 >Porti\updatetimer.sys
goto continue1

:askifcheck4updates
:askifcheck4updates
title Porti: Check for Updates
cls
echo You did not check for updates in some time.
echo Do you want to check for Updates? (y/n)
set /p opt=Opt: 
if %opt%==y goto check4updates
if %opt%==n goto setupdatetimer
goto askifcheck4updates

:getportitext
:getportitext
title Porti: Downloading Porti Text
cls
echo Downloading Porti Text...
Porti\wget https://raw.githubusercontent.com/JanGamesHD/Porti/main/portitext.sys -O Porti\portitext.sys -q
goto menu

:notinstallfound
:zipfilenotfound
:notfoundfileforinstall
:notfoundfileforinstall
:zipfilenotfound
:notinstallfound
cls
echo Unable to find file: %file%
echo Please use drag and Drop to make sure the right path has been entered.
echo You can also type the path, but make sure to add quotation marks at the start and end when entering
echo a path which includes spaces.
pause
goto menu

:spacewarning
:spacewarning
cls
echo Porti is installed in a directory which contains spaces.
echo Please move Porti into a different location which does not contain any spaces.
echo Current Porti Location: %cd%
echo We can automatically install Porti in \Porti
echo Do you want to install Porti in \Porti? (y/n)
set /p opt=Opt: 
if %opt%==y goto installinroot
if %opt%==n exit
goto spacewarning

:installinroot
:installinroot
md \Porti
copy "%~f0" \Porti\Porti.bat
if not exist \Porti\Porti.bat goto error1
goto rootinstallcompleted

:loadporti
:loadporti
cd \Porti
call Porti.bat
exit

:unziphashfailed
:unziphashfailed
echo Error: Unable to verify hash from unzip.exe
echo Got: %unziphash%
echo Expected: %comp%
echo Do you want to proceed anyway? (y/n)
echo Note: n will re-download unzip.exe and reperforms the Hash-Check
set /p opt=Opt: 
if %opt%==y goto setupcompt
if %opt%==n goto unzipdownload
goto unziphashfailed


:askdownloader
:askdownloader
cls
echo Unable to download WGET using Powershell!
echo trying to download with bitsadmin (this will take ages btw)
timeout 2 >NUL
bitsadmin /transfer "WGET-Download" /PRIORITY HIGH "http://web.flamegames.de/wget.exe" "%cd%\Porti\wget.exe"
set didbitsdownload=1
goto recheckhashwget

:tauserappupdates
:tauserappupdates
echo CD: %cd%
start Porti\TauserUpdater.bat
goto menu

:missingfiles
:missingfiles
cls
echo Files missing!
echo Some Porti files are missing.
echo Note: This is normal if you´ve just installed an Update for Porti
echo Please select 1 to re-enter Setup to re-download the missing files.
echo Your data will not be deleted.
echo 1) Setup
echo 2) Continue anyway
echo 3) Exit
set /p opt=Opt: 
if %opt%==1 goto setup
if %opt%==2 goto setnochecksession
if %opt%==3 exit
goto missingfiles

:setnochecksession
:setnochecksession
set dontcheck=1
goto menu

:rootinstallcompleted
:rootinstallcompleted
cls
echo Porti is now installed in \Porti
echo From now on you need to start Porti from \Porti\Porti.bat
explorer \Porti
pause
exit

:error1
:error1
cls
echo Unable to install Porti in \Porti
echo Move the Porti.bat file to a different location without spaces and then try again.
pause
exit

:useunzipforadd
:useunzipforadd
echo Preparation In Progress...
echo CURRENT CD: %cd%
echo WORKDIR: %portiworkdir%
echo CURRENT: %current%
md "%portiworkdir%\Applications\%current%"
rem powershell Expand-Archive %file% -DestinationPath "%portiworkdir%\Applications\%current%"
md PortiTemp
cd PortiTemp
"%portiworkdir%\unzip.exe" %file%
echo Installation In Progress... (Moving Directories)
for /D %%a in (*) do move %%a "%portiworkdir%\Applications\%current%\"
echo Installation In Progress... (Moving Files)
move * "%portiworkdir%\Applications\%current%\"
echo Removing Directory...
cd ..
rd PortiTemp /Q /S
goto afterzipunzip

:portisysinfo
cls
echo -- Porti System Info --
echo This information can be useful for Debugging or application development.
echo Please note that this Information can contain personal information.
echo Do you want to continue? (y/n)
set /p opt=Opt: 
if %opt%==y goto sysinfo
if %opt%==n goto settings
goto portisysinfo

:sysinfo
cls
echo -- Porti System Information --
echo.
set
echo.
echo Press any key to return to the settings page.
pause >NUL
goto settings

:restart2apply
cls
echo You need to restart Porti to apply changes.
echo You may now close Porti and re-open it.
:loop
pause >NUL
goto loop

:brokenappfound
:brokenappfound
echo.
echo Application %counter% is broken!
echo UNKNOWN APPLICATION >Porti\Applications\%counter%\name.sys
if not exist Porti\Applications\%counter%\exec.sys goto noexec
goto conlisting

:noexec
echo Application does not have executable information.
echo Creating Dummy exec...
echo @echo off>Porti\Applications\%counter%\exec.bat
echo echo This Application does not contain any valid Porti Information Data>>Porti\Applications\%counter%\exec.bat
echo echo You may delete this Application, but make sure to check the contents of the application folder.>>Porti\Applications\%counter%\exec.bat
echo pause>>Porti\Applications\%counter%\exec.bat
echo exit>>Porti\Applications\%counter%\exec.bat
echo Porti\Applications\%counter%\exec.bat>Porti\Applications\%counter%\exec.sys
goto conlisting