@echo off
:launch
set version=0.0.1
set build=null
set status=complete
set launch_time=%time%
set launch_date=%date%
cd %cd%
title BatchChat v%version%
mode 100, 30
color 0f
if not exist %cd%\BatchChatConfig (
	md %cd%\BatchChatConfig
	if not exist %cd%\BatchChatConfig goto accessDenied
)
if exist %cd%\BatchChatConfig cd %cd%\BatchChatConfig
if not exist %cd%\config (
	md %cd%\config
	if not exist %cd%\config goto accessDenied
)
if exist %cd%\config\cfg.bat call %cd%\config\cfg.bat
if not exist %cd%\config\cfg.bat (
	del %cd%\config\cfg.bat
	(echo | set /p=^s^e^t ^d^r^i^v^e^=^n^u^l^l)>>%cd%\config\cfg.bat
	goto err_file002
)
set cd1=%cd%
cd ..
if exist reload.bat del reload.bat
if not exist chat_log.bat goto err_fatal
:menu
if exist %cd%\BatchChatConfig\config\cfg.bat call %cd%\BatchChatConfig\config\cfg.bat
if not exist %cd%\BatchChatConfig\config\cfg.bat goto err_file001
cls
set entry=null
:join
cls
set user=null
call :disp
if not exist %drive%\BatchChat\ goto err_nochat
echo.
echo                                        -= Username: =-
set /p user=^>
if "%user%"=="null" goto join
if "%user%"=="/drive" goto joinset
if "%user%"=="/reset" goto setup
if "%user%"=="" goto join
if "%user%"==" " goto join
set uname=%user%
mode 90,10
cls
echo set message=[%time%] %user% has joined the chat. > %drive%\BatchChat\chat_text\text.bat
start chat_log.bat
if not exist chat_log.bat goto err_fatal
set status=1

:msg
if exist %drive%\BatchChat\chat_data\settings.bat call %drive%\BatchChat\chat_data\settings.bat
if not exist %drive%\BatchChat\chat_data\settings.bat goto err_file001
title BatchChat - %chat_name%
cls
set msg=null
echo Enter a message or command:
echo.
set /p msg=^>
if "%msg%"=="null" goto msg
if "%msg%"=="/exit" goto msg_exit
if "%msg%"=="/away" goto msg_away
if "%msg%"=="/name" goto msg_name
if "%msg%"=="/open" goto msg_open
::if "%msg%"=="/user" goto msg_user
if "%msg%"=="/drive" goto msg_drive
if "%msg%"=="/reset" goto msg_reset
if "%msg%"=="/clear" goto msg_clear
if "%msg%"=="/motd" goto msg_motd
set message=[%time%] [%user%] %msg%
echo set message=%message% > %drive%\BatchChat\chat_text\text.bat
cls
echo Enter a message or command:
echo.
echo ^>
::timeout /t 1 /nobreak >nul
goto msg

:msg_exit
echo set message=[%time%] %user% has left the chat. > %drive%\BatchChat\chat_text\text.bat
:exit
cls
set entry=null
exit

:msg_away
if "%status%"=="1" (
	echo set message=[%time%] %user% is now away. > %drive%\BatchChat\chat_text\text.bat
	cls
	echo Press any key to log in again.
	pause>nul
	set status=0
)
if "%status%"=="0" (
	echo set message=[%time%] %user% is now online. > %drive%\BatchChat\chat_text\text.bat
	cls
	set status=1
	goto msg
)

:msg_name
cls
echo Enter a name for the chat:
echo.
set cname=Chat
set /p cname=^>
echo set chat_name=%cname%>%drive%\BatchChat\chat_data\settings.bat
echo set message=[%time%] %user% changed the chat name to '%cname%'. > %drive%\BatchChat\chat_text\text.bat
goto msg

:msg_open
if exist chat_log.bat start chat_log.bat
if not exist chat_log.bat goto err_fatal
goto msg

:msg_user
cls
echo Enter a new Username:
echo.
set oldname=%user%
set /p uname=^>
set user=%uname%
echo set message=[%time%] %oldname% changed names to '%user%'. > %drive%\BatchChat\chat_text\text.bat

:msg_drive
cls
set drive=%drive%
echo Enter the name of the drive:
echo.
set /p drive=^>
del %cd%\BatchChatConfig\config\cfg.bat
(echo | set /p=set drive=%drive%)>>%cd%\BatchChatConfig\config\cfg.bat
goto msg

