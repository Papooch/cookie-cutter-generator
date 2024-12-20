# Cookie Cutter Generator

A toolchain for generating 3D printable cookie cutters from a SVG image based on OpenSCAD and Inkscape.

<img src="./generated/pig-walking/pig-walking.svg" alt="source-vector-image" width="250"/>
<img src="./generated/pig-walking/pig-walking-preview.png" alt="3D-model-preview" width="250"/>

The example generated STL can be found in [`generated/pig-walking/pig-walking-output.stl`](./generated/pig-walking/pig-walking-output.stl).

## Dependencies
The following tools need to be available on the CLI, so the corresponding software has to be installed (see below for [docker build](#docker)):
* `inkscape`  
    [Inkscape 1.2+](https://inkscape.org/about/)
* `openscad-nightly`  
    [OpenSCAD (developer preview)](https://openscad.org/downloads.html#snapshots). If installed as a Snap package, [additional file permissions may be needed](https://askubuntu.com/a/1109285/1593582).
    The nightly version is currently needed, because it contains a drastic performance boost for generating models (generating the `pig-walking.svg` takes about 50 seconds as opposed to 30 minutes with the stable version)


## Usage
Invoke the `run.sh` script while passing it the path to the generator script, the input SVG file and the output folder as parameters:

There are several generator scripts available in the `generators/` folder:
* `stamp` - the default one, generates an offset cutter and a stamp of the original SVG image
* `outline` - generates a simple cutter with the exact outline of the original SVG image

Example:

```bash
./run.sh ./inputs/pig-walking.svg ./generated/pig-walking ./generators/stamp.scad
```

This will generate the following files in the `generated/pig-walking/` folder:
* `pig-walking.svg` - a copy of the original SVG
* `pig-walking-fill.svg` - a filled version of the original SVG needed to support OpenSCAD generation
* `pig-walking-stamp-preview.png` - an image preview of the generated STL
* `pig-walking-stamp-output.stl` - the generated STL model ready for 3D printing

## Docker
A Dockerfile to build a Ubuntu image with all the necessary tools is provided, so you don't have to install anything on your machine. The built image is about 1 GB in size (including both Inkscape and OpenSCAD).

Build it with the following command
```bash
docker build -t cookie-cutter-generator .
```

To run it, you will need to map some volumes in order to provide the input file and retrieve the output file. In addition to that, it needs to run with the `--privileged` flag ([reference](https://github.com/s3fs-fuse/s3fs-fuse/issues/647#issuecomment-637458150)).

```bash
args=(
    # remove container after exit
    --rm
    # run in privileged mode
    --privileged
    --name cookie-cutter-generator
    # map input folder
    --volume $PWD/inputs:/input
    # map output folder
    --volume $PWD/generated:/output
        # built image name
        cookie-cutter-generator:latest
        # path to mapped input file inside container
        /input/<name>.svg
        # path to mapped output folder inside container
        /output/<name>
)
docker run $args[@]
```

A convenience script is provided. It takes a name of the input file without the suffix a single parameter. The file must be located in the `inputs` folder and the results are generated to the `generated/<name>` folder.
```bash
./generate-using-docker.sh <name> [<generator-name>]
```
The advantage of this method is that you can run multiple generators in parallel to utilize all the processor cores:
```bash
./generate-using-docker.sh pig-reading &
    ./generate-using-docker.sh pig-sitting &
    ./generate-using-docker.sh pig-sleeping &
    ./generate-using-docker.sh pig-snowball &
    ./generate-using-docker.sh pig-walking
```

### Windows

A convenience PowerShell script to run the docker image on Windows is also provided

```powershell
./generate-using-docker.ps1 <name> [<generator-name>]
```
