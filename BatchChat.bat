@echo off
:launch
set version=0.0.2
set build=null
set status=complete
set launch_time=%time%
set launch_date=%date%
set errnet=0
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
echo                                   -= Connecting to chat =-
if not exist %drive%\BatchChat\ goto err_nochat
cls
call :disp
echo.
echo                                        -= Username: =-
set /p user=^>
if "%user%"=="null" goto join
if "%user%"=="/drive" goto joinset
if "%user%"=="/reset" goto setup
if "%user%"=="" goto join
if "%user%"==" " goto join
title BatchChat - Connecting
set uname=%user%
mode 100,10
cls
echo set message=[%time%] %user% has joined the chat. > %drive%\BatchChat\chat_text\text.bat
echo. > temp.txt
start chat_log.bat
ping 1.1.1.1 -n 1 -w 500 > nul
del temp.txt
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
:: General Commands
if "%msg%"=="/open" goto msg_open
:: Status Commands
if "%msg%"=="/exit" goto msg_exit
if "%msg%"=="/exit -p" goto msg_exitp
if "%msg%"=="/away" goto msg_away
:: Chat Setup Commands
if "%msg%"=="/name" goto msg_name
if "%msg%"=="/name -p" goto msg_namep
if "%msg%"=="/motd" goto msg_motd
if "%msg%"=="/motd -p" goto msg_motdp
:: Chat Danger Commands
if "%msg%"=="/clear" goto msg_clear
if "%msg%"=="/clear -p" goto msg_clearp
if "%msg%"=="/reset" goto msg_reset
if "%msg%"=="/del" goto msg_del
:: Settings Commands
if "%msg%"=="/user" goto msg_user
if "%msg%"=="/drive" goto msg_drive
cls
echo Enter a message or command:
echo.
echo Sending message..
set message=[%time%] [%user%] %msg%
echo set message=%message% > %drive%\BatchChat\chat_text\text.bat
::timeout /t 1 /nobreak >nul
goto msg

:msg_open
if exist chat_log.bat start chat_log.bat
if not exist chat_log.bat goto err_fatal
goto msg

:msg_exit
echo set message=[%time%] %user% has left the chat. > %drive%\BatchChat\chat_text\text.bat
:msg_exitp
:exit
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
:msg_namep
cls
echo Enter a name for the chat:
echo.
set cname=Chat
set /p cname=^>
echo set chat_name=%cname%>%drive%\BatchChat\chat_data\settings.bat
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
:msg_motdp
cls
set chat_motd=%chat_motd%
echo Enter your MOTD:
echo.
set /p chat_motd=^>
echo set chat_motd=%chat_motd%>%drive%\BatchChat\chat_data\motd.bat
goto msg

:msg_clear
echo set message=[%time%] %user% cleared the chat. >> %drive%\BatchChat\chat_text\text.bat
:msg_clearp
echo temp > %drive%\BatchChat\chat_data\reset.txt
timeout /t 1 /nobreak > nul
del %drive%\BatchChat\chat_data\reset.txt
goto msg

:msg_reset
call %cd%\BatchChatConfig\config\cfg.bat
if not exist %drive%\BatchChat md %drive%\BatchChat
if not exist %drive%\BatchChat\chat_data md %drive%\BatchChat\chat_data
if not exist %drive%\BatchChat\chat_text md %drive%\BatchChat\chat_text
echo set message=>%drive%\BatchChat\chat_text\text.bat
echo set chat_name=Chat>%drive%\BatchChat\chat_data\settings.bat
echo set chat_motd=Welcome to the chat!>%drive%\BatchChat\chat_data\motd.bat
echo set message=[%time%] %user% reset the chat. > %drive%\BatchChat\chat_text\text.bat
goto msg

:msg_del
cls
del %drive%\BatchChat
goto msg
:msg_deleted
cls
echo You have been disconnected from the chat.
pause>nul
exit

:msg_user
cls
echo Enter a new Username:
echo.
set oldname=%user%
set /p uname=^>
set user=%uname%
echo set message=[%time%] %oldname% changed names to '%user%'. > %drive%\BatchChat\chat_text\text.bat
goto msg

:msg_drive
cls
set drive=%drive%
echo Enter the name of the drive:
echo.
set /p drive=^>
del %cd%\BatchChatConfig\config\cfg.bat
(echo | set /p=set drive=%drive%)>>%cd%\BatchChatConfig\config\cfg.bat
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
echo Enter a message or command:
echo.
echo Warning: Could not connect to the chat. Waiting for connection [   ]
timeout /t 1 /nobreak > nul
cls
echo Enter a message or command:
echo.
echo Warning: Could not connect to the chat. Waiting for connection [.  ]
timeout /t 1 /nobreak > nul
cls
echo Enter a message or command:
echo.
echo Warning: Could not connect to the chat. Waiting for connection [.. ]
timeout /t 1 /nobreak > nul
cls
echo Enter a message or command:
echo.
echo Warning: Could not connect to the chat. Waiting for connection [...]
timeout /t 1 /nobreak > nul
goto msg

set errnet=0
goto msg
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
