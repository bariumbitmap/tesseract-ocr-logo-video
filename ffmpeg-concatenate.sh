#! /usr/bin/env bash

set -e
set -u

dir_in="$1"
mp4_out="$2"
framerate="$3"
ffmpeg -framerate ${framerate} -i ${dir_in}/%04d.png -pix_fmt yuv420p -y "${mp4_out}"
# https://trac.ffmpeg.org/wiki/Slideshow
