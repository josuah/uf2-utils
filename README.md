# UF2 utils

A toolbox for working with the UF2 format,
split out from the [`pico-ice-sdk`](pico_ice_sdk.html)
from where they were first written.

They can be used for:

- converting the binary file with the bitstream to send to the FPGA flash,
- loading custom data at a chosen address in the flash,
- converting the current content of the flash back to a binary file,
- debugging and inspecting UF2 files of various kinds

In firmware using the pico-ice-sdk,
an USB disk named ``pico-ice`` provides a file named ``CURRENT.UF2`` with the content of the flash,
and permits to load new UF2 files that will program the flash chip.

To install them:

```shell
git clone https://github.com/josuah/uf2-utils/
cd uf2-utils && sudo make install
```

---

## `bin2uf2`

```
usage: bin2uf2 [-f familyID] [-o file.uf2] file.bin
usage: bin2uf2 [-f familyID] [-o file.uf2] [0x01230000 file.bin]...
```

Produce an UF2 formatted file as a result of one or multiple binary input files.

### `-f familyID`

Set the ``familyID`` field of UF2 to something else than the default ``0x792e7263`` used for the pico-ice.

### `option:: -o file.uf2`

Output file to which UF2 data is written.
If ommited, stdout is used.

### `file.bin`

When there is a single argument after the flags, it is interpreted as
the path toward a binary file that will be converted into an UF2 file,
mapped at address 0x00000000.

### `[0x01230000 file.bin]...`

When there are more than 1 argument after the flags, they must be grouped by pairs, with:

* first, the address at which to write the data, i.e. here ``0x01230000``,
* after, the path to the file which contains the data, i.e. here ``file.bin``, use ``-`` for stdin.

---

## `uf22bin`

```
usage: uf22bin [-a 0x01230000] [-o file.bin] [file.uf2]
```

Decode a single UF2 input file and write the output as a plain binary.
An optional offset permits to avoid large files composed of only NUL bytes (0x00).

### `-o file.bin`

Output file to which the decoded binary data is written.
If ommited, the stdout is used.
This file must be seekable like normal files are.
If stdout is used, it need to be redirected to a file (``... >file.bin``).

### `-a 0x01230000`

Offset address in the input file.
Blocks with addresses from 0x00000000 up to the specified address will be skipped,
and the first byte of the output file will contain the data at that specified address.

### `file.uf2`

Input file from which the data is read.

---

## `uf2dump`

```
usage: uf2dump [file.uf2]
```

Dump the content of an UF2 file as human-readable text for inspection and debugging purposes.

### `file.uf2`

Input file containing the UF2 data.
If ommited, stdin is used.
