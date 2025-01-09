## Introduction

The project contains 2 wrapper scripts to make your CLI demo easier. One shows a script as interactive demo and the other records it as a ttyrec file.
If these wrappers don't fit your needs - only then - you can use the class like script `cdm.class.sh` and use its functions.

Let's start with the simple way.

## run_demo.sh

You can use the script `run_demo.sh` to show a demo of your macro script file in a presentation.

### Help

```text

Axels CLI DEMO MAKER v0.7

  Author: Axel Hahn
  Docs: https://www.axel-hahn.de/docs/bash_cli-demo-maker/
  License: GNU GPL 3.0

DESCRIPTION:
  The script runner starts your cdm script to show an interactive terminal
  demo.

SYNTAX:
  run_demo.sh [OPTIONS] SCRIPTFILE

OPTIONS:
  -h, --help     Show this help
  -v, --verbose  Enable verbose mode
  -w, --wait     Waiting time before executing a command in sec.
                 Set a float value in sec for a max. waiting time or RETURN.
                 Default: the prompt waits for a RETURN.

PARAMETERS:
  SCRIPTFILE     The script to execute

```

### Examples

#### Interactive demo

For a presentation you can prepare a macro with a set of shell commands.

With giving a macro file without other parameters

`./run_demo.sh <macrofile>`

It will type all commands with a random deley and waits for an interactive press of return key.

#### Automatic demo

The secret is the `-w <seconds>` parameter. It sets a maximum waiting time before starting the command.

`./run_demo.sh -w 2.5 <macrofile>`

#### Record wit ttyrec

An interactive session can be recorded with ttyrec.

Start ttyrec wit -e and give command using a wait time and a macro file. The option -l sets the compression.

`ttyrec -e "./run_demo.sh -w 3 <macrofile>" -l 1`

This creates a file `ttyrecord`. You can rename and/ or move it where needed.

But instead of ttyrec you can use the script `record_demo.sh`.  

## record_demo.sh

An interactive session can be recorded with `ttyrec`.

### Help

```text

CLI DEMO MAKER - record a script as ttyrec file

  Author: Axel Hahn
  Docs: https://www.axel-hahn.de/docs/bash_cli-demo-maker/
  License: GNU GPL 3.0

DESCRIPTION:

  The script records a script using 'ttyrec' and 'run_demo.sh'.
  It requires a single (or multiple) demo script to execute.

  Each script will be executed as demo by run_demo.sh.
  The output session will be recorded in a ttyrec file. The output file is
  written into the output directory that you can set with the -o option.
  The output file is the basename of the input flile with ".ttyrec" appended.

SYNTAX:

  record_demo.sh [OPTIONS] SCRIPTFILE [... SCRIPTFILE_N]

OPTIONS:

  -h|--help      Show this help

  -i|--install   Install a helper script to ~/bin
                 Then you can run record_demo.sh without path
  -u|--uninstall Uninstall the helper script to ~/bin

  -o|--outdir    Set an output dir for the ttyrec file
                 Default: ../docs/files

PARAMETERS:

  SCRIPTFILE     The script to execute.
                 'run_demo.sh' must be able to interpret it. It is mostly
                 a file with a list of single line Bash commands.

EXAMPLE:

  record_demo.sh -o "/tmp" "my_example.cdm"
                 Execute cli demo using 'my_example.cdm'.
                 It creates a file named '/tmp/my_example.ttyrec'.

```

### Examples

The basic synatx is:

`./record_demo.sh -o <outdir> <macrofile>`
