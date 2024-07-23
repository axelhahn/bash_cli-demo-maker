## Use functions

When not using the delivered CLI wrapper then in your shell script you need to source

* cdm.class.sh
* vendor/color.class.sh

Then you can use all functions starting with **cdm.** prefix.

Mainly you would need

* cdm.run '<COMMAND>' - to execute a set of commands line by line
* cdm.rem '<TEXT>' - to show comments

## Script

You can write a script that can be parsed and executed with `cdm.script <FILE>`.

### Syntax of scripts

* It is close to a shell script - with a limitiation of commands in a single line.
* Lines with starting `#` are comments and will be ignored.
* Leading whitespace will be ignored
* Additional commands:
  * **cdm.** prefix is detected - these function will be executed directly without prompt
  * **rem [TEXT]** is a shortcut for `cdm.rem [TEXT]`

But in short: for a first start write your commands line by line.


### Example

```shell
# --------------------------------------------------
# example cdm script
# --------------------------------------------------

    cd /opt/cronwrapper/
    ls *.sh
    rem "Here are the main shell scripts of the project"

    # set "root" in the prompt:
    cdm.setuser root
    du -hs /var/log/*

# --------------------------------------------------
```
