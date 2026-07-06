#! /usr/bin/env bash

set -e
set -u

outdir="$1"
completion_file="$2"
counter=0
for jpg in jpg/*.jpg
do
    stem=$(basename "$jpg" .jpg)
    png1=page-seg-input/${stem}.png
    png2=composited/${stem}.png
    png3=render_pad/${stem}.png
    montage $jpg $png1 $png2 $png3 -tile 2x2 -geometry +0+0 ${outdir}/${stem}.png
    counter=$((counter+1))
done
printf 'processed %s files in %s seconds\n' $counter $SECONDS > "$completion_file"
