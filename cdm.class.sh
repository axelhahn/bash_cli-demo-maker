#!/bin/bash
# ======================================================================
#
# CLI DEMO MAKER
#
# a shell script to show cli demos
#
# ----------------------------------------------------------------------
# license: GNU GPL 3.0
# source: <https://github.com/axelhahn/bash_cli-demo-maker>
# docs:   <https://www.axel-hahn.de/docs/bash_cli-demo-maker/>
# author: Axel Hahn * www.axel-hahn.de
# ----------------------------------------------------------------------
# 2024-05-nn  v0.1  initial version
# 2024-05-nn  v0.2  parse script
# 2024-05-28  v0.3  improve parse script; add cdm.shell; remove command limitations
# 2024-05-30  v0.4  add wait time before executing a command
# 2024-05-30  v0.5  detect timeout and write new line; fix in cdm.script
# 2024-07-24  v0.6  apply waittime at the end too; show 
# 2024-08-14  v0.7  apply fake path in prompt; rename cdm.waitOnEnd to cdm.end; root user is red
# ======================================================================

CDM_VERSION='0.7'

# data for prompt: a username, a dummy hostname and a path 
# (empty string = always show current dir)
CDM_USER='user'
CDM_HOST='tux-client'
CDM_PATH=''

CDM_WAITTIME=''

COLOR_PRESET_prompt_user='green'
COLOR_PRESET_prompt_userroot='red'
COLOR_PRESET_prompt_host='lightgray'
COLOR_PRESET_prompt_path='cyan'
COLOR_PRESET_prompt_char='lightgray'
# COLOR_PRESET_prompt_typer='lightcyan'
COLOR_PRESET_prompt_typer='yellow'

COLOR_PRESET_remark='cyan'

COLOR_PRESET_rc_ok='green'
COLOR_PRESET_rc_error='white red'


# ----------------------------------------------------------------------
# SETTER
# ----------------------------------------------------------------------

# Set a host name for the prompt
# param  string  new host name; default is "tux-client"
function cdm.sethost(){
    CDM_HOST="$1"
}

# Set a fixed path for the prompt to hide the current location
# param  string  new path name; default is "" (=dynamicly written current dir)
function cdm.setpath(){
    CDM_PATH="$1"
}   

# Set a user name for the prompt
# param  string  new user name; default is "user"
function cdm.setuser(){
    CDM_USER="$1"
}   

# Set waiting time after finishing the prompt and before command execution 
# param  float  new wait time in sec, eg 2.5; default is '' (=interactive return)
function cdm.setwaittime(){
    CDM_WAITTIME="$1"
}

# Wait for N seconds and show a progress bar while waiting
# Use this to show that the program is still running but needs to wait a fixed
# amount of time.
# param  integer  new wait time in sec
function cdm.timer(){
    local _timer; typeset -i _timer="$1"
    local _progress; typeset -i _progress=0

    while [ $_progress -lt $_timer ]; do
        _progress+=1
        local _bar=''



        for (( i=0; i<_progress; i++ )); do
            _bar="${_bar}#"
        done

        for (( i=_progress; i<_timer; i++ )); do
            mychar='.'
            test $(( (i+1) % 5 ))  -eq 0  && mychar='+'
            test $(( (i+1) % 10 )) -eq 0  && mychar='|'
            test $(( (i+1) % 50 )) -eq 0  && mychar='#'
            _bar="${_bar}${mychar}"
        done

        printf "\rWaiting %s sec | %3s $_bar  " $_timer $_progress
        sleep 1

    done

    echo -ne "\r"
}

# ----------------------------------------------------------------------
# PROMPT + EXEC
# ----------------------------------------------------------------------

# Render a fake shell prompt
# see cdm.sethost to set a different host
# see cdm.setuser to set a different user
# see cdm.setpath to set a fixed path to hide real path
function cdm.prompt(){
    local _path; 
    local _colUser=$COLOR_PRESET_prompt_user
    test "$CDM_USER" = "root" && _colUser=$COLOR_PRESET_prompt_userroot

    _path="$CDM_PATH"
    if [ -z "$_path" ]; 
    then 
        _path=$( pwd )
        _path=$( echo "$_path" | sed "s#^/home/[a-z]*/#~/#g" )
    fi

    color.print $_colUser "$CDM_USER"
    color.print $COLOR_PRESET_prompt_host "@$CDM_HOST "
    color.print $COLOR_PRESET_prompt_path "$_path"
    color.print $COLOR_PRESET_prompt_char "> "
}

