#!/bin/bash -e
##-------------------------------------------------------------------
## File : remote_copy_backupset.sh
## Author : Denny <denny@dennyzhang.com>
## Description :
## --
## Created : <2014-12-05>
## Updated: Time-stamp: <2016-06-24 20:10:42>
##-------------------------------------------------------------------
# TDOO: move to common library
function log() {
    local msg=$*
    date_timestamp=$(date +['%Y-%m-%d %H:%M:%S'])
    echo -ne "$date_timestamp $msg\n"
    
    if [ -n "$LOG_FILE" ]; then
        echo -ne "$date_timestamp $msg\n" >> "$LOG_FILE"
    fi
}

function current_eth0_ip(){
    echo $(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
}

function shell_exit() {
    if [ $? -eq 0 ]; then
        log "Copy Backup Set is done"
    else
        log "ERROR: Copy Backup Set fail"
        # TODO: send out email
        exit 1
    fi
}

function get_dst_dir() {
    parent_dir="/shared/backup"
    current_ip=$(current_eth0_ip)
    echo "$parent_dir/$current_ip"
}

function nfs_backup() {
    log "Copy backup set by nfs"
    backup_date=${1:-""}
    dst_dir=$(get_dst_dir)
    log "mkdir $dst_dir, if it's missing"
    [ -d "$dst_dir" ] || mkdir -p "$dst_dir"

    log "Perform remote copy"
    if [ -n "$backup_date" ]; then
        find /data/backup -name "*$backup_date*.gz" | xargs -i cp {} "$dst_dir/"
    else
        find /data/backup -name '*.gz' -mtime -1 | xargs -i cp {} "$dst_dir/"
    fi
}

function scp_backup() {
    log "Copy backup set by scp"
    ssh_server=${1?"ssh server ip"}
    backup_date=${2:-""}
    ssh_keyfile=${3:-"/root/.ssh/id_rsa"}
    ssh_user=${4:-"root"}

    dst_dir=$(get_dst_dir)

    log "mkdir $dst_dir, if it's missing"
    ssh "$ssh_user@$ssh_server" "[ -d $dst_dir ] || mkdir -p $dst_dir"

    log "Perform remote copy"
    if [ -n "$backup_date" ]; then
        find /data/backup -name "*$backup_date*.gz" | xargs -i scp -i $ssh_keyfile {} $ssh_user@$ssh_server:/$dst_dir/
    else
        find /data/backup -name '*.gz' -mtime -1 | xargs -i scp -i $ssh_keyfile {} $ssh_user@$ssh_server:/$dst_dir/
    fi
}

trap shell_exit SIGHUP SIGINT SIGTERM 0
LOG_FILE="/var/log/backup.log"
# Choose different backup method
backup_copy_method=${1:-""}
backup_date=${2:-""}
ssh_server=${3:-""}

log "############### remote_copy_backupset.sh: transfer local backup by $backup_copy_method #################"
# root@fluig-id-cust-01:~# cat /data/fluig_state/fluig_rc.d/remote_copy_cfg.sh
# cat /data/fluig_state/fluig_rc.d/remote_copy_cfg.sh
# [ -n "$backup_copy_method" ] || backup_copy_method="scp"
# [ -n "$backup_date" ] || backup_date=`date +'%Y-%m-%d'`
# [ -n "$ssh_server" ] || ssh_server="172.20.16.20"

if [ -f /data/fluig_state/fluig.rc ]; then
    . /data/fluig_state/fluig.rc
fi

if [ "$backup_copy_method" = "nfs" ]; then
    nfs_backup "$backup_date"
else
    if [ "$backup_copy_method" = "scp" ]; then
        if [ -z "$ssh_server" ]; then
            log "ERROR: When backup with scp, ssh_server parameter must be specified"
            exit 1
        fi
        scp_backup "$ssh_server" "$backup_date"
    else
        log "ERROR: backup_copy_method should be specified either nfs or scp"
        exit 1
    fi
fi

## File : remote_copy_backupset.sh ends
