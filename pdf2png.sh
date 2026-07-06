#! /usr/bin/env bash

set -e
set -u
dir_in="$1"
completion_file="$2"
counter=0
for fp in "$dir_in"/*_debug.pdf
do
    stem=$(basename "$fp" _debug.pdf)

    pdftoppm -png -r 300 -f 1 -l 1 "$fp" page-seg-input/${stem}
    mv page-seg-input/${stem}-1.png page-seg-input/${stem}.png

    pdftoppm -png -r 300 -f 2 -l 2 "$fp" no-lines/${stem}
    mv no-lines/${stem}-2.png no-lines/${stem}.png

    pdftoppm -png -r 300 -f 3 -l 3 "$fp" no-images/${stem}
    mv no-images/${stem}-3.png no-images/${stem}.png

    counter=$((counter+1))
done
printf 'processed %s files in %s seconds\n' $counter $SECONDS > "$completion_file"
