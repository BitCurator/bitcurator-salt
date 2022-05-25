#!/bin/bash

# To be run on login by autostart

# Trust the installer icon
gio set $HOME/Desktop/ubiquity.desktop "metadata::trusted" yes

# Trust everything else on the default desktop
gio set $HOME/Desktop/Additional\ Tools/antiword.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/bcreport.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/bless.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/clamtk.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/fido.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/fiwalk.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/ghex.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/gtkhash\:gtkhash.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/hardinfo.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/hfs.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/identfile.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/nwipe.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/readpst.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Additional\ Tools/vlc.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/BEViewer.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/bcdat.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/bcgui.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/bcmnt.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/brunnhilde.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/disktype.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/fiwalk.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/fslint.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/hashdb.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/md5deep.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/photorec.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/pyexiftoolgui.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/regripper.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/sdhash.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/ssdeep.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Forensics\ and\ Reporting/testdisk.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Imaging\ and\ Recovery/cdrdao.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Imaging\ and\ Recovery/clonezilla.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Imaging\ and\ Recovery/dcfldd.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Imaging\ and\ Recovery/dd.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Imaging\ and\ Recovery/ddrescue.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Imaging\ and\ Recovery/dumpfloppy.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Imaging\ and\ Recovery/ewfacquire.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Imaging\ and\ Recovery/guymager.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Packaging\ and\ Transfer/bagit-python.desktop "metadata::trusted" yes
gio set $HOME/Desktop/Packaging\ and\ Transfer/grsync.desktop "metadata::trusted" yes

