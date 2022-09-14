unction oden_print {
    # print to an Oden printer wirelessly via SSH to workstation
    # first argument: printer name
    # other arguments: files to be printed 
    default=<default printer> 
    machine=<default machine> # users hardcode here
    copies=1

    case $1 in 
    #flags for information 	   
	"-h")     
        	echo ''
        	echo 'usage: oden_print <printer> <files to print>'
        	echo 'If no printer is specified, then default printer is used'
		echo 'If no number of copies are specified, then default is 1'  
		echo 'flags: -h, help'
        	echo '       -l, list printer names'
		echo ' 	     -d, list default printer'
		echo '	     -m, list machine used for ssh' 
		echo '       -#, set number of copies'
        	echo ''
    	;; 
    
    
    	"-d") 	echo $default ;; 
	"-m")	echo $machine ;; 
	"-l") 	ssh ${machine} lpstat -p ;; 
	*)	
		if [[ "$1" == "-#" ]]; then
			copies=$2
			shift 
			shift
    		fi 	
		if [[ $# == 1 ]]; then 
			printer=$default 
		else 
			printer=$1
			shift 
		fi
        	ssh ${machine} lpr -P ${printer} -# $copies  < "$@" 
	;;
    esac	   
}


