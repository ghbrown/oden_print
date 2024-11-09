## `oden_print`

A command line script to print wirelessly in the Oden Institute at UT Austin from Linux, Mac, or Windows (if you're running Windows Subsystem for Linux).


## Set up

Clone this repository, then place the contents of `oden_print.sh` in your `.bashrc` or `.profile` file and re-`source` that file or start a new terminal session.

### Recommended
Avoid the need to specify a workstation and printer for every print by:
- replacing `username@machine.oden.utexas.edu` with your Sysnet username and machine (for example `jsmith@bernoulli.oden.utexas.edu`)
- replacing `default_printer` with your default printer's name (for example `cp3se`)

Avoid the need to enter your remote user password for SSH by setting up an
[SSH keypair](https://www.oden.utexas.edu/sysdocs/ssh/index.html).


## How to use

Typical usage for users who have done minimal and maximal set-ups are
```bash
# minimal
oden_print -m username@machine.oden.utexas.edu -p cp3se file.pdf
# maximal
oden_print file.pdf
```

Use `oden_print -h` for a full help message.

### Frequently used printing options

To specify printing options supported by `lpr`, make use of the `-t` flag, followed by a string of options surrounded by quotation marks. Note that a `-o` is needed before each option.

```
# Passing lpr options through oden_print
oden_print -t "-o <option1> -o <option2> ..." file.pdf 
```

Check out this [official CUPS documentation](https://www.cups.org/doc/options.html) page for a complete list of standard printing options. The options are listed at the bottom of the page. Here, we list a couple of options that are frequently used by many users.

#### Paper size

Some older printers in POB do not play well with files using non-US-standard paper sizes (e.g. A4), likely due to mismatching between what the printer paper tray is set to and the size specified by the document. The `media` option thus comes in handy to ensure the printer used can handle the file smoothly. For a complete list of available media types, see the CUPS document linked above. For most common purposes, use `Letter`.

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

- `two-sided-long-edge` for portrait orientation,
- `two-sided-short-edge` for landscape orientation,
- `one-sided` if not specified.

```
# Printing on both sides in portrait
oden_print -t "-o sides=two-sided-long-edge" file.pdf
```

## How it works

The script sends files and print commands to an Oden workstation over a multiplexed SSH connection.
Multiplexing allows you to authenticate once, even if you don't have a key pair.


## Miscellaneous

**If you have any trouble with the script or have any improvements let me know.**
