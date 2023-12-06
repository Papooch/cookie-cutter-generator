#!/bin/sh
generator_filename=$1
input_filename=$2

generator_name=$(basename $generator_filename .scad)

output_filename=${3:-$input_filename-$generator_name-output.stl}
preview_filename=${4:-$input_filename-$generator_name-preview.png}

# Generate a 3D SVG and a PNG preview using OpenSCAD
openscad-nightly "$generator_filename" \
--enable=fast-csg \
--enable=lazy-union \
-o "$output_filename" \
-o "$preview_filename" \
--colorscheme=DeepOcean \
-D file=\"$input_filename\"

stat $preview_filename || exit 1
echo -- PNG preview generated: "$preview_filename"

stat $output_filename || exit 1
echo -- 3D STL model generated: "$output_filename"