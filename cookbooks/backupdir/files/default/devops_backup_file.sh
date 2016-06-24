#!/bin/bash -e
##-------------------------------------------------------------------
## File : devops_backup_file.sh
## Author : Denny <denny@dennyzhang.com>
## Description : If given file is changed, do a backup; Otherwise skip
## --
## Created : <2015-01-22>
## Updated: Time-stamp: <2016-06-24 20:15:26>
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

function backup_file() {
    local src_file=${1?}
    local base_filename=$(basename "$src_file")
    # local src_modify_time=$(stat -c "%Y" "$src_file")

    local dst_dir="/data/backup/$base_filename"
    local dst_file="$dst_dir/$base_filename"
    local dst_file_gz="$dst_dir/$base_filename-${timestamp}.tar.gz"
    local new_cksum=$(cksum $src_file | awk -F' ' '{print $1}')

    [ -d $dst_dir ] || mkdir -p $dst_dir

    log "Compare modify time, to see whether need to backup $src_file"

    if [ ! -f "$dst_file" ]; then
        log "Copy to $dst_file,and compress as $dst_file_gz"
        /bin/cp "$src_file" "$dst_file"
        echo "$new_cksum" > "$dst_dir/cksum.txt"
        tar_dir "$dst_file" "$dst_file_gz"
    else
        old_cksum=$(cat $dst_dir/cksum.txt)
        if [ $new_cksum != $old_cksum ]; then
            log "Update $dst_file, and compress as $dst_file_gz"
            /bin/cp "$src_file" "$dst_file"
            echo "$new_cksum" > "$dst_dir/cksum.txt"
            tar_dir "$dst_file" "$dst_file_gz"
        fi
    fi
}

######################### Helper Functions #########################
function ensure_is_root() {
    # Make sure only root can run our script
    if [[ $EUID -ne 0 ]]; then
        echo "Error: This script must be run as root." 1>&2
        exit 1
    fi
}

function tar_dir()
{
    local dir=${1?}
    local tar_file=${2?}
    working_dir=$(dirname "$dir")
    cd "$working_dir"
    tar -zcf "$tar_file" "$working_dir"
}

function current_time()
{
    date '+%Y-%m-%d-%H%M%S'
}

####################################################################
ensure_is_root

# Example:
# /usr/local/bin/backup_file.sh /data/somecritical.dat
src_file=${1?"which file to monitor and backup"}
timestamp=$(current_time)
if [ -f "$src_file" ]; then
    backup_file "$src_file"
else
    log "Warning: $src_file doesn't exist"
fi

## File : devops_backup_file.sh ends