# Write a remark in the console
# param string  text to show
function cdm.rem(){
    sleep 0.3
    color.fg $COLOR_PRESET_remark
    echo "$*" | sed "s#^#        |  #g"
}

# Run a command: it renders a prompt, types the command and executes it.
# You get the output of it and see the return code
# see cmd.shell to run any command without the fake prompt
# param  string  command to execute
function cdm.run(){
    local dummy
    local readparam=

    test -n "$CDM_WAITTIME" && readparam="-t $CDM_WAITTIME"

    echo
    cdm.prompt
    sleep 1
    color.fg $COLOR_PRESET_prompt_typer
    cdm.typer "$*"
    color.reset

    read -r -s $readparam dummy
    echo

    cdm.shell $*
    rc=$?
    if [ $rc -eq 0 ]; then
        color.echo $COLOR_PRESET_rc_ok "rc = $rc"
    else
        color.echo $COLOR_PRESET_rc_error "rc = $rc"
    fi
}

# Run a command without prompt
# You get the output of it
# param  string  command to execute
function cdm.shell(){
    eval $*
}

# Randomly delayed typing of a given text
# Dealy time is random between 0.0 and 0.250 sec
# param string text
function cdm.typer(){
    local _txt="$1"
    local _sleep; typeset -i _sleep
    local _sleep2
    for ((i=0; i<=${#_txt}; i++)); do
        printf '%s' "${_txt:$i:1}"
        _sleep=$(( RANDOM % 250 ))
        _sleep2=$_sleep
        test $_sleep -lt 10  && _sleep2=0$_sleep2
        test $_sleep -lt 100 && _sleep2=0$_sleep2
        _sleep2=0.$_sleep2
        sleep "$_sleep2"
    done 
}


# show a waiting text after a demo
# param  string  optional: custom text; default: "End of this demo. Press Return ..."
function cdm.end(){
    local _text="${1:- >>> End of this demo. Press Return ... }"
    local dummy
    local readparam=

    test -n "$CDM_WAITTIME" && readparam="-t $CDM_WAITTIME"

    sleep 0.5; echo
    sleep 0.3; echo
    sleep 0.2; echo
    sleep 0.1; echo
    sleep 0.05; echo
    # color.echo darkgray "______________________________________________________________________________"
    # test -z "$1" && color.echo darkgray "Created with CLI DEMO MAKER  <https://github.com/axelhahn/bash_cli-demo-maker>"; sleep 3; echo; echo; echo; echo

    color.reset
    echo -n "$_text"
    read -r -s $readparam dummy
    echo
    echo
}

# ----------------------------------------------------------------------
# PARSE SCRIPT
# ----------------------------------------------------------------------

# Parse a script and execute it from a generated temp file
# param  string  path to script
# param  string  optional: to debug set a non empty string
function cdm.script() {
    local _script="$1"
    local _debug="$2"
    local _exec=/tmp/cdm__generated_script__$USER.sh

    local array
    local _prefix
    local _suffix
    local _firstword
    rm -f "$_exec"

    echo "#!/bin/bash" >> "$_exec"
    
    grep "[a-z]" "$_script" | while read -r line; do

        if echo "$line" | xargs | grep -q "^#"; then continue; fi

        array=( "$line" )
        _prefix=
        _suffix=
        

        if echo "$line" | xargs | grep -q "^rem"; then 
            _prefix="cdm."; 
        else
            if ! echo "$line" | xargs | grep -q "^cdm\."; then 
                _prefix="cdm.run '" ;
                _suffix="'"
            fi
        fi

        _firstword=$( echo "${_prefix}${array[*]}" | cut -f 1 -d " " | grep "cdm\." )
        echo -n "$_firstword" >> "$_exec"
        echo "${_prefix}${array[*]}${_suffix}" | sed 's#^cdm\.[a-z][a-z]*##gi' >> "$_exec"
        
    done
    if [ -n "$_debug" ]; then
        echo "DEBUG: generated code:"
        echo
        sed "s#^#    #g" "$_exec"
        echo
        echo -n "DEBUG: wait time: "
        test -z "$CDM_WAITTIME" && echo "interactive - wait for RETURN" || echo "wait for RETURN or max. $CDM_WAITTIME sec"
    fi
    # shellcheck source=/dev/null
    . "$_exec"
    rm -f "$_exec"
}
# ----------------------------------------------------------------------
