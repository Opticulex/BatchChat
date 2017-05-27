@echo off
title BatchChat Log - Connecting..
color 0f
set errnet=0
:launch
cls
set message=null && set prevmsg=null
call %cd%\BatchChatConfig\config\cfg.bat
if not exist %drive%\BatchChat\chat_data\settings.bat goto err_net
if not exist %drive%\BatchChat\chat_text\text.bat goto err_net
call %drive%\BatchChat\chat_data\settings.bat
call %drive%\BatchChat\chat_data\motd.bat
echo %chat_motd%
echo.
:loop
if exist %drive%\BatchChat\chat_data\reset.txt (
	timeout /t 1 /nobreak > nul
	goto launch
)
if not exist %drive%\BatchChat\chat_data\settings.bat goto err_net
if not exist %drive%\BatchChat\chat_text\text.bat goto err_net
call %drive%\BatchChat\chat_data\settings.bat
call %drive%\BatchChat\chat_text\text.bat
if "%errnet%"=="1" (
	echo [%time%] Warning: Reconnected to chat!
	set errnet=0
)
title BatchChat Log - %chat_name%
if not "%message%"=="%prevmsg%" (
	set prevmsg=%message%
	echo %message%
)
ping 1.1.1.1 -n 1 -w 500 > nul
goto loop
:err_net
if "%errnet%"=="1" (
	timeout /t 1 /nobreak > nul
	goto loop
)
set errnet=1
echo [%time%] Warning: Could not connect to the chat!
goto loop