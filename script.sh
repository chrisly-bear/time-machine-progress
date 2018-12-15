#!/bin/bash

if [ "${1}" == "start" ]; then
    tmutil startbackup
elif [ "${1}" == "stop" ]; then
    tmutil stopbackup
elif [ "${1}" == "enter" ]; then
    echo "Entering time machine from command line not supported yet"
    open -a /Applications/Time\ Machine.app/
fi
