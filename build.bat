@echo off
if not exist "lib\\tcc\\tcc.exe" goto call_setup-env
if not exist "lib\\rcedit-x86.exe" goto call_setup-env
goto build

:call_setup-env
echo --------------------------------------------
echo  -^> call setup-env because lib is not found
call setup-env.bat nopause
goto build

:build
title Build start.exe
echo --------------------------------------------
echo  build start.exe
echo --------------------------------------------
md dist > NUL 2>&1
echo  Compiling...
lib\\tcc\\tcc.exe -Wl,-subsystem=gui -o dist\\start.exe src\\start.c
echo  Attach icon...
lib\\rcedit-x86.exe dist\\start.exe --set-icon src\\yume2kki.ico
echo --------------------------------------------
echo  Done!
echo.
IF %0 == "%~0" pause

