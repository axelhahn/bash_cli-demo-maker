## General

* Prepare a set of cli commands and show tested command sets in a presentation
* ... or record a set of commands using `ttyrec` or similar tools
* Store your commands in a file - it looks like a normal shell script. And can contain special functions `cdm.<function>` for some special commands
* The macrofile runs in a shell session. If you set a variable 
* Next to the "visible prompt" you can execute any command invisibly too - to set variables, create directories, whatever is needed

## Fake terminal

* The shown terminal prompt during the demo is faked to show a neutral user and host - and it can be customized
* An executed command is typed with a random delay
* After typing a command it waits for an interactive return or a given max. wait time

## Execute commands

* You get the output of an executed shell command
* In an extra line there is the return code

## CLI scripts

Next to the bash functions there are bash scripts with command line suppport to execute prepared makros or to record them.
