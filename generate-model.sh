#!/bin/sh
input_name=$1
output_filename=${2:-$input_name-output.stl}
preview_filename=${3:-$input_name-preview.png}

openscad-nightly generator.scad \
--enable=fast-csg \
--enable=fast-csg-trust-corefinement \
--enable=fast-csg-remesh \
--enable=lazy-union \
-o "$output_filename" \
-o "$preview_filename" \
--colorscheme=DeepOcean \
-D file=\"$input_name\"

echo -- PNG preview generated: "$preview_filename"
echo -- 3D STL model generated: "$output_filename"