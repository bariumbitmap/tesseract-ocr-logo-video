#! /usr/bin/env bash


set -e
set -u

dir_in="$1"
dir_out="$2"
completion_file="$3"
counter=0
for png_in in ${dir_in}/*.png
do
    stem=$(basename "$png_in" .png)
    png_out=${dir_out}/${stem}.png
    convert ${png_in} -quiet -trim -bordercolor white -border 50x50 -resize 800x800 -background white -gravity center -extent 800x800 ${png_out}
    counter=$((counter+1))
done
printf 'processed %s files in %s seconds\n' $counter $SECONDS > "$completion_file"
