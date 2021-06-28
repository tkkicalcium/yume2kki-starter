@echo off
title Clean
echo --------------------------------------------
echo  clean
echo --------------------------------------------
echo  Removing dist...
rmdir /Q /S  dist > nul 2>&1
echo  Removing lib...
rmdir /Q /S  lib > nul 2>&1
echo  Removing tmp...
rmdir /Q /S  tmp > nul 2>&1
echo --------------------------------------------

echo  Done!
echo --------------------------------------------
echo.
IF %0 == "%~0" pause
