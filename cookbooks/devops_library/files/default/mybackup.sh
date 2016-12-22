#!/bin/bash -e
mybackup() {
    src_file=${1?"What files to backup"}

    # get default value from environment variable
    if [ -n "$BAK_ROOT_DIR" ]; then
        bak_root_dir="$BAK_ROOT_DIR"
    else
        bak_root_dir="/data/backup"
    fi

    parent_dir=$(dirname "$src_file")
    short_fname=$(basename "$src_file")
    date="$(date +'%Y%m%d.%H%M%S')"
    bak_dir="${bak_root_dir}$parent_dir"
    if [ -f "$src_file" ]; then
        mkdir -p "$bak_dir"
        echo "cp $src_file ${bak_dir}/${short_fname}-${date}"
        cp "$src_file" "${bak_dir}/${short_fname}-${date}"
    elif [ -d "$src_file" ]; then
        mkdir -p "$bak_dir-${short_fname}-${date}"
        echo "cp -r $src_file $bak_dir-${short_fname}-${date}"
        cp -r "$src_file" "$bak_dir-${short_fname}-${date}"
    else
        echo "Error: $src_file doesn't exist"
        exit 1
    fi
}
