#!/bin/bash

function helpMessage(){
  echo -e "Usage: $0 -p <filename-pattern> -o <output-file>\n"
  exit 1
} 

while getopts "p:o:h" arg; do
  case $arg in
    p) pattern=$OPTARG;;
    o) outputFile=$OPTARG;;
    h) helpMessage;;
    \?) helpMessage;;
    :) helpMessage;;
  esac
done

if [ -z "$pattern" ] || [ -z "$outputFile" ]; then helpMessage; fi

filesToJoin=($pattern)
isFirstFile=true

if [ ! -e "${filesToJoin[0]}" ]; then
  echo "Could not find files with pattern: $pattern"
  exit 1;
fi

for file in "${filesToJoin[@]}"; do
  if [ $isFirstFile = true ]; then
    head -1 "$file" > "$outputFile"
    isFirstFile=false
  fi
  tail -n +2 "$file" >> "$outputFile";
done