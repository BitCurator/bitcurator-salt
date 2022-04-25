#!/bin/bash
# (C) Klaus Knopper Nov 2002
# Reads /proc/partitions, returns table of the form
# basename(devicefile) mountpoint filesystemtype
# Useful for automatic generation of /etc/fstab entries (you
# still may have to add noauto 0 0).

# changes for Kanotix by Stefan Lippers-Hollmann, Joerg Schirottke

[ ! -e /proc/partitions ] && { echo "$0: /proc not mounted, exiting" >&2; exit 1; }

###

if [ -z "$1" ]; then
	partitions=""
	disks=""
	disksize=0
	blocksum=0
	pold="none"

	while read major minor blocks partition relax; do
		partition="${partition#/dev/}"
		[ -z "$partition" -o ! -e "/dev/$partition" ] && continue
		[ "$blocks" -lt 2 ] 2>/dev/null && continue

		case "$partition" in
			?d*|ub*|ataraid/d*|rd/c?d*|cciss/c?d*|mmcblk*)
				disks="$disks $partition"
				disksize="$blocks"
				blocksum=0
				;;
			ram*|cloop*|loop*)
				;; # Kernel 2.6 bug?
			*)
				blocksum="$(($blocksum + $blocks))"
				[ "$blocksum" -gt "$disksize" ] >/dev/null 2>&1 || partitions="$partitions /dev/$partition"
				;;
		esac
	done <<EOT
$(awk 'BEGIN{old="__start"}{if($0==old){exit}else{old=$0;if($4&&$4!="name"){print $0}}}' /proc/partitions)
EOT

	# Add disks without partition table (probably ZIP drives)
	for d in $disks; do
		case "$partitions" in
			*/dev/$d*)
				continue
				;;
		esac
		partitions="$partitions /dev/$d"
	done
else
	partitions="$*"
fi

for p in $partitions; do
	fs="auto"
	# fstype is an external script
	scanfs="$(fstype $p)"
	[ -n "$scanfs" ] && fs="$scanfs"
	mountpoint="/media/${p##*/}"
	[ "$fs" = "swap" ] && mountpoint="none"
	echo "${p}" "${mountpoint}" "${fs}"
done

exit 0

