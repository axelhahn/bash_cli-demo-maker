#!/bin/bash
# ======================================================================
#
# CLI DEMO MAKER
#
# a shell script for making demos
#
# ----------------------------------------------------------------------
# license: GNU GPL 3.0
# source: <https://github.com/axelhahn/bash_cli-demo-maker>
# docs:   coming soon <https://www.axel-hahn.de/docs/bash_cli-demo-maker/>
# author: Axel Hahn * www.axel-hahn.de
# ----------------------------------------------------------------------
# 2024-05-nn  v0.1  initial version
# 2024-05-nn  v0.2  parse script
# 2024-05-nn  v0.3  improve parse script; add cdm.shell; remove command limitations
# ======================================================================

CDM_VERSION='v0.3'
CDM_ABOUT='Axels cli demo maker'

# a username in the prompt
CDM_USER='user'
CDM_HOST='tux-client'


COLOR_PRESET_prompt_user='green'
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

function cdm.sethost(){
    CDM_HOST="$1"
}

function cdm.setuser(){
    CDM_USER="$1"
}   


function cdm.timer(){
    local _timer; typeset -i _timer="$1"
    local _progress; typeset -i _progress=0

    while [ $_progress -lt $_timer ]; do
        _progress+=1
        local _bar=''



        for (( i=0; i<$_progress; i++ )); do
            _bar="${_bar}#"
        done

        for (( i=$_progress; $i<$_timer; i++ )); do
            mychar='.'
            test $(( ($i+1) % 5 ))  -eq 0  && mychar='+'
            test $(( ($i+1) % 10 )) -eq 0  && mychar='|'
            test $(( ($i+1) % 50 )) -eq 0  && mychar='#'
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

function cdm.prompt(){
    local _path; 
    _path=$( pwd )
    _path=$( echo "$_path" | sed "s#^/home/[a-z]*/#~/#g" )
    color.print $COLOR_PRESET_prompt_user "$CDM_USER"
    color.print $COLOR_PRESET_prompt_host "@$CDM_HOST "
    color.print $COLOR_PRESET_prompt_path "$_path"
    color.print $COLOR_PRESET_prompt_char "> "
}

# write a remark in the console
# param string  text to show
function cdm.rem(){
    sleep 0.3
    color.fg $COLOR_PRESET_remark
    echo "$*" | sed "s#^#        |  #g"
}

# run a command: it renders a prompt, types the command and executes it.
# You get the output of it and see the return code
# param  string  command to execute
function cdm.run(){
    local dummy

    echo
    cdm.prompt
    sleep 1
    color.fg $COLOR_PRESET_prompt_typer
    cdm.typer "$*"
    color.reset
    read -r dummy
    cdm.shell $*
    rc=$?
    if [ $rc -eq 0 ]; then
        color.echo $COLOR_PRESET_rc_ok "rc = $rc"
    else
        color.echo $COLOR_PRESET_rc_error "rc = $rc"
    fi
}

# run a command without prompt
# You get the output of it
# param  string  command to execute
function cdm.shell(){
    eval $*
}
# randomly delayed typing of a given text
# param string text
function cdm.typer(){
    local _txt="$1"
    for ((i=0; i<=${#_txt}; i++)); do
        printf '%s' "${_txt:$i:1}"
        _sleep=0.$(( (RANDOM % 1000)/600 ))
        sleep "$_sleep"
    done 
}


# show a waiting text after a demo
# param  string  optional: custom text; default: "End of this demo. Press Return ..."
function cdm.waitOnEnd(){
    local _text="${1:- >>> End of this demo. Press Return ... }"
    local dummy
    sleep 0.5; echo
    sleep 0.3; echo
    sleep 0.2; echo
    sleep 0.1; echo
    sleep 0.05; echo
    color.echo darkgray "________________________________________________________________________"
    echo
    echo -n "$_text"
    read -r dummy
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
    echo ". $( dirname $0 )/vendor/color.class.sh | exit 1" >> "$_exec"
    
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

        _firstword=$( echo "${_prefix}${array[@]}" | cut -f 1 -d " " | grep "cdm\." )
        echo -n "$_firstword" >> "$_exec"
        echo "${_prefix}${array[@]}${_suffix}" | sed 's#cdm\.[a-z][a-z]*##gi' >> "$_exec"
        
    done
    if [ -n "$_debug" ]; then
        echo "DEUBUG: generated code:"
        echo
        cat "$_exec" | sed "s#^#    #g"
        echo
        echo "DEUBUG: execute it:"
    fi
    . "$_exec"
    rm -f "$_exec"
}
# ----------------------------------------------------------------------