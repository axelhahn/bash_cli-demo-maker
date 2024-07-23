## Help

You can use the script `run_demo.sh` to show a demo of your macro script file.

```text

Axels CLI DEMO MAKER v0.6

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

## Examples

### Interactive demo

For a presentation you can prepare a macro with a set of shell commands.

With giving a macro file without other parameters

`./run_demo.sh <macrofile>`

It will type all commands with a random deley and waits for an interactive press of return key.

### Automatic demo

The secret is the `-w <seconds>` parameter. It sets a maximum waiting time before starting the command.

`./run_demo.sh -w 2.5 <macrofile>`

### Record wit ttyrec

An interactive session can be recorded with ttyrec.

Start ttyrec wit `-e` and give command using a wait time and a macro file.
The option `-l` sets the compression.

`ttyrec -e "./run_demo.sh -w 3 <macrofile>" -l 1`

This creates a file `ttyrecord`.

**Remark**: The option `-f, --output FILE` didn't work in ttyrec version v1.1.7.1.