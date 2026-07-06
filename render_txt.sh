#! /usr/bin/env bash

set -e
set -u

dir_in="$1"
dir_out="$2"
dpi="$3"
completion_file="$4"
counter=0
for txt_file in ${dir_in}/*.txt
do
    stem=$(basename "$txt_file" .txt)
    png_out=${dir_out}/${stem}.png
    font="Ubuntu Mono 14"
    pango-view "$txt_file" --dpi ${dpi} --font="$font" --no-display --output="$png_out"
    counter=$((counter+1))
done
printf 'processed %s files in %s seconds\n' $counter $SECONDS > "$completion_file"
