#!/bin/bash
# ======================================================================
#
# CLI DEMO MAKER
#
# Record a script using ttyrec and run_demo.sh
#
# ----------------------------------------------------------------------
# license: GNU GPL 3.0
# source: <https://github.com/axelhahn/bash_cli-demo-maker>
# docs:   <https://www.axel-hahn.de/docs/bash_cli-demo-maker/>
# author: Axel Hahn * www.axel-hahn.de
# ----------------------------------------------------------------------
# 2024-08-14  v0.1  initial version
# ======================================================================

outdir=../docs/files

# ----------------------------------------------------------------------
# functions
# ----------------------------------------------------------------------

function _showhelp() {
    local _self; _self=$( basename $0 )
    cat << EOF
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

  $_self [OPTIONS] SCRIPTFILE [... SCRIPTFILE_N]

OPTIONS:

  -h|--help      Show this help

  -i|--install   Install a helper script to ~/bin
                 Then you can run $_self without path
  -u|--uninstall Uninstall the helper script to ~/bin

  -o|--outdir    Set an output dir for the ttyrec file
                 Default: $outdir

PARAMETERS:

  SCRIPTFILE     The script to execute.
                 'run_demo.sh' must be able to interpret it. It is mostly
                 a file with a list of single line Bash commands.

EXAMPLE:

  $_self -o "/tmp" "my_example.cdm"
                 Execute cli demo using 'my_example.cdm'.
                 It creates a file named '/tmp/my_example.ttyrec'.

EOF
}

# helper: get the current basename of this script and add ~/bin/ in front
function _getfile(){
    echo ~/bin/"$( basename "$0" )"
}

# helper: check if the current basename in ~bin is already in use for current
# script; it is used in _instll and _uninstall
function _checkfile(){
    local outfile; outfile="$( _getfile)"
    if [ -f "$outfile" ]; then
        if ! grep -q "$( basename "$0" )" "$outfile"; then
            echo "ABORT: $outfile already exists and is in use for another path or tool."
            exit 1
        fi
    fi
}

# install a file in ~/bin to be able to run it without path
function _install(){
    _checkfile
    local outfile; outfile="$( _getfile)"
    echo "Creating $outfile ..."
    (
        echo "#!/bin/bash"
        echo "$( pwd )/$( basename $0 ) \$*"
    ) > "$outfile" \
        && chmod 750 "$outfile" \
        && echo "DONE:" \
        && ls -l "$outfile" || exit 1

    echo "Now you can run '$( basename "$0" )' without path from aywhere"
    echo
}

# uninstall a file in ~/bin
function _uninstall(){
    _checkfile
    local outfile; outfile="$( _getfile)"
    if [ -f "$outfile" ]; then
        echo "Removing $outfile ..."
        rm -f "$outfile" || exit 1
    else
        echo "SKIP: Not installed: $outfile"
    fi
}

# ----------------------------------------------------------------------
# MAIN
# ----------------------------------------------------------------------


echo
echo "CLI DEMO MAKER - record a script as ttyrec file"
echo

while [[ "$#" -gt 0 ]]; do case $1 in
    -h|--help) _showhelp; exit 0;;

    -i|--install) _install ;exit 0;;
    -u|--uninstall) _uninstall ;exit 0;;

    -o|--outdir) outdir="$2"; shift; shift ;;

    *) if grep "^-" <<< "$1" >/dev/null ; then
        echo; echo "ERROR: Unknown parameter: $1" >&2; echo; _showhelp; exit 2
       fi
       break;
       ;;
esac; done

echo "Output dir: $outdir"
if [ ! -d "$outdir" ]; then
    echo "ERROR: Output dir not found: $outdir" >&2
    echo "Use parameter -o|--outdir <path> to set it" >&2
    exit 3
fi
which ttyrec >/dev/null || exit 1

if [ $# -lt 1 ]; then
    echo "ERROR Parameter with file required" >&2
    echo
    ls *.cdm 2>/dev/null
    exit 1
fi

for myfile in "$@"
do
    echo ">>>>>>>>>> $myfile"
    outfile="$outdir/$(basename "$myfile" .cdm).ttyrec"

    if [ "$outfile" -nt "$myfile" ]; then
        echo "SKIP: The script was not changed after genearation of a ttyrec file."
        ls -l "$outfile" "$myfile"
    else
        ttyrec -l 1 -e "$(dirname "$0")/run_demo.sh -w 3 $myfile" -f get_value.ttyrec \
            && echo \
            && echo "Finished. Moving ttyrec file to target..." \
            && mv ttyrecord "$outfile" \
            && ls -l "$outfile" || exit 2
    fi
    echo
done

echo "DONE"

# ----------------------------------------------------------------------
