The following scripts have been removed from the locations shown below as they use gksu, which is deprecated in Ubuntu 18.04LTS. They may be candidates for rewrite/update or replacement, depending on the use case. They've been moved here for the time being.


Script; env/usr/local/bin/Safe Mount:
Relevant command: gksudo -m "$MESSAGE" "echo -n"

Script: env/usr/local/bin/fmount-gui.sh:
Relevnat command: gksu -k -S -m "Enter root password to continue" -D "fmount-gui requires root user priveleges to mount disk images." echo

Script: env/.local/share/nautilus/scripts/Safe Mount:
Relevant command: gksudo -m "$MESSAGE" echo >/dev/null

Script: env/.local/share/nautilus/scripts/Find Files/Find Deleted Files Here
Relevant command: gksu -k -m "Enter password for administrative access." /bin/echo

Script: env/.local/share/nautilus/scripts/Open Browser as Root
Relevant command: gksu nautilus "$(pwd)"