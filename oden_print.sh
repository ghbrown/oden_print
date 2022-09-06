function oden_print {
    # print to an Oden printer wirelessly via SSH to workstation
    # first argument: printer name
    # other arguments: files to be printed 
    machine=<username>@<machine name>.oden.utexas.edu # users hardcode here
    if [[ "$1" == "-h" ]]; then
        echo ''
        echo 'usage: oden_print <printer> <files to print>'
        echo 'flags: -h, help'
        echo '       -l, list printer names'
        echo ''
    elif [[ "$1" == "-l" ]]; then
        ssh ${machine} lpstat -p
    else
        printer=$1
        shift # discard first argument, $2 is now $1
        ssh ${machine} lpr -P ${printer} < "$@"
    fi
}
