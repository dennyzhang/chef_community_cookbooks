#!/bin/bash
# TODO: move the code out of this repo
# http://unix.stackexchange.com/questions/17936/setting-proc-sys-vm-drop-caches-to-clear-cache
echo "Free cached memory, so that OS can have more free memory"

pre_memory=$(free -ml)
echo "$pre_memory" | cat

echo 3 | sudo tee /proc/sys/vm/drop_caches

pre_memory=$(free -ml)
echo "$pre_memory" | cat
