@echo off
rem ������ ����������� ������������� TortoiseProc
rem ������������� tsvn command_name path
rem command_name ����� ��������� ��������: log, commit(ci), checkout(co) merge, blame, repostatus (rs)

set command=%1
set path_=%2

if %command%=="ci" set command="commit"
if %command%=="co" set command="checkout"
if %command%=="rs" set command="repostatus"

TortoiseProc /command:%command% /path:%path_%
