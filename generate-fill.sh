#!/bin/sh
input_file=$1
output_file=${2:-$1-fill}

# Generate a filled version of the SVG using Inkscape
inkscape -g --actions="mcepl.ungroup-deep.noprefs;
    select-all;
    object-to-path;
    select-all;
    path-break-apart;
    select-all;
    path-union;
    export-filename:$output_file;
    export-do;
    quit-immediate;" \
"$input_file"

echo -- Filled SVG generated: "$output_file"