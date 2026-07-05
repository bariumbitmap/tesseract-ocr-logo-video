#! /usr/bin/env bash

dir_in="$1"
for fp in "$dir_in"/*_debug.pdf
do
    stem=$(basename "$fp" _debug.pdf)
    convert -density 300 "$fp"[0] page-seg-input/${stem}.png
    convert -density 300 "$fp"[1] no-lines/${stem}.png
    convert -density 300 "$fp"[2] no-images/${stem}.png
done
