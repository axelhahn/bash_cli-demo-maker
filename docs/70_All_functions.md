## cdm.class.sh

List of all functions in alphabetic order

### cdm.prompt()

```txt
Render a fake shell prompt
👉🏼 see cdm.setHost to set a different host
👉🏼 see cdm.setUser to set a different user
```

[line: 107](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L107)

### cdm.rem()

```txt
Write a remark in the console
🟩 param string  text to show
```

[line: 119](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L119)

### cdm.run()

```txt
Run a command: it renders a prompt, types the command and executes it.
You get the output of it and see the return code
👉🏼 see cmd.shell to run any command without the fake prompt
🟩 param  string  command to execute
```

[line: 129](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L129)

### cdm.script()

```txt
Parse a script and execute it from a generated temp file
🟩 param  string  path to script
🔹 param  string  optional: to debug set a non empty string
```

[line: 203](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L203)

### cdm.sethost()

```txt
Set a host name for the prompt
🟩 param  string  new host name; default is "tux-client"
```

[line: 50](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L50)

### cdm.setuser()

```txt
set a user name for the prompt
🟩 param  string  new user name; default is "user"
```

[line: 56](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L56)

### cdm.setwaittime()

```txt
Set waiting time after finishing the prompt and before command execution
🟩 param  float  new wait time in sec, eg 2.5; default is '' (=interactive return)
```

[line: 62](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L62)

### cdm.shell()

```txt
Run a command without prompt
You get the output of it
🟩 param  string  command to execute
```

[line: 157](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L157)

### cdm.timer()

```txt
Wait for N seconds and show a progress bar while waiting
Use this to show that the program is still running but needs to wait a fixed
amount of time.
🟩 param  integer  new wait time in sec
```

[line: 70](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L70)

### cdm.typer()

```txt
Randomly delayed typing of a given text
🟩 param string text
```

[line: 163](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L163)

### cdm.waitOnEnd()

```txt
show a waiting text after a demo
🔹 param  string  optional: custom text; default: "End of this demo. Press Return ..."
```

[line: 175](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L175)

