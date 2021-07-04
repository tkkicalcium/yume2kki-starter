@echo off
title Setup-Env
echo --------------------------------------------
echo  setup-env
echo --------------------------------------------
md lib > NUL 2>&1

echo  (1/2) Downloading tcc...
md tmp > NUL 2>&1
call powershell -c "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27-win32-bin.zip -OutFile tmp\\tcc.zip"
echo.
echo  Unzipping...
call powershell -c "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Force -DestinationPath lib tmp\\tcc.zip"
rmdir /Q /S  tmp > nul 2>&1
echo --------------------------------------------

echo  (2/2) Downloading rcedit...
call powershell -c "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://github.com/electron/rcedit/releases/download/v1.1.1/rcedit-x86.exe -OutFile lib\\rcedit-x86.exe"
echo --------------------------------------------

echo  Done!
echo --------------------------------------------
echo.
IF %0 == "%~0" pause
