#! /usr/bin/env bash

set -e
set -u

outdir="$1"
completion_file="$2"
counter=0
for png_no_lines in no-lines/*.png
do
    stem=$(basename "$png_no_lines" .png)
    png_no_images=no-images/${stem}.png
    convert $png_no_lines -fill red -colorize 100% \( $png_no_images -fill blue -colorize 100% \) -compose screen -composite ${outdir}/${stem}.png
    counter=$((counter+1))
done
printf 'processed %s files in %s seconds\n' $counter $SECONDS > "$completion_file"
