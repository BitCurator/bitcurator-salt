#!/bin/bash
# Calls scanpartitions as root and adds entries to /etc/fstab

PATH="/bin:/sbin:/usr/bin:/usr/sbin"
export PATH
umask 022

sed -i 's/swap swap defaults 0 0/none swap ro,noauto 0 0/g' /etc/fstab
swapoff -a

[ ! -e /proc/partitions ] && { echo "$0: /proc not mounted, exiting" >&2; exit 1; }

if [ -e /var/run/rebuildfstab.pid ]; then
 ps "$(</var/run/rebuildfstab.pid)" >/dev/null 2>&1 && exit 0
 rm -f /var/run/rebuildfstab.pid
fi

echo "$$" >/var/run/rebuildfstab.pid

XSH=""
[ -n "$DISPLAY" ] && XSH="rxvt -bg black -fg green -cr red -T $0 -e"

[ "`id -u`" != "0" ] && { exec $XSH sudo $0 "$@"; }


TMP="/tmp/fstab.$$.tmp"
ADDEDBYCAINE="# Inserito da CAINE"

# Simple shell grep, searches for lines STARTING with string
stringinfile(){
while read line; do
case "$line" in $1*) return 0;; esac
done <"$2"
return 1
}

removeentries(){
while read line; do
case "$line" in $1) read line; continue ;; esac
echo "$line"
done <"$2"
}

verbose=""
remove=""
user=""
group=""
arg="$1"
while [ -n "$arg" ]; do
 case "$arg" in
  -v*) verbose="yes" ;;
  -r*) remove="yes" ;;
  -u*) shift; user="$1" ;;
  -g*) shift; group="$1" ;;
  *) echo "Usage: $0 [-v[erbose]] [-r[emove_old]] [-u[ser] uid] [ -g[roup] gid]" ;;
 esac
 shift
 arg="$1"
done

[ -n "$verbose" ] && echo "Scanning for new harddisks/partitions..." >&2
rm -f "$TMP"

if [ -n "$remove" ]; then
 removeentries "$ADDEDBYCAINE" /etc/fstab >"$TMP"
else
 cat /etc/fstab >"$TMP"
fi

count=0
while read device mountpoint fstype relax; do
 stringinfile "$device " "$TMP" || \
 { count="$((count + 1))"
   [ -d "$mountpoint" ] || mkdir -p "$mountpoint" 2>/dev/null
    options="ro,loop,noauto,user,noexec,nodev,noatime,noload"
    case "$fstype" in
    ntfs) options="${options},umask=000" ;;
    msdos) options="${options},umask=000,quiet" ;;
    vfat) options="${options},umask=000,shortname=mixed,quiet" ;;
    ext) options="${options}" ;;
    ext2) options="${options}" ;;
    ext3) options="${options}" ;;
    ext4) options="${options}" ;;
    xfs) options="norecovery,${options}" ;;
    jfs) options="nointegrity,${options}" ;;
    reiserfs) options="nolog,${options}" ;;
    hfs) options="${options}" ;;
    hfsplus) options="${options}" ;;
    #swap) options="sw" ;;
   esac
   case "$fstype" in
   ntfs|vfat|msdos)
   [ -n "$user" ] && options="$options,uid=$user"
   [ -n "$group" ] && options="$options,gid=$group"
   ;;
   esac
   echo "$ADDEDBYCAINE"
   #echo "$device $mountpoint $fstype $options 0 0"; }
   if [ "$fstype" = "ext3" || "$fstype" = "ext4" ]
   then
       fstype="ext4"
   fi
   if [ "$fstype" = "hfs" ]
   then
       fstype="hfsplus"
   fi
   printf "%-15s %-15s %-7s %-15s %-7s %s\n" "$device" "$mountpoint" "$fstype" "$options" "0" "0"; }
done >>"$TMP" <<EOT
$(scanpartitions)
EOT

[ -n "$verbose" ] && { [ "$count" -gt 0 ] && echo "Adding $count new partitions to /etc/fstab." >&2 || echo "No new partitions found." >&2; }
mv -f "$TMP" /etc/fstab

rm -f /var/run/rebuildfstab.pid

[ -n "$DISPLAY" ] && sleep 2

exit 0
