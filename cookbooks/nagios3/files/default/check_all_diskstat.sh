#!/bin/bash
# https://exchange.nagios.org/directory/Plugins/Operating-Systems/Linux/Check-IO-stats-of-one-or-all-disks/details
WARN=${1:-"200,10000,10000"}
CRIT=${2:-"300,20000,20000"}
CHK=${3:-""}
if [ -z "$CHK" ] && [ -f /usr/lib64/nagios/plugins/check_diskstat.sh ]; then
   CHK="/usr/lib64/nagios/plugins/check_diskstat.sh"
fi
   
if [ -z "$CHK" ] && [ -f /usr/lib/nagios/plugins/check_diskstat.sh ]; then
   CHK="/usr/lib/nagios/plugins/check_diskstat.sh"
fi

if [ -z "$CHK" ]; then
    echo "ERROR: check_diskstat.sh is not found"
    exit 1
fi

for DEVICE in `ls /sys/block`; do
	if [ -L /sys/block/$DEVICE/device ]; then
		DEVNAME=$(echo /dev/$DEVICE | sed 's#!#/#g')
		echo -n "$DEVNAME: "
		$CHK -d $DEVICE -w $WARN -c $CRIT | sed "s#=#_$DEVNAME=#g"
	fi
done
