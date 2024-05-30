#!/bin/bash

cd "$(dirname "$0")/../" || exit 1

/home/axel/sources/bash/bashdoc/bashdoc2md.sh \
    -l 2 \
    -r "https://github.com/axelhahn/bash_cli-demo-maker/blob/main/" \
    cdm.class.sh \
    > docs/50_All_functions.md
