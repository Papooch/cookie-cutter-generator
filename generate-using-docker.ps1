$file_name=$args[0]

docker run `
    --rm `
    --privileged `
    --name cookie-cutter-generator-$file_name `
    --volume $PWD/inputs:/input `
    --volume $PWD/generated:/output `
        cookie-cutter-generator:latest `
        /input/$file_name.svg `
        /output/$file_name