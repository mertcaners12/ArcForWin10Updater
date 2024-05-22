@echo off

echo The purpose of this batch script is to update Arc Browser on unsupported systems.
echo ATTENTION: Developer settings must be enabled in order for this script to work.
echo Made by mertcaners12
pause

echo Copying the Arc backup files to a temporary location
mkdir %TEMP%\ArcBackup
set ArcBackup=%TEMP%\ArcBackup
xcopy "%USERPROFILE%\AppData\Local\Packages\TheBrowserCompany.Arc_ttt1ap7aakyb4" "%ArcBackup%" /E /I /Y

echo ATTENTION: Make sure to backup your cookies! This script is work in progress and it might not copy your cookies!
pause
echo Removing the old outdated Arc browser
powershell -Command "Get-AppxPackage *TheBrowserCompany.Arc* | Remove-AppxPackage"

set /p msixLink="Please input the Arc Browser .msix file link: "
set downloadPath=%TEMP%\Arc.msix
powershell -Command "Invoke-WebRequest -Uri %msixLink% -Outfile %downloadPath%"

echo Extracting the file
set extractPath=%TEMP%\ExtractedArc
mkdir %extractPath%
powershell -Command "Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('%downloadPath%', '%extractPath%')"

echo Cd into the extracted folder
cd /d %extractPath%
set AppxManifest=%extractPath%\AppxManifest.xml

echo Changing the MinVersion to '10.0.19041.3636'
powershell -Command "(Get-Content -Path '%AppxManifest%') -replace 'MinVersion="10.0.22000.0"', 'MinVersion="10.0.19041.3636"' | Set-Content -Path '%AppxManifest%'"

echo Renaming the folder to 'Arc' and copying to 'C:\Program Files\Arc'
set finalPath="C:\Program Files\Arc"
mkdir %finalPath%
xcopy "%extractPath%" "%finalPath%" /E /I /Y

echo Registering the app using 'Add-AppxPackage'
powershell -Command "Add-AppxPackage -Register '%finalPath%\AppxManifest.xml'"

echo Copying the backup file from the old installation
rmdir /S /Q "%USERPROFILE%\AppData\Local\Packages\TheBrowserCompany.Arc_ttt1ap7aakyb4"
xcopy "%ArcBackup%" "%USERPROFILE%\AppData\Local\Packages\TheBrowserCompany.Arc_ttt1ap7aakyb4" /E /I /Y

echo Cleaning Phase 1
del /q %ArcBackup%
echo Cleaning Phase 2
del /q %downloadPath%
echo Cleaning Phase 3
del /q %extractPath%
echo All done!

echo Arc is Updated!
echo Please wait 10 seconds to prevent bugs.
timeout 10
