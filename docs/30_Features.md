## General

* Prepare a set of cli commands and show tested command sets in a presentation
* ... or record a set of commands using `ttyrec` or similar tools
* Store your commands in a file - it looks like a normal shell script. And can contain special functions `cdm.<function>` for some special commands

## Fake terminal

* The shown terminal prompt during the demo is faked to show a neutral user and host - and it can be customized
* An executed command is typed with a random delay
* After typing a command it waits for an interactive return or a given max. wait time

## Execute commands

* You get the output of an executed shell command
* In an extra line there is the return code

## CLI script

Next to the bash functions there is a bash script with command line suppport to execute prepared makros
