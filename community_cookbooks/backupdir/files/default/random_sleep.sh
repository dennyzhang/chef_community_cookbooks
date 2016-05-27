#!/bin/bash -e
##-------------------------------------------------------------------
## File : random_sleep.sh
## Author : Denny <denny@dennyzhang.com>
## Description :
## --
## Created : <2014-12-05>
## Updated: Time-stamp: <2016-04-05 09:45:02>
##-------------------------------------------------------------------
function log() {
    local msg=${1?}
    echo -ne `date +['%Y-%m-%d %H:%M:%S']`" $msg\n"

    if [ -n "$LOG_FILE" ]; then
        echo -ne `date +['%Y-%m-%d %H:%M:%S']`" $msg\n" >> $LOG_FILE
    fi
}

function sleep_random_seconds(){
    # Avoid all crontab from different machines run the same at the same time
    max_seconds=${1?}
    if [ $max_seconds -ne 0 ]; then
        seconds=$((RANDOM % $max_seconds))
        if [ $seconds -ne 0 ]; then
            log "sleep $seconds"
            sleep $seconds
        fi
    fi
}

LOG_FILE="/var/log/backup.log"
# Avoid all crontab from different machines run backup and copy tasks at the same time
max_random_sleep=${1:-300} # seconds.

sleep_random_seconds $max_random_sleep
## File : random_sleep.sh ends
