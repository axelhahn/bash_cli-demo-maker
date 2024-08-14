<!-- START-ADD-TTY-PLAYER -->
<html>
    <script src=ttyrec/webcomponents-lite.min.js></script>
    <link rel=stylesheet href=ttyrec/tty-player.css>
    <script src=ttyrec/term.min.js></script>
    <script src=ttyrec/tty-player.min.js></script>
</html>
<!-- END-ADD-TTY-PLAYER -->

## Get the files

This can be installed with any non priviledged user.

```shell
cd ~/scripts
git clone https://github.com/axelhahn/bash_cli-demo-maker.git
```

## Access record_demo.sh without path

The script `record_demo.sh` to record a script as a ttyrec file has a paramter `-i` or `--install` to install a helper script in ~/bin.

Then it can be accessed without path.

This step is optional.

```shell
cd bash_cli-demo-maker
./record_demo.sh -i
```
It shows:

```text

CLI DEMO MAKER - record a script as ttyrec file

Creating /home/axel/bin/record_demo.sh ...
DONE:
-rwxr-x--- 1 axel axel 74 Aug 13 12:49 /home/axel/bin/record_demo.sh
Now you can run 'record_demo.sh' without path from aywhere
```

The parameter `--uninstall` or `-u` can remove the file.


<tty-player controls rows=20 cols=90 src=files/clidemo_install.ttyrec poster=npt:0.00></tty-player>
