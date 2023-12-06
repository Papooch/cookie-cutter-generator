#!/bin/sh
echo 1-$1 2-$2 3-$3
input_file=$1
name=$(basename $1 .svg)
working_basename=${2:-./generated/$name}
generator_file=${3:-./generators/stamp.scad}

echo generator=$generator_file
echo input_file=$input_file
echo output_dir=$working_basename

# # Ensure all files exist
if [ ! -f "$input_file" ]; then
    echo "Input file '$input_file' does not exist" && exit 1
fi
if [ ! -f "$generator_file" ]; then
    echo "Generator file '$generator_file' does not exist" && exit 1
fi


echo -- Creating working folder "$working_basename"...
mkdir -p $working_basename

working_basename=$working_basename/$name

echo -- Copying "$input_file" to "$working_basename.svg"...
cp "$input_file" "$working_basename.svg" || exit 1

echo -- Generating filled SVG...
sh ./generate-fill.sh "$working_basename.svg" "$working_basename-fill.svg" || exit 1

echo -- Generating 3D STL model...
sh ./generate-model.sh $generator_file $working_basename || exit 1

echo -- Done.
exit 0