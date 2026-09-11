@echo off
set "OCTAVE_LAUNCH=C:\Program Files\GNU Octave\Octave-11.3.0\octave-launch.exe"
cd /d "%~dp0"
echo Iniciando GNU Octave GUI (Editor e Interfaz Grafica)...
start "" "%OCTAVE_LAUNCH%"
