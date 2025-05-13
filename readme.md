## `oden_print`

A command line script to print wirelessly in the Oden Institute at UT Austin from Linux, Mac, or Windows (if you're running Windows Subsystem for Linux).


## Set up

Clone this repository then add the following lines to your `.bashrc` or `.profile` file

```
ODEN_PRINT_MACHINE=<your username and machine, e.g jsmith@bernoulli.oden.utexas.edu>
ODEN_PRINT_PRINTER=<your preferred printer, e.g. cp3se; use -l flag for full list>
source /path/to/oden_print.sh
```

This defines variables used by the script and then loads the script when your terminal starts.
Now re-`source` the file or start a new terminal session.

It is also recommended to setup an
[SSH keypair](https://www.oden.utexas.edu/sysdocs/ssh/index.html)
to avoid having to enter your remote user password.


## How to use

Typical usages for users who have done minimal and maximal setup are
```bash
# minimal, not even machine and printer are set
oden_print -m username@machine.oden.utexas.edu -p cp3se file.pdf
# maximal
oden_print file.pdf
```

Use `oden_print -h` for a full help message.

### Frequently used printing options

To get help of course use `oden_print -h`, and to get a list of available printers use `oden_print -l`.

To specify printing options supported by `lpr` use the `-t` flag followed by a string of options surrounded by quotation marks.
Note that a `-o` is needed before each option.

```
# Passing lpr options through oden_print
oden_print -t "-o <option1> -o <option2> ..." file.pdf 
```

Please see the `man` page of `lpr` for documentation on available printing options. Alternatively, check out the [official CUPS documentation](https://www.cups.org/doc/options.html). The options are listed at the bottom of the page. Here we review some of the most common options.

#### Paper size

Some older printers in POB do not play well with files using non-US-standard paper sizes (e.g. A4), likely due to mismatching between what the printer paper tray is set to and the size specified by the document. The `media` option thus comes in handy to ensure the printer used can handle the file smoothly. For a complete list of available media types, see the `man` page of `lpr` or the CUPS documentation linked above. For most purposes, use `Letter`.

```
# Using Letter sized paper
oden_print -t "-o media=Letter" file.pdf 
```

#### Print orientation

To print the document in landscape orientation, add `-o landscape` to the passthrough string. The default behavior is to print in portrait orientation.
```
# Printing in landscape
oden_print -t "-o landscape" file.pdf
```

#### Double-sided printing

To print a document on both sides of the paper, add `-o sides=<side-options>` to the passthrough string. Available options are

- `two-sided-long-edge` for double-sided printing in portrait orientation,
- `two-sided-short-edge` for double-sided printing in landscape orientation,
- `one-sided` for single-sided printing.

```
# Printing on both sides in portrait
oden_print -t "-o sides=two-sided-long-edge" file.pdf
```

## How it works

The script sends files and print commands to an Oden workstation over a multiplexed SSH connection.
Multiplexing allows you to authenticate once, even if you don't have a key pair.


## Miscellaneous

**If you have any trouble with the script or have any improvements let me know.**
