# File Magic: ColoRIX

This repository contains a magic definition for the [ColoRIX file format](http://fileformats.archiveteam.org/wiki/ColoRIX),
for use with the [file](https://github.com/file/file) and libmagic software.

## File format

While this format is throughly obsolete, it does pop up from time to time
when doing MS-DOS software archaeology. I've used it myself, and it was
used for loading screens in at least one of the original [Fallout games](https://falloutmods.fandom.com/wiki/RIX_File_Format).

The original file-extension was "SCx", where the x encoded the display type,
with "SCI" used for 320x200 VGA images. When used in other contexts, the extension
"RIX" was sometimes used, due to it appearing first in the file as the magic marker.

## Usage

It's my goal to eventually contribute it upstream, but till then...

```console
$ file -m rix.magic tests/*.testfile
tests/rix1.testfile: ColoRIX Image, 320 x 200 x 256
tests/rix2.testfile: ColoRIX Image, 320 x 200 x 256 (compressed)
tests/rix3.testfile: ColoRIX Image, 640 x 200 x 16, Planar lines (0123)
tests/rix4.testfile: ColoRIX Image, 256 x 64 x 256
```
