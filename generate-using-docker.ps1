$file_name=$args[0]
$generator_name=$args[1] ?? "stamp"

docker run `
    --rm `
    --privileged `
    --name cookie-cutter-generator-$file_name `
    --volume $PWD/inputs:/input `
    --volume $PWD/generated:/output `
    --volume $PWD/generators:/generators `
        cookie-cutter-generator:latest `
        /input/$file_name.svg `
        /output/$file_name `
        /generators/$generator_name.scad