@echo off
if exist \Porti\Porti.bat goto loadporti
:boot
if not "%cd%"=="%cd: =%" goto spacewarning
echo Github: https://github.com/JanGamesHD/Porti
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
if %bananamode%==1 if exist Porti\wget.exe set portiworkdir=%cd%Porti
if %bananamode%==1 set curcd=%cd::\=:%
if %bananamode%==1 set acd=%cd::\=:%
echo bananamode: %bananamode%
echo Welcome to Porti!
echo Version 1.3
if not exist Porti md Porti
if not exist Porti\Applications md Porti\Applications
if not exist Porti\setupcomplete.sys goto setup
goto continue1

:setup
title Porti: Setup
cls
echo Welcome to Porti
echo Your Porti Installation path is: %cd%
echo If you want to change the installation path, move the Porti.bat file to the right locaiton.
echo Please note that Porti uses the 3rd party software wget to download files.
echo Do you want to continue installation? (y/n)
set /p opt=Opt: 
if %opt%==y goto install
if %opt%==n exit
goto setup

:install
cls
echo Downloading WGET from https://eternallybored.org/misc/wget/1.19.4/32/wget.exe using Powershell
echo Note: Since Powershell is showing the progress bar, this download might take longer.
powershell Invoke-WebRequest https://eternallybored.org/misc/wget/1.19.4/32/wget.exe -OutFile %cd%\Porti\wget.exe
echo Generating MD5 Hash...
certutil -hashfile Porti\wget.exe MD5 | findstr /V ":" >Porti\wgethash.sys
echo Writing Original Hash to file...
echo 3dadb6e2ece9c4b3e1e322e617658b60>Porti\wgethash.org
fc Porti\wgethash.sys Porti\wgethash.org
if %errorlevel%==0 goto everythingfine
echo MD5-Hash verification failed!
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
echo WGET has been downloaded correctly.
pause
cls
echo We will now download the following:
echo 1. Tauser Store
echo 2. Tauser Store patcher
echo 3. Porti Updater
pause
cls
title Porti: Downloading... (1/3)
echo Downloading... (1/3)
Porti\wget.exe https://raw.githubusercontent.com/FBW81C/TauserStore/main/Store.bat -O Porti\Store.bat
title Porti: Downloading... (2/3)
echo Downloading... (2/3)
Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/Store_loader.bat -O Porti\Store_loader.bat
title Porti: Downloading... (3/3)
echo Downloading.... (3/3)
Porti\wget.exe https://raw.githubusercontent.com/JanGamesHD/Porti/main/Updater.bat -O Porti\Updater.bat
echo Done!
pause
:setupcomplete
cls
echo The setup is now completed.
echo You can now use Porti.
echo You can check for Updates in Porti Settings
echo We will add automatic update checks in the future.
pause
:comepletsetup
cls
echo Completing setup... Please wait!
echo a>Porti\setupcomplete.sys
goto reload

:continue1
if not exist Porti\updatetimer.sys goto setupdatetimer
set /p updatetimer=<Porti\updatetimer.sys
set /a updatetimer=%updatetimer%-1
if %updatetimer%==0 goto askifcheck4updates
echo %updatetimer% >Porti\updatetimer.sys
:menu
color e0
cls
if not exist Porti\portitext.sys goto getportitext
type Porti\portitext.sys
type NUL
type NUL
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
title Porti: In Progress...
cls
echo --- Application List ---
set counter=1
:conlisting
if not exist Porti\Applications\%counter%\name.sys goto donelisting
set /p applicationname=<Porti\Applications\%counter%\name.sys
echo %counter%. %applicationname%
set applicationname=?????????
set /a counter=%counter%+1
goto conlisting

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
if %opt%==4 goto menu
goto loadapplication


:launchapp
echo Loading exec...
set appdir=Porti\Applications\%app%
set /p exec=<Porti\Applications\%app%\exec.sys
start cmd /c "%exec%"
goto menu

:moredetails
cls
echo Coming soon or never. i dont care O__O
pause
goto loadapplocation

:uninstall
cls
echo Are you sure you want to uninstall %applicationname%? (y/n)
set /p opt=Opt: 
if %opt%==y goto confirmuninstall
if %opt%==n goto loadapplication
goto uninstall

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
set curapp2=%curapp%
set /a curapp=%curapp%+1
if not exist Porti\Applications\%curapp% goto movedone
if exist Porti\Applications\%curapp% ren Porti\Applications\%curapp% %curapp2%
echo Moved Application with ID %curapp% to %curapp2%
goto moveloop
:movedone
echo Complete!
paue
goto menu

:tauserstore
cls
start Porti\Store_loader.bat
goto menu

:applicationnotfound
cls
echo The selected application does not exist or contains no name information.
pause
goto menu

:settings
title Porti: Settings
cls
echo Welcome to settings
echo 1) Check for updates
echo 2) Reset
echo 3) go back ...
set /p opt=Opt: 
if %opt%==1 goto check4updates
if %opt%==2 goto reset
if %opt%==3 goto menu
goto settings

:reset
cls
echo This will reset Porti completly. Everything in %cd%\Porti will be deleted!
echo Are you sure you want to to this? (y/n)
set /p opt=Opt: 
if %opt%==y goto resetconfirmed
if %opt%==n goto settings

:resetconfirmed
cls
echo Deleting...
del "%cd%\Porti\*" /Q /S /F
rd "%cd%\Porti" /Q /S
echo Done!
pause
exit

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
set /a current=%current%+1
if not exist Porti\Applications\%current% goto foundemptyspace
goto searchappspace

:foundemptyspace
cls
echo Found empty application space: %current%
echo Extracting ZIP Package ...
powershell Expand-Archive %file% -DestinationPath "%portiworkdir%\Applications\%current%"
echo Looking for required files...
if not exist "%portiworkdir%\Applications\%current%\exec.sys" goto notfoundadd
if not exist "%portiworkdir%\Applications\%current%\name.sys" goto notfoundadd
echo All required files found.
echo Application has been added.
pause
goto menu

:notfoundadd
cls
echo Unable to locate files.
echo Required files are:
echo - "%portiworkdir%\Applications\%current%\exec.sys"
echo - "%portiworkdir%\Applications\%current%\name.sys"
pause
echo Removing Application...
del "%portiworkdir%\Applications\%current%\*" /Q /S /F
rd "%portiworkdir%\Applications\%current%" /Q /S
echo Removed application.
pause
goto menu

:setupdatetimer
echo 14 >Porti\updatetimer.sys
goto continue1

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
title Porti: Downloading Porti Text
cls
echo Downloading Porti Text...
Porti\wget https://raw.githubusercontent.com/JanGamesHD/Porti/main/portitext.sys -O Porti\portitext.sys
goto menu

:notinstallfound
:zipfilenotfound
:notfoundfileforinstall
cls
echo Unable to find file: %file%
echo Please use drag and Drop to make sure the right path has been entered.
echo You can also type the path, but make sure to add quotation marks at the start and end when entering
echo a path with spaces
pause
goto menu

:spacewarning
cls
echo Porti is installed in a directory which contains spaces.
echo Please move Porti into a different location which does not contain any spaces.
echo We can automatically install Porti in \Porti
echo Do you want to install Porti in \Porti? (y/n)
set /p opt=Opt: 
if %opt%==y goto installinroot
if %opt%==n exit
goto spacewarning

:installinroot
md \Porti
copy "%~f0" \Porti\Porti.bat
if not exist \Porti\Porti.bat goto error1
goto reload

:loadporti
cd \Porti
call Porti.bat
exit
