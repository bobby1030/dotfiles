function _scancel {
    SQUEUE_OUTPUT=$(squeue -o "%i:%j" -u $USER | grep -v "JOBID:NAME")
    SCANCEL_COMMANDS=(
        '--signal=:Signal type (USR1, USR2, INT etc.)'
        '--batch:Send signal to all batch steps'
    )
    
    while IFS= read -r line; do
        if [[ ! -z $line ]]; then
            SCANCEL_COMMANDS+=("$line")
        fi
    done <<< "$SQUEUE_OUTPUT"
    SCANCEL_COMMANDS_STR=$(printf "\n'%s'" "${SCANCEL_COMMANDS[@]}")
    eval "_describe 'command' \"($SCANCEL_COMMANDS_STR)\""
}

compdef _scancel "scancel"

function slurmlogpath { scontrol show job $1 | grep StdOut | sed -e 's/^\s*StdOut=//' }

function ftails { 
    JOBID=$1
    if [[ -z $JOBID ]]; then
        JOBS=$(squeue --format="%i \\'%j\\' " -u $USER | grep -v JOBID)
        NUMBER_OF_JOBS=$(echo "$JOBS" | wc -l)
        JOBID=
        if [[ "$NUMBER_OF_JOBS" -eq 1 ]]; then
            JOBID=$(echo $JOBS | sed -e "s/'//g" | sed -e 's/ .*//')
        else
            JOBS=$(echo $JOBS | tr -d '\n')

            JOBID=$(eval "whiptail --title 'Choose jobs to tail' --menu 'Choose Job to tail' 25 78 16 $JOBS" 3>&1 1>&2 2>&3)
        fi
    fi
    SLURMLOGPATH=$(slurmlogpath $JOBID)
    if [[ -e $SLURMLOGPATH ]]; then
        tail -n100 -f $SLURMLOGPATH
    else
        echo "No slurm-log-file found"
    fi
}
