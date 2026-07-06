#! /usr/bin/env bash


set -e
set -u

dir_in="$1"
dir_out="$2"
x_px="$3"
y_px="$4"
completion_file="$5"
counter=0
for png_in in ${dir_in}/*.png
do
    stem=$(basename "$png_in" .png)
    png_out=${dir_out}/${stem}.png
    convert ${png_in} -quiet -trim -bordercolor white -border 50x50 -resize ${x_px}x${y_px} -background white -gravity center -extent ${x_px}x${y_px} ${png_out}
    counter=$((counter+1))
done
printf 'processed %s files in %s seconds\n' $counter $SECONDS > "$completion_file"
