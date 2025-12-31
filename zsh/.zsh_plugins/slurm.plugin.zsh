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

###############
# SINFO aliases
###############
# Detailed sinfo
alias si="sinfo -o '%8P %10n %.11T %.4c %.8z %.6m %12G %10l %10L %10O %20E' -S '-P'"
################
# SQUEUE aliases
################
# Detailed squeue
alias sq="squeue -Su -o '%8i %10u %20j %4t %5D %20R %12b %3C %7m %11l %11L'"
# squeue only your jobs
alias squ="sq -u `id -un`"
# SSTAT alias to get information about your RUNNING jobs Usage: sst <jobid> OR sst <jobid>.batch (if you use 
#     SBATCH and do not use SRUN inside)
alias sst='sstat --format=JobID,NTasks,AveCPU,AveCPUFreq,AveRSS,MaxRSS -j'
