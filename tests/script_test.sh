#!/bin/bash

debug=""
debug="true"

cd $( dirname $0 )/../

. cdm.class.sh || exit 1
. vendor/color.class.sh || exit 1


cdm.script tests/demotest.cdm $debug
