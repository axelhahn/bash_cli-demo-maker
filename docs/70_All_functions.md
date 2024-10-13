## cdm.class.sh

List of all functions in alphabetic order

### cdm.end()

```txt
show a waiting text after a demo
🔹 param  string  optional: custom text; default: "End of this demo. Press Return ..."
```

[line: 200](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L200)

### cdm.prompt()

```txt
Render a fake shell prompt
👉🏼 see cdm.sethost to set a different host
👉🏼 see cdm.setuser to set a different user
👉🏼 see cdm.setpath to set a fixed path to hide real path
```

[line: 117](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L117)

### cdm.rem()

```txt
Write a remark in the console
🟩 param string  text to show
```

[line: 137](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L137)

### cdm.run()

```txt
Run a command: it renders a prompt, types the command and executes it.
You get the output of it and see the return code
👉🏼 see cmd.shell to run any command without the fake prompt
🟩 param  string  command to execute
```

[line: 147](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L147)

### cdm.script()

```txt
Parse a script and execute it from a generated temp file
🟩 param  string  path to script
🔹 param  string  optional: to debug set a non empty string
```

[line: 229](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L229)

### cdm.sethost()

```txt
Set a host name for the prompt
🟩 param  string  new host name; default is "tux-client"
```

[line: 53](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L53)

### cdm.setpath()

```txt
Set a fixed path for the prompt to hide the current location
🟩 param  string  new path name; default is "" (=dynamicly written current dir)
```

[line: 59](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L59)

### cdm.setuser()

```txt
Set a user name for the prompt
🟩 param  string  new user name; default is "user"
```

[line: 65](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L65)

### cdm.setwaittime()

```txt
Set waiting time after finishing the prompt and before command execution 
🟩 param  float  new wait time in sec, eg 2.5; default is '' (=interactive return)
```

[line: 71](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L71)

### cdm.shell()

```txt
Run a command without prompt
You get the output of it
🟩 param  string  command to execute
```

[line: 175](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L175)

### cdm.timer()

```txt
Wait for N seconds and show a progress bar while waiting
Use this to show that the program is still running but needs to wait a fixed
amount of time.
🟩 param  integer  new wait time in sec
```

[line: 79](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L79)

### cdm.typer()

```txt
Randomly delayed typing of a given text
Dealy time is random between 0.0 and 0.250 sec
🟩 param string text
```

[line: 182](https://github.com/axelhahn/bash_cli-demo-maker/blob/main/cdm.class.sh#L182)

- - -
Generated with [Bashdoc](https://github.com/axelhahn/bashdoc) v0.7
