# BatchChat
Live Batch Instant messaging using shared folders with Username, Chat Name, Chat MOTD and User permission customisation through commands. Instant install and setup. (Required Windows 7 or higher)

## Installing

Download the necessary Batch files (`BatchChat.bat` and `chat_log.bat`) and store them in the same directory. Run `BatchChat.bat` and it will automatically set up and install. You should get prompted to enter a drive name in. This should be the name of the drive you are using as a shared folder (make sure you have read/write permissions to the shared drive).

Once entered it will automatically set up the chat server files on the selected drive's root (`drive:\BatchChat`). You will hten get prompted for a username. This can be changed the next time you log in and is simply visual. Set this to what you want. You should then see the chat log and chat entry forms. Type into the entry to send the text over to the chat.

You can type `\drive` and `\reset` in the Username entry box to change the drive letter and reset the chat.

## Commands

There is a variety of chat commands you can enter.

**/exit** - Exits the chat and broacasts and exit notification to other users.
**/away** - Marks you as away and allows you to reconnect at any time.
**/name** - Changes the global name of the chat for all users (admin command)
**/open** - Reopens the chat log window if it gets closed.
**/user** - Changes your username while in chat (disabled)
**/drive** - Changes the drive letter (highly unreccomended)
**/reset** - Resets the chat to defaults
**/clear** - Clears the chat window (and updates motd/name) for all users
**/motd** - Changes the chat's MOTD for all users (requires /clear)
