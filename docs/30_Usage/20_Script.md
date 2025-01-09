<!-- START-ADD-TTY-PLAYER -->
<html>
    <script src=ttyrec/webcomponents-lite.min.js></script>
    <link rel=stylesheet href=ttyrec/tty-player.css>
    <script src=ttyrec/term.min.js></script>
    <script src=ttyrec/tty-player.min.js></script>
</html>
<!-- END-ADD-TTY-PLAYER -->

## Script

You can write a script for your shell demo. 
It can be started with `run_demo.sh <FILE>`.

But what is the syntax of such a macro or script?

### Syntax of scripts

* It is close to a shell script - with a limitiation of commands in a single line.
* Lines with starting `#` are comments and will be ignored.
* Leading whitespace will be ignored
* Additional commands:
  * **cdm.** prefix is detected - these function will be executed directly without prompt
  * **rem [TEXT]** is a shortcut for `cdm.rem [TEXT]`

But in short: for a first start write your shell commands line by line.

### Examples

#### Basic example

```shell
# --------------------------------------------------
# example cdm script
# --------------------------------------------------
  
  rem ""
  rem "I am a remark."
  rem "and can display infos and hints."
  rem ""

  ls -ld /tmp
  uptime

# --------------------------------------------------
```

<tty-player controls rows=20 cols=90 src=files/clidemo_usage_basic.ttyrec poster=npt:0.00></tty-player>

#### Override the prompt

By default the prompt is set to `user@tux-client (path) >` - so your own user or hostname is not shown. 

If you want to update it just to see something else or to simulate a remote session you can do it with these commands:

* `cdm.setuser <username>`
* `cdm.sethost <host>`

These commmands will be executed silently.

The path is the current directory which can change with `cd <path>` during your script.

* `cdm.setpath <path>`

You can set a fixed path value - but then keep in mind to update it again when you change directories.

```shell
# --------------------------------------------------

  cdm.shell "cd"

  rem ""
  rem "Have a look to the default prompt:"
  rem ""

  echo "That is the default prompt"

  rem "Now I set another user"
  cdm.setuser "anna"

  echo "I updated the user in the prompt"

  rem "Now I set another host"
  cdm.sethost "webserver-01"

  echo "I updated the host in the prompt"
# --------------------------------------------------
```
<tty-player controls rows=20 cols=90 src=files/clidemo_usage_prompt.ttyrec poster=npt:0.00></tty-player>
