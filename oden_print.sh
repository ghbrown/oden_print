function oden_print {
    # print to an Oden printer wirelessly via SSH to workstation
    machine=username@machine.oden.utexas.edu   # users hardcode here (optional)
    printer=default_printer                    # users hardcode here (optional)

    pos_args=()  # positional arguments array
    through=     # flags and options to be passed through directly to lpr
    reached_pos_args=0
    while [ ${#} -gt 0 ]; do
        case "${1}" in
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
            -d | --defaults)
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
                pos_args+=("${1}")  # save positional arguments
                shift
                ;;
            esac
    done

    if [ -z "${pos_args}" ]; then
        >&2 echo "oden_print: no files to print"
        return 1
    fi

    # print over SSH
    ## set up multiplexed connection
    timestamp=$(date +%Y%m%d%H%M%S)
    mux_control_path="/tmp/oden_print_ssh_mux_${timestamp}"  # local file
    remote_dir="/tmp/oden_print_files_${timestamp}"          # remote directory
    ssh -f -N -o ControlMaster=auto -o ControlPath=${mux_control_path} -o ControlPersist=60s ${machine}
    echo "  set up connection"
    ## move files to temporary location on remote
    ssh -o ControlPath=${mux_control_path} ${machine} mkdir -p ${remote_dir}
    scp -o ControlPath=${mux_control_path} "${pos_args[@]}" "${machine}:${remote_dir}" \
        1> /dev/null
    echo "  copied files to remote"
    ## print
    ### careful escaping to expand some variables on local machine and some on remote
    ### note that both  find -exec lpr  and  lpr ${remote_dir}/*  don't work for some
    ###   reason (possibly Oden specific?), so resort to for loop over SSH
    ssh -o ControlPath=${mux_control_path} ${machine} \
        "for f in ${remote_dir}/*; do lpr -P ${printer} -o fit-to-page ${through} \"\${f}\"; done"
    echo "  sent print job to ${printer}"
    ## tidy up, shut down connection
    ssh -o ControlPath=${mux_control_path} ${machine} \rm -rf ${remote_dir}
    ssh -O exit -o ControlPath=${mux_control_path} ${machine} &> /dev/null
    echo "  shut down connection"
}
