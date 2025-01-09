## Why

I needed something for a presentation in a terminal.

One possibility was: I have a text file and put command by command via clipboard into the terminal.

Nooo - I can write scripts. I want that all actions can be repeated. Before my presentation everything was tested carefully.

## Description

The CLI demo maker processes terminal commands line by line. But not with the speed of a normal shell script.

To bring in it simulates a promt with the current path. If you change the directory in one line and ls in the next command the prompt will follow and the ls knows the directory for its action. If you set a variable it stays in the environment. In short: it is like shell but with pre defined commands.

Sure I don't want to type anything. A typer function enters each command with a short delay. This looks nicer.

Next to the commands we can show commments (see cmd.rem) between output and the next command.

You also can execute commands without showing the typer.

And I wanted colors.

Everything is prepared for an automated, proofed demo for your next presentation.
