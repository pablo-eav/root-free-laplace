@echo off
set "OCTAVE_BIN=C:\Program Files\GNU Octave\Octave-11.3.0\mingw64\bin"
cd /d "%~dp0"
echo Iniciando GNU Octave con la Toolbox Root-Free Laplace cargada...
start "" "%OCTAVE_BIN%\octave.exe" --persist --eval "start_toolbox;"
