#! /usr/bin/env bash

set -e
set -u
dir_in="$1"
completion_file="$2"
counter=0
for fp in "$dir_in"/*_debug.pdf
do
    stem=$(basename "$fp" _debug.pdf)
    convert -density 300 "$fp"[0] page-seg-input/${stem}.png
    convert -density 300 "$fp"[1] no-lines/${stem}.png
    convert -density 300 "$fp"[2] no-images/${stem}.png
    counter=$((counter+1))
done
printf 'processed %s files in %s seconds\n' $counter $SECONDS > "$completion_file"
