#!/bin/bash -e
##-------------------------------------------------------------------
## File : disable_oom.sh
## Author : Denny <denny@dennyzhang.com>
## Description :
## --
## Created : <2015-12-28>
## Updated: Time-stamp: <2016-06-10 18:09:56>
##-------------------------------------------------------------------
# TODO: move the code out of this repo
pid_file=${1?}

function log() {
    local msg=$*
    date_timestamp=$(date +['%Y-%m-%d %H:%M:%S'])
    echo -ne "$date_timestamp $msg\n"
    
    if [ -n "$LOG_FILE" ]; then
        echo -ne "$date_timestamp $msg\n" >> "$LOG_FILE"
    fi
}

if [ ! -f "$pid_file" ]; then
    log "Error $pid_file doesn't exist"
    exit 1
fi

pid=$(cat "$pid_file")
if [ ! -d "/proc/$pid" ]; then
    log "Warning: process($pid) is not alive"
    exit 0
fi

# http://backdrift.org/oom-killer-how-to-create-oom-exclusions-in-linux
log "disable oom for $pid"
echo -17 > "/proc/$pid/oom_adj"

## File : disable_oom.sh ends
