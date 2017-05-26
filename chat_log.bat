@echo off
color 0f
:launch
cls
set message=null && set prevmsg=null
call %cd%\BatchChatConfig\config\cfg.bat
call %drive%\BatchChat\chat_data\settings.bat
call %drive%\BatchChat\chat_data\motd.bat
echo %chat_motd%
echo.
:loop
if exist %drive%\BatchChat\chat_data\reset.txt (
	timeout /t 1 /nobreak > nul
	goto launch
)
call %drive%\BatchChat\chat_data\settings.bat
call %drive%\BatchChat\chat_text\text.bat
title BatchChat Log - %chat_name%
if not "%message%"=="%prevmsg%" (
	set prevmsg=%message%
	echo %message%
)
goto loop