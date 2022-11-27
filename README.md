# Cookie Cutter Generator based on OpenSCAD

## Dependencies
* [Inkscape 1.2+](https://inkscape.org/about/)
* [OpenSCAD (developer preview)](https://openscad.org/downloads.html#snapshots). If installed as a Snap package, [additional file permissions may be needed](https://askubuntu.com/a/1109285/1593582).

The following tools need to be available on the CLI
* `inkscape`
* `openscad-nightly`

## Usage
```bash
./generate.sh path/to/input_file.svg path/to/output_folder
```
This will generate the following files in the `output_folder`
* `input_file.svg` - a copy of the original SVG
* `input_file-fill.svg` - a filled version of the original SVG needed to support OpenSCAD generation
* `input_file-preview.png` - an image preview of the generated STL
* `input_file-output.stl` - the generated STL model ready for 3D printing