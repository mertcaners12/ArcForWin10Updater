# ArcForWin10Updater
I made a batch script that updates Arc Browser on Windows 10 that was only supposed to work on Windows 11 devices.

# Here's what does the script does step by step
* 1- Copies the settings and cookies from old Arc installation to a temporary location.
* 2- Removes the outdated Arc Browser.
* 3- Asks user for an file link(msix).
* 4- Extracts the file to a temporary location.
* 5- Changes the MinVersion variable to '10.0.19041.3636' which is Windows 10 21H2.
* 6- Renames the temporary folder to 'Arc' and copies to 'C:\Program Files\'.
* 7- Registers the app using `Add-AppxPackage`.
* 8- Copies the backup from the temporary location to its original place.
* 9- Cleans the temporary files.
* 10- Timeouts 10 seconds to prevent any bugs then quit.
# How to get the MSIX file

[![ArcForWin10Updater](https://img.youtube.com/vi/cqVhn-iFy-4/0.jpg)](https://www.youtube.com/watch?v=cqVhn-iFy-4)
