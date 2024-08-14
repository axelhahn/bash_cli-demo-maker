#!/bin/bash
# ======================================================================
#
# CLI DEMO MAKER
#
# Execute a script as a cli demo.
#
# ----------------------------------------------------------------------
# license: GNU GPL 3.0
# source: <https://github.com/axelhahn/bash_cli-demo-maker>
# docs:   <https://www.axel-hahn.de/docs/bash_cli-demo-maker/>
# author: Axel Hahn * www.axel-hahn.de
# ----------------------------------------------------------------------
# 2024-08-14  v0.1  initial version
# ======================================================================

_selfdir="$( dirname "$0" )"

# shellcheck source=/dev/null
. "${_selfdir}/cdm.class.sh" || exit  1

# shellcheck source=/dev/null
. "${_selfdir}/vendor/color.class.sh" || exit 1

FLAG_DEBUG=

# ----------------------------------------------------------------------
# functions
# ----------------------------------------------------------------------

function _showhelp() {
    local _self; _self="$( basename "$0" )"
    cat << EOF

Axels CLI DEMO MAKER v${CDM_VERSION}

  Author: Axel Hahn
  Docs: https://www.axel-hahn.de/docs/bash_cli-demo-maker/
  License: GNU GPL 3.0

DESCRIPTION:
  The script runner starts your cdm script to show an interactive terminal
  demo.

SYNTAX:
  $_self [OPTIONS] SCRIPTFILE

OPTIONS:
  -h, --help     Show this help
  -v, --verbose  Enable verbose mode
  -w, --wait     Waiting time before executing a command in sec.
                 Set a float value in sec for a max. waiting time or RETURN.
                 Default: the prompt waits for a RETURN.

PARAMETERS:
  SCRIPTFILE     The script to execute

EOF
}

# ----------------------------------------------------------------------
# MAIN
# ----------------------------------------------------------------------

# parse params
while [[ "$#" -gt 0 ]]; do case $1 in
    -h|--help) _showhelp; exit 1;;
    -v|--verbose) FLAG_DEBUG=1;shift;;
    -w|--wait) cdm.setwaittime "$2"; shift; shift;;
    *) if grep "^-" <<< "$1" >/dev/null ; then
        echo; color.echo red "ERROR: Unknown parameter: $1" >&2; echo "Use -h to get help." >&2;  exit 2
       fi
       break;
       ;;
esac; done


scriptfile="$1"
if [ -z "$scriptfile" ]; then
    color.echo red "ERROR: No scriptfile specified" >&2
    echo "Use -h to get help." >&2
    exit 2
fi

# ----------------------------------------------------------------------

cdm.script "$scriptfile" $FLAG_DEBUG

# ----------------------------------------------------------------------
