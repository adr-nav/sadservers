#!/bin/bash

header=$(head -n1 "$1")
totalLines=$(wc -l "$1" | awk '{ print $1 }')
csvCount=0
isNewFile=true
needNewFile=false

echo "Total lines: $totalLines"

while read -r line; do
    filename=$(printf "data-%02d.csv" "$csvCount")
    touch "$filename"
    size=$(stat -c %s "$filename")

    if [ $size -ge "32000" ]; then 
        needNewFile=true
    fi

    if [ "$needNewFile" = true ] && [ "$csvCount" -lt 9 ]; then 
        ((csvCount += 1))
        filename=$(printf "data-%02d.csv" "$csvCount")
        isNewFile=true
        needNewFile=false
    fi

    if [ $isNewFile = true ]; then 
        echo "$header" >> "$filename"
        isNewFile=false
    fi

    echo "$line" >> "$filename"
done < <(tail -n +2 "$1")