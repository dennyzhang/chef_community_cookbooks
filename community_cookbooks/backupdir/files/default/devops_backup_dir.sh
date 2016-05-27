#!/bin/bash -e
##-------------------------------------------------------------------
## File : devops_backup_dir.sh
## Author : Denny <denny@dennyzhang.com>
## Description : Backup directory and tar it with timestamp
## --
## Created : <2015-01-22>
## Updated: Time-stamp: <2016-04-05 09:45:02>
##-------------------------------------------------------------------
function log()
{
    local msg=${1?}

    echo -ne `date +['%Y-%m-%d %H:%M:%S']`" $msg\n"

    if [ -n "$LOG_FILE" ]; then
        echo -ne `date +['%Y-%m-%d %H:%M:%S']`" $msg\n" >> $LOG_FILE
    fi
}

function tar_dir()
{
    local dir=${1?}
    local tar_file=${2?}
    working_dir=`dirname $dir`
    cd $working_dir
    log "tar -zcf $tar_file `basename $dir`"
    tar -zcf $tar_file `basename $dir`
}

function current_time()
{
    echo `date '+%Y-%m-%d-%H%M%S'`
}

function ensure_is_root() {
    # Make sure only root can run our script
    if [[ $EUID -ne 0 ]]; then
        echo "Error: This script must be run as root." 1>&2
        exit 1
    fi
}

function shell_exit() {
    if [ $? -eq 0 ]; then
        log "Backup operation is done"
    else
        log "ERROR: Backup operation fail"
        # TODO: send out email
        exit 1
    fi
}

function get_dst_dir() {
    local service_name=${1?}
    local dir="/data/backup/$service_name/${timestamp}"
    [ -d $dir ] || mkdir -p $dir
    echo $dir
}

function clean_old_backup() {
    log "Clean up old backup"

    declare -a dst_dir_list=(
        "/data/backup/nagios_rrd:10" # subdirectories older than 10 days will be deleted
        "/data/backup/log_backup:5"
    )

    for item in ${dst_dir_list[*]}; do
        dst_dir=${item%:*}
        retention_day=${item#*:}
        if [ -d $dst_dir/ ]; then
            find $dst_dir -mtime +$retention_day -and -not -type d -delete
        fi
    done;
}

######################### Backup Functions #########################
function backup_config() {
    local dst_dir=$(get_dst_dir "config")
    log "Backup config to $dst_dir.tar.gz"
    declare -a config_dir_list=(
        "/etc/ssl" "/etc/apache2"
        "/etc/httpd" "/etc/libapache2-mod-jk"
        "/cloudpass/backend/build/config")
    for config_dir in ${config_dir_list[*]}; do
        [ ! -d $config_dir ] || /bin/cp -r $config_dir $dst_dir
    done

    tar_dir $dst_dir ${dst_dir}_config.tar.gz && rm -rf $dst_dir
}

# Example:
# /usr/local/bin/fluig_backup.sh all
# /usr/local/bin/fluig_backup.sh couchbase
ensure_is_root
trap shell_exit SIGHUP SIGINT SIGTERM 0

timestamp=$(current_time)
# Clean up old backup for retention
clean_old_backup

# TODO: perform restore test for backup set

# TODO rsync backup set to a new server

## File : devops_backup_dir.sh ends
