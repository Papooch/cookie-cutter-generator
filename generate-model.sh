#!/bin/sh
input_name=$1
output_filename=${2:-$input_name-output.stl}
preview_filename=${3:-$input_name-preview.png}

# Generate a 3D SVG and a PNG preview using OpenSCAD
openscad-nightly generator.scad \
--enable=fast-csg \
--enable=lazy-union \
-o "$output_filename" \
-o "$preview_filename" \
--colorscheme=DeepOcean \
-D file=\"$input_name\"

stat $preview_filename || exit 1
echo -- PNG preview generated: "$preview_filename"

stat $output_filename || exit 1
echo -- 3D STL model generated: "$output_filename"