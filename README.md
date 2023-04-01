# File Magic: ColoRIX

This repository contains a magic definition for the [ColoRIX file format](http://fileformats.archiveteam.org/wiki/ColoRIX),
for use with the [file](https://github.com/file/file) and libmagic software.

## File format

While this format is throughly obsolete, it does pop up from time to time
when doing MS-DOS software archaeology. I've used it myself, and it was
used for loading screens in at least one of the original [Fallout games](https://falloutmods.fandom.com/wiki/RIX_File_Format).

The original file-extension was "SCx", where the x encoded the display type
-- separately from the image dimensions in the file -- with "SCI" used
for 320x200 VGA images:

```
Suffix Columns Lines Colors
 D       320    200    16
 E       640    200    16
 F       640    480   256
 I       320    200   256
 K       320    400   256
 P       640    480    16
 Q       360    480   256
 R       640    350    16
 T       640    400    16
```

When used in other contexts, the extension "RIX" was sometimes used, due to it appearing first in the file as the magic marker.

## Overspecification

The official specification contains a number of features that I have _as of yet_ been
unable to verify as supported by any actual software, this includes:

* Support for direct color images.
* Support for indexed images of bit-depths other than 4 and 8 (16 and 256 colors)
* Support for images using the storage types 1 (swizzled planar field) and 3 (text)
* Extensions
* Encryption

This does NOT mean that there is no software that supports these features. Remember,
people used this format in a very 'ad-hoc' manner; just because the official software can't
generate a direct color image, doesn't mean nobody ever generated one themselves.

## Planar modes explained

There are three different planar modes in the specification. These are specified using the lower
nibble of the 'storage byte' (the higher nibble contains flags) at offset 9 in the header.

<dl>
<dt>4 (0100b) - Planar lines (0123)</dt>
<dd>This is the 'default' planar mode. This bits for the palette index are interleaved in lines/rows,
starting with a row of bits for bit 0 (the LSB) of the index, then a row for bit 1 and so on.
For 16 colors there will be four such rows to make up one 'line' of the image.</dd>
<dt>2 (0010b) - Planar field (0123)</dt>
<dd>This stores the bits in the more conventional field form. COLORIX does not support loading
such images, but RIXLATE does.</dd>
<dt>1 (0001b) - Planar field (0213)</dt>
<dd>Based on the specification, this should be a 'swizzled' version of type 2, but I've found
nothing which supports this mode.</dd>
</dl>

### Tests made to verify planar modes

Taking a working 16-color "planar lines" file and changing the header to one of the other planar
modes results in `COLORIX.EXE` saying "Incompatible Screen File" when trying to load them.

Curiously, `RIXLATE.EXE` is capable of reading type 2 images (planar fields). Verified by
converting a type 4 to a type 2, which then displays correctly.

## Usage

It's my goal to eventually contribute it upstream, but till then...

```console
$ file -m rix.magic tests/*.testfile
tests/colorix-linear-256-compressed.testfile:      ColoRIX Image, 320 x 200 x 256 (compressed)
tests/colorix-linear-256.testfile:                 ColoRIX Image, 640 x 480 x 256
tests/colorix-planar-fields-16.testfile:           ColoRIX Image, 640 x 200 x 16, Planar
tests/colorix-planar-lines-16-compressed.testfile: ColoRIX Image, 640 x 200 x 16, Planar lines (compressed)
tests/colorix-planar-lines-16.testfile:            ColoRIX Image, 640 x 200 x 16, Planar lines
tests/colorix-slideshow.testfile:                  ColoRIX Slideshow
```
