#!/bin/sh
echo 1-$1 2-$2 3-$3

name=$(basename $1 .svg)
generated_folder_name=${2:-./generated/$name}

echo -- Creating working folder "$generated_folder_name"...
mkdir -p $generated_folder_name

working_basename=$generated_folder_name/$name

echo -- Copying "$1" to "$working_basename.svg"...
cp "$1" "$working_basename.svg" || exit 1

echo -- Generating filled SVG...
sh ./generate-fill.sh "$working_basename.svg" "$working_basename-fill.svg" || exit 1

echo -- Generating 3D STL model...
sh ./generate-model.sh $working_basename || exit 1

echo -- Done.
exit 0