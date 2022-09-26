#!/usr/bin/env python3
#
# BitCurator Mounter and Read/Write Application Indicator
# Unity Application Indicator
# Verstion: 0.2
#
# Author: Kam Woods
# https://wiki.ubuntu.com/DesktopExperienceTeam/ApplicationIndicators
# License: GPL v3
#
# Requires Python >3.0
# Additional information at http://wiki.bitcurator.net/

import gi
gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')

from gi.repository import AppIndicator3 as appindicator
from gi.repository import Gtk as gtk
import subprocess
import os, sys
import bc_mounter

class PolicyDialog(gtk.Dialog):

    def __init__(self, dialog_message):
        gtk.Dialog.__init__(self, "System Mount Policy", None, 0)
        self.add_buttons(gtk.STOCK_CANCEL, gtk.ResponseType.CANCEL,
             gtk.STOCK_OK, gtk.ResponseType.OK)

        self.set_border_width(6)
        self.set_default_size(500, 150)

        # Set label with the warning (RO or RW)
        label = gtk.Label.new(dialog_message)

        box = self.get_content_area()
        box.add(label)
        self.show_all()

class MounterAppIndicator:

    def __init__(self):
        self.ind = appindicator.Indicator.new("Mounter Indicator",
        "indicator-messages", appindicator.IndicatorCategory.APPLICATION_STATUS)

        self.ind.set_status(appindicator.IndicatorStatus.ACTIVE)
        new_msg_icon_desc = "New Messages"
        self.ind.set_attention_icon_full("indicator-messages-new", new_msg_icon_desc)

        # Set based on current policy (check if fstab entry exists)
        if os.path.isfile("/etc/udev/rules.d/fstab.rules"):
            hd_icon_desc = "Read Only"
            self.ind.set_icon_full("/usr/share/pixmaps/mounter/harddisk-readonly.png", hd_icon_desc)
        else:
            hd_icon_desc = "Writeable"
            self.ind.set_icon_full("/usr/share/pixmaps/mounter/harddisk-writeable.png", hd_icon_desc)

        # create a menu
        self.menu = gtk.Menu()

        # Mounter item
        #mounter = gtk.MenuItem("Open Mounter...")
        #mounter.connect("activate", self.mounter_start)
        #mounter.show()
        #self.menu.append(mounter)

        # Read-only status
        rostatus = gtk.MenuItem.new_with_label("Set USB mount policy READ-ONLY")
        rostatus.connect("activate", self.ro_set)
        rostatus.show()
        self.menu.append(rostatus)

	# Read-write status
        #if os.path.isfile("/etc/udev/rules.d/fstab.rules"):
        rwstatus = gtk.MenuItem.new_with_label("Set USB mount policy WRITEABLE")
        rwstatus.connect("activate", self.rw_set)
        rwstatus.show()
        self.menu.append(rwstatus)

	# Quit item
        #image = gtk.ImageMenuItem(gtk.STOCK_QUIT)
        #image = gtk.MenuItem("Exit")
        #image.connect("activate", self.exit_menu)
        #image.show()
        #self.menu.append(image)

        self.menu.show()
        self.ind.set_menu(self.menu)

##    def mounter_start(self, widget, data=None):
        #Call mounter Unity app / legacy app here
        #subprocess.call(["/usr/local/bin/rbfstabGUI.sh"])
        #win = MounterDialog("Select devices to mount. Devices will be mounted according to the system policy." + "\nCurrently mounted devices will not be changed.\n\n")
        #win.connect("delete-event", gtk.main_quit)
        #win.show_all()
        #response = win.run()
        #win.destroy()

##        bc_mounter.main()

#        win = bc_mounter.MounterDialog("Select devices to mount. Devices will be mounted according to the system policy." + "\nCurrently mounted devices will not be changed.\n\n")
#        response = win.run()
#        win.destroy()


    def ro_set(self, widget, data=None):
        #Call RO warning indicator here
        if not os.path.isfile("/etc/udev/rules.d/fstab.rules"):
            win = PolicyDialog("You are about to set the system-wide USB mount policy to:" \
                           + "\n\n" + "READ-ONLY" + "\n\n" + \
                           "Currently mounted volumes on USB devices will not be affected until remounted.")
        else:
            win = PolicyDialog("\nThe USB mount policy is already in the READ-ONLY state." + "\n")
        #win.connect("delete-event", gtk.main_quit)
        #win.show_all()
        response = win.run()
        win.destroy()

        if response == gtk.ResponseType.OK:
            print("Got an OK")
            # Call rbfstab to set policy - READ-ONLY here
            if not os.path.isfile("/etc/udev/rules.d/fstab.rules"):
                subprocess.call(["sudo", "rbfstab", "-i"])
            else:
                print("No change required in current state")
            hd_icon_desc = "Read Only"
            self.ind.set_icon_full("/usr/share/pixmaps/mounter/harddisk-readonly.png", hd_icon_desc)
        else:
            print("Got a CANCEL")

    def rw_set(self, widget, data=None):
        #Call RW warning indicator here
        if os.path.isfile("/etc/udev/rules.d/fstab.rules"):
            win = PolicyDialog("CAUTION! You are about to set the system-wide USB mount policy to:" \
                           + "\n\n" + "WRITEABLE" + "\n\n" + \
                           "Click CANCEL to remain in the READ-ONLY state. Currently " \
                           + "\n" + "mounted volumes on USB devices will not be affected until remounted.")
        else:
            win = PolicyDialog("\nThe USB mount policy is already in the WRITEABLE state." + "\n")

        #win.connect("delete-event", gtk.main_quit)
        response = win.run()
        win.destroy()

        if response == gtk.ResponseType.OK:
            print("Got an OK")
            # Call rbfstab to set policy - READ-WRITE here
            if os.path.isfile("/etc/udev/rules.d/fstab.rules"):
                subprocess.call(["sudo", "rbfstab", "-r"])
            else:
                print("No change required in current state")
            hd_icon_desc = "Writeable"
            self.ind.set_icon_full("/usr/share/pixmaps/mounter/harddisk-writeable.png", hd_icon_desc)
        else:
            print("Got a CANCEL")

    def exit_menu(self, widget, data=None):
        #gtk.main_quit()
        sys.exit(0)

def main():
    gtk.main()
    return 0

if __name__ == "__main__":
    indicator = MounterAppIndicator()
    main()
