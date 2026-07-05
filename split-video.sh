#! /usr/bin/env bash

HELP="Usage: $0 'example.mp4' '/path/to/output/directory'"
function usage() {
    printf "%s\n" "$HELP" >&2
}
if test "$#" -eq 0
then
    usage
    exit 1
elif test "$*" = "-h" || test "$*" = "--help"
then
    usage
    exit 0
elif test "$#" -ne 2
then
    usage
    exit 1
fi
video="$1"
outdir="$2"
mkdir -p -- "$outdir"/
rm -f -- "$outdir"/*.jpg
ffmpeg -i "${video}" "${outdir}"/'%04d.jpg'
#ffmpeg -i "${video}" -vf "select=lt(n\,2)" -vframes 2 "${outdir}"/'%04d.jpg' -loglevel error

