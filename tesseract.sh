#! /usr/bin/env bash

set -e
set -u
dir_in="$1"
dir_out="$2"
completion_file="$3"
counter=0
for fp in "$dir_in"/*.jpg
do
    stem=$(basename "$fp" .jpg)
    set +e
    tesseract "$fp" "$dir_out"/"$stem" -c tessedit_dump_pageseg_images=1 tsv txt
    set -e
    counter=$((counter+1))
done
printf 'processed %s files in %s seconds\n' $counter $SECONDS > "$completion_file"
