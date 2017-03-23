@echo off

rem Iterates each line result from the command which lists files/folders
rem     not removed from source
FOR /F "delims==" %%G IN ('svn status ^| findstr "^!"') DO call :DoSVNRemove "%%G"
goto end

:DoSVNRemove
set removePath=%1
rem Remove line prefix formatting from svn status command output as well as
rem    quotes from the G call (as required for long folder names). Then
rem    place quotes back around the path for the SVN remove call.
set removePath="%removePath:~9,-1%"
svn remove %removePath%

:end
