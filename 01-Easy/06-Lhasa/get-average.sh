#!/bin/bash

function helpMessage(){
    echo -e "
        Usage: $0 <filename>
    "
}

if [ -n "$1" ]; then
    awk '{ sum += $2 } END {
        average = sum/NR
        truncate = int(average * 100)
        printf "%d.%02d\n", truncate/100, truncate%100 
    }' "$1"
else
    helpMessage
    exit 1
fi