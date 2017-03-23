@echo off

rem Iterates each line result from the command which lists files/folders
rem     not added to source control while respecting the ignore list.
FOR /F "delims==" %%G IN ('svn status ^| findstr "^?"') DO call :DoSVNAdd "%%G"
goto end

:DoSVNAdd
set addPath=%1
rem Remove line prefix formatting from svn status command output as well as
rem    quotes from the G call (as required for long folder names). Then
rem    place quotes back around the path for the SVN add call.
set addPath="%addPath:~9,-1%"
svn add %addPath%

:end
