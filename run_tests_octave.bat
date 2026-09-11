@echo off
set "OCTAVE_BIN=C:\Program Files\GNU Octave\Octave-11.3.0\mingw64\bin"
echo =================================================================
echo   EJECUTANDO PRUEBAS UNITARIAS DE ROOT-FREE LAPLACE EN GNU OCTAVE
echo =================================================================
"%OCTAVE_BIN%\octave-cli.exe" --eval "addpath('%~dp0'); addpath('%~dp0tests'); run_all_tests;"
echo.
pause
