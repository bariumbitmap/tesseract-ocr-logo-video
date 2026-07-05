#! /usr/bin/env bash

set -e
set -u

dir_in="$1"
mp4_out="$2"
framerate="$3"
ffmpeg -i ${dir_in}/%04d.png -framerate ${framerate} -pix_fmt yuv420p -y "${mp4_out}"
# https://trac.ffmpeg.org/wiki/Slideshow