:msg_reset
call %cd%\BatchChatConfig\config\cfg.bat
if not exist %drive%\BatchChat md %drive%\BatchChat
if not exist %drive%\BatchChat\chat_data md %drive%\BatchChat\chat_data
if not exist %drive%\BatchChat\chat_text md %drive%\BatchChat\chat_text
echo set message=>%drive%\BatchChat\chat_text\text.bat
if not exist %drive%\BatchChat\chat_data\settings.bat echo set chat_name=Chat>%drive%\BatchChat\chat_data\settings.bat
if not exist %drive%\BatchChat\chat_data\motd.bat echo set chat_motd=Welcome to the chat!>%drive%\BatchChat\chat_data\motd.bat
echo set message=[%time%] %user% reset the chat. > %drive%\BatchChat\chat_text\text.bat
goto msg

:msg_clear
echo set message=[%time%] %user% cleared the chat. >> %drive%\BatchChat\chat_text\text.bat
echo temp > %drive%\BatchChat\chat_data\reset.txt
timeout /t 1 /nobreak > nul
del %drive%\BatchChat\chat_data\reset.txt
goto msg

:msg_motd
cls
set chat_motd=%chat_motd%
echo Enter your MOTD:
echo.
set /p chat_motd=^>
echo set chat_motd=%chat_motd%>%drive%\BatchChat\chat_data\motd.bat
echo set message=[%time%] %user% changed the chat MOTD. > %drive%\BatchChat\chat_text\text.bat
goto msg

:joinset
set drive=%drive%
echo                              -= Enter the name of the drive: =-
echo.
set /p drive=^>
if "%drive%"=="null" (
	cls
	goto joinset
)
if "%drive%"=="" (
	cls
	goto joinset
)
del %cd%\BatchChatConfig\config\cfg.bat
(echo | set /p=set drive=%drive%)>>%cd%\BatchChatConfig\config\cfg.bat
goto setup

:setup
call %cd%\BatchChatConfig\config\cfg.bat
if not exist %drive%\BatchChat md %drive%\BatchChat
if not exist %drive%\BatchChat\chat_data md %drive%\BatchChat\chat_data
if not exist %drive%\BatchChat\chat_text md %drive%\BatchChat\chat_text
echo set message=>%drive%\BatchChat\chat_text\text.bat
if not exist %drive%\BatchChat\chat_data\settings.bat echo set chat_name=Chat>%drive%\BatchChat\chat_data\settings.bat
if not exist %drive%\BatchChat\chat_data\motd.bat echo set chat_motd=Welcome to the chat!>%drive%\BatchChat\chat_data\motd.bat
cls
goto join

:accessDenied
cls
echo Error: File access denied. Launch as administrator.
pause>nul
exit
:err_fatal
cls
echo Error: chat_log.bat is missing!
pause>nul
exit
:err_file001
cls
echo Error: An important system file is missing.
pause>nul
exit
:err_file002
cls
call :disp
echo.
echo The program has been successfully installed.
echo Please wait while it reloads..
cd ..
echo start BatchChat.bat > reload.bat
echo exit >> reload.bat
start reload.bat
exit

:err_nochat
echo.
echo                           -= Could not find a chat to connect to. =-
echo.
goto joinset

:disp
echo                     ^_^_^_^_          ^_         ^_       ^_^_^_^_^_  ^_             ^_   
echo                    ^|  ^_ ^\        ^| ^|       ^| ^|     ^/ ^_^_^_^_^|^| ^|           ^| ^|  
echo                    ^| ^|^_^) ^|  ^_^_ ^_ ^| ^|^_  ^_^_^_ ^| ^|^_^_  ^| ^|     ^| ^|^_^_    ^_^_ ^_ ^| ^|^_ 
echo                    ^|  ^_ ^<  ^/ ^_^` ^|^| ^_^_^|^/ ^_^_^|^| ^'^_ ^\ ^| ^|     ^| ^'^_ ^\  ^/ ^_^` ^|^| ^_^_^|
echo                    ^| ^|^_^) ^|^| ^(^_^| ^|^| ^|^_^| ^(^_^_ ^| ^| ^| ^|^| ^|^_^_^_^_ ^| ^| ^| ^|^| ^(^_^| ^|^| ^|^_ 
echo                    ^|^_^_^_^_^/  ^\^_^_^,^_^| ^\^_^_^|^\^_^_^_^|^|^_^| ^|^_^| ^\^_^_^_^_^_^|^|^_^| ^|^_^| ^\^_^_^,^_^| ^\^_^_^|
echo.
echo                                       - Version %version% -
GOTO:eof