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


## How it works

The script sends files and print commands to an Oden workstation over a multiplexed SSH connection.
Multiplexing allows you to authenticate once, even if you don't have a key pair.


## Miscellaneous

**If you have any trouble with the script or have any improvements let me know.**
