#!/bin/sh
file_name=$1
generator_name=${2:-stamp}

docker run \
    --rm \
    --privileged \
    --name cookie-cutter-generator-$1 \
    --volume $PWD/inputs:/input \
    --volume $PWD/generated:/output \
    --volume $PWD/generators:/generators \
        cookie-cutter-generator:latest \
        /input/$file_name.svg \
        /output/$file_name \
        /generators/$generator_name.scad