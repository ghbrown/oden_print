## `oden_print`

A command line script to print wirelessly in the Oden Intitute at UT Austin from Linux, Mac, or Windows (if you're running Windows Subsystem for Linux).

## Set up

Clone this repository, then place the contents of `oden_print.sh` in your `.bashrc` or `.profile` file and re-`source` that file or start a new terminal session.

**Make sure your personal workstation is always on** (it should be anyway, but the script won't work if it's off).

**Recommended**: This will ensure you don't have to specify a workstation and printer for every print:
- in the copied text, replace `username@machine.oden.utexas.edu` with your sysnet username and machine (for example `jsmith@bernoulli.oden.utexas.edu`)
- in the copied text, replace `default_printer` with your default printer's name


## How to use

Typical usage for users who have done minimal and maximal set up are
```bash
# minimal
oden_print -m username@machine.oden.utexas.edu -p cp3se file.pdf
# maximal
oden_print file.pdf
```

To get a list of available printers and their name use `oden_print -l`.

Use `oden_print -h` for a full help message.


## How it works

It tunnels into your workstation via SSH and runs a print command on a file that gets forwarded over SSH.
It's basically a one-liner (with some wrappings for convenience and usability).


## Miscellaneous

Without any SSH configurations, you'll have to enter your remote machine password for every file you print.
To avoid this, [set up an SSH keypair](https://www.oden.utexas.edu/sysdocs/ssh/index.html).

**If you have any trouble with the script or have any improvements let me know.**
