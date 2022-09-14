## `oden_print`

A command line script to print wirelessly in the Oden Intitute at UT Austin from Linux, Mac, or Windows (if you're running Windows Subsystem for Linux).


## How to set up

- place the contents of `oden_print.sh` in your `.bashrc` or `.profile` file
- in the copied text replace `<username>` with your sysnet username (for example `jsmith`), `<machine name>` with your machine's name (for example `bernoulli`), and `<printer name>` with your default printer's name
- re-`source` the file you just edited or start a new terminal session
- **make sure your personal workstation is always on** (it should be anyway, but the script won't work if it's off)


## How to use

- `oden_print -h` : help message
- `oden_print -l` : list available printers on network
- `oden_print -d` : list your default printer
- `oden_print -m` : list your ssh machine 
- `oden_print -# N printer_name file_to_print` : prints N copies of `file_to_print` on printer `printer_name`
- `oden_print printer_name file_to_print` : prints `file_to_print` on printer `printer_name`

Note that calling without specifying a printer will print on `<printer name>` 

## How it works

It tunnels into your workstation via SSH and runs a print command on a file that gets forwarded over SSH.
It's basically a one-liner (with some wrappings for convenience and usability).


## Miscellaneous

Without any SSH configurations, you'll have to enter your remote machine password every time you print.
To avoid this, [set up an SSH keypair](https://www.oden.utexas.edu/sysdocs/ssh/index.html).

**If you have any trouble with the script or have any improvements let me know.**
Improvements for print configuratins (double sided, etc.) may be coming soon.
