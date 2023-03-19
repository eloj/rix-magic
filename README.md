# File Magic: ColorRIX

This repository contains a magic definition for the
ColorRIX VGA file format, for use with the [file](https://github.com/file/file)
and libmagic software.

## File format

While this format is throughly obsolete, it does pop up from time to time
when doing MS-DOS software archaeology. I've used it myself, and it was
used for loading screens in at least one of the original Fallout games.

The original file-extension was "SCx", where the x encoded the display type,
with "SCI" used for 320x200 VGA images. When used in other contexts, the extension
"RIX" was sometimes used, due to it appearing first in the file as the magic marker.

## Usage

It's my goal to eventually contribute it upstream, but till then you
can pass `-m rix.magic` to `file`.
