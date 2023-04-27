function oden_print {
    # print to an Oden printer wirelessly via SSH to workstation
    machine=username@machine.oden.utexas.edu   # users hardcode here (optional)
    printer=default_printer                    # users hardcode here (optional)

    pos_args=    # positional arguments string
    through=     # flags and options to be passed through directly to lpr
    while [ ${#} -gt 0 ]; do
        case ${1} in 
	        -h | --help)     
        	    echo ''
        	    echo 'usage: oden_print [options] files'
        	    echo 'If no printer or machine is specified, then the defaults are used'
		        echo 'flags: -h / --help,     help'
        	    echo '       -d / --defaults, list default printer and machine'
        	    echo '       -l / --list,     list available printer names'
		        echo '       -m / --machine,  specify machine/workstation for ssh' 
		        echo '       -p / --printer,  specify printer' 
                echo '       -t / --through,  flags and options to be passed through to lpr'
                echo ''
                echo 'Example: use machine mandelbrot to print foo.pdf on cp3se'
                echo '         (two copies, single sided):'
                echo '  oden_print -m user@mandelbrot.oden.utexas.edu -p cp3se -t "-# 2 -o sides=one-sided" foo.pdf'
        	    echo ''
                return 0
    	        ;; 
            -d | --show-defaults)
                echo ''
                echo "default printer is:             ${printer}"
                echo "default machine/workstation is: ${machine}"
                echo ''
                return 0
                ;; 
            -p | --printer)  # set printer
                printer=${2}
                shift
                shift
                ;;
	        -m | --machine)  # set machine
                machine=${2}
                shift
                shift
                ;; 
	        -l | --list)  # list available printers
                ssh ${machine} lpstat -p
                return 0
                ;; 
            -t | --through) # multiple arguments to be passed to lpr
                through=${2}
                shift
                shift
                ;;
            -* | --*)
                >&2 echo "oden_print: unknown option ${1}"
                return 1
                ;;
	        *)
                pos_args+="${1} "  # save positional arguments
                shift
                ;;
            esac
    done

    if [ -z "${pos_args}" ]; then
        >&2 echo "oden_print: no files to print"
        return 1
    fi

    # Both of:
    #   [usual commands] <(cat ${pos_args})
    #   cat ${pos_args} | [usual commands]
    # result in only one file being printed if there is more than one
    # positional argument (file to print), so using for loop for now.
    # Could perhaps use scp and tar to place these files in the
    # remote /tmp directory to avoid multiple credentials checks.
    for file in $(echo ${pos_args}); do
        ssh ${machine} lpr -P ${printer} ${through} < ${file}
    done
}


