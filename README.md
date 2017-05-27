# BatchChat
Live Batch Instant messaging using shared folders with Username, Chat Name, Chat MOTD and User permission customisation through commands. Instant install and setup. (Required Windows 7 or higher)

## Installing

Download the necessary Batch files (`BatchChat.bat` and `chat_log.bat`) and store them in the same directory. Run `BatchChat.bat` and it will automatically set up and install. You should get prompted to enter a drive name in. This should be the name of the drive you are using as a shared drive (make sure you have read/write permissions to the shared drive).

Once entered it will automatically set up the chat server files on the selected drive's root (`drive:\BatchChat`). You will hten get prompted for a username. This can be changed the next time you log in and is simply visual. Set this to what you want. You should then see the chat log and chat entry forms. Type into the entry to send the text over to the chat.

You can type `\drive` and `\reset` in the Username entry box to change the drive letter and reset the chat.

## Getting a shared drive

Find the drive you want and go to Properties and enable sharing. Then, from any computer you want to share the the chat with, goto Network and log into the shared drive's computer and right-click on the shared drive again. Go to Map Network Drive and map it to an unused drive letter. Use that drive letter in your program.

## Commands

There is a variety of chat commands you can enter directly in chat to perform various actions.

**/open** - Reopens the chat log window if it gets closed.

**/exit** - Exits the chat and broacasts and exit notification to other users.

**/exit -p** - Exits the chat privately without an alert to other users.

**/away** - Marks you as away and allows you to reconnect at any time.

**/name** - Changes the global name of the chat for all users (admin command)

**/name -p** - Changes the chat name without notifiying other users.

**/motd** - Changes the chat's MOTD for all users (requires /clear)

**/motd -p** - Changes the chat's MOTD without a notification (requires /clear)

**/clear** - Clears the chat window (and updates motd/name) for all users

**/clear -p** - Clears the chat window without notification to other users

**/reset** - Resets the chat to defaults

**/del** - Deletes the chat completely and disconnects all users

**/user** - Changes your username while in chat

**/drive** - Changes the drive letter (highly unreccomended)
