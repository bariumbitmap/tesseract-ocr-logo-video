#! /usr/bin/env bash

dir_in="$1"
dir_out="$2"
for fp in "$dir_in"/*.jpg
do
    stem=$(basename "$fp" .jpg)
    tesseract "$fp" "$dir_out"/"$stem" -c tessedit_dump_pageseg_images=1
done
