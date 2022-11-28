#!/bin/sh
file_name=$1

docker run \
    --rm \
    --privileged \
    --name cookie-cutter-generator-$1 \
    --volume $PWD/inputs:/input \
    --volume $PWD/generated:/output \
        cookie-cutter-generator:latest \
        /input/$file_name.svg \
        /output/$file_name