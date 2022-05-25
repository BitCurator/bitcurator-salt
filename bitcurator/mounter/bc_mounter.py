#!/usr/bin/env python3

from gi.repository import Gtk as gtk
import subprocess
import os, sys

#class MounterDialog(gtk.Window):
class MounterDialog(gtk.Dialog):

    def on_cell_toggled(self, widget, index):
        self.liststore[index][0] = not self.liststore[index][0]
        #print("Cell toggled, on or off")

    def __init__(self, dialog_message):
        gtk.Dialog.__init__(self, "BitCurator Mounter", None, 0)
            #(gtk.STOCK_CANCEL, gtk.ResponseType.CANCEL,
            # gtk.STOCK_OK, gtk.ResponseType.OK))

        self.set_border_width(6)
        self.set_default_size(600, 400)

        label = gtk.Label(dialog_message)

        # Get info about attached block devices
        blkid_cmd = "sudo blkid -o device | grep -v ram"
        p_blkid = subprocess.Popen(blkid_cmd, stdout=subprocess.PIPE, stderr=None, shell=True)
        #Launch the shell command:
        output = p_blkid.communicate()
        #print(output[0].decode("utf-8"))

        device_list = output[0].decode("utf-8").split('\n')

        # Set up the 2D array for device information
        info_list = [[] for _ in range(len(device_list[0:-1]))]

        # Parse the device information for the dialog
        for index, this_dev in enumerate(device_list[0:-1]):
            # Testing only
            #print("Got here: " + this_dev + " " + str(index))

            # Add raw device point to info list
            info_list[index].append(this_dev)

            # --- Determine the file system type
            fs_cmd = "blkid -s TYPE -o value " + this_dev
            p_fs = subprocess.Popen(fs_cmd, stdout=subprocess.PIPE, stderr=None, shell=True)
            #Launch the shell command:
            output = p_fs.communicate()
            #print(output[0].decode("utf-8"))

            # Add file system type to info list for this device
            info_list[index].append(output[0].decode("utf-8").rstrip('\n'))

            # --- Determine the volume label
            label_cmd = "blkid -s LABEL -o value " + this_dev
            p_label = subprocess.Popen(label_cmd, stdout=subprocess.PIPE, stderr=None, shell=True)
            #Launch the shell command:
            output = p_label.communicate()
            #print(output[0].decode("utf-8"))

            # Add volume label to info list for this device
            info_list[index].append(output[0].decode("utf-8").rstrip('\n'))

            # --- Determine the volume size
            size_cmd = "sudo sfdisk -s " + this_dev
            p_size = subprocess.Popen(size_cmd, stdout=subprocess.PIPE, stderr=None, shell=True)
            #Launch the shell command: - need to fix this for KB
            output = p_size.communicate()
            #print(output[0].decode("utf-8"))

            # Add volume size to info list for this device
            info_list[index].append(output[0].decode("utf-8").rstrip('\n'))

            # --- Determine if device is mounted
            mnt_cmd = "grep ^" + this_dev + " /etc/mtab"
            p_mnt = subprocess.Popen(mnt_cmd, stdout=subprocess.PIPE, stderr=None, shell=True)
            #Launch the shell command: - need to fix this for KB
            output = p_mnt.communicate()
            mnt_status_list = (output[0].decode("utf-8")).split(' ')

            if len(mnt_status_list) == 1:
                # Add negative mount point and status to info list for this device
                info_list[index].append("")
                info_list[index].append("(none)")

            else:
                # Set mounted location (fix this to not just print)
                #print("Mounted at: " + mnt_status_list[1])
                info_list[index].append(mnt_status_list[1])
                # Check for ro/rw status:
                if mnt_status_list[3].startswith("ro"):
                    #print("READ ONLY")
                    # Add read-only mount status to info list for this device
                    info_list[index].append("READ ONLY")
                if mnt_status_list[3].startswith("rw"):
                    #print("READ-WRITE")
                    # Add read-only mount status to info list for this device
                    info_list[index].append("WRITEABLE")

        #print(info_list)
        self.liststore = gtk.ListStore(bool, str, str, str, str, str, str)

        for dev_info in info_list:
            self.liststore.append([False, dev_info[0], dev_info[1], dev_info[2], dev_info[3], dev_info[4], dev_info[5]])

        treeview = gtk.TreeView(model=self.liststore)

        cell0 = gtk.CellRendererToggle()
        cell0.connect("toggled", self.on_cell_toggled)
        column_check = gtk.TreeViewColumn("Select", cell0, active=0)
        treeview.append_column(column_check)

        cell1 = gtk.CellRendererText()
        column_dev = gtk.TreeViewColumn("Raw Device", cell1, text=1)
        treeview.append_column(column_dev)

        cell2 = gtk.CellRendererText()
        column_dev = gtk.TreeViewColumn("File System", cell2, text=2)
        treeview.append_column(column_dev)

        cell3 = gtk.CellRendererText()
        column_dev = gtk.TreeViewColumn("Label", cell3, text=3)
        treeview.append_column(column_dev)

        cell4 = gtk.CellRendererText()
        column_dev = gtk.TreeViewColumn("Size (Bytes)", cell4, text=4)
        treeview.append_column(column_dev)

        cell5 = gtk.CellRendererText()
        column_dev = gtk.TreeViewColumn("Mount Point", cell5, text=5)
        treeview.append_column(column_dev)

        cell6 = gtk.CellRendererText()
        column_dev = gtk.TreeViewColumn("Read/Write Status", cell6, text=6)
        treeview.append_column(column_dev)
        
        mount_button = gtk.Button()
        mount_button.set_label("Mount Selected Devices")
        mount_button.connect('clicked', self.on_mount_clicked)

        # Add all items to the main box
        box = self.get_content_area()
        box.set_spacing(6)
        box.add(label)
        box.add(treeview)
        box.add(mount_button)
        self.show_all()

    def on_mount_clicked(self, widget):
        #print("Clicked")
        for dev_info in self.liststore:
            # Check if this device is clicked, not mounted, and not swap
            if dev_info[0] == True and dev_info[5] == "" and dev_info[2] != 'swap':
                # Run udisks to mount
                mount_cmd = 'udisksctl mount -b ' + dev_info[1]
                p_label = subprocess.Popen(mount_cmd, stdout=subprocess.PIPE, stderr=None, shell=True)
                #Launch the shell command:
                output = p_label.communicate()
        #print("Finished mount")
        win.destroy()
        #sys.exit(0)

def main():
    #win.show_all()
    ##win.connect("delete-event", gtk.main_quit)
    ##gtk.main()
    response = win.run()
    #print(str(response))

    #if response == gtk.ResponseType.OK:
    #    print("Got an OK.")
    #else:
    #    print("Got a CANCEL.")
    win.destroy()

if __name__ == "__main__":
    #win = MounterDialog()
    win = MounterDialog("Select devices to mount. Devices will be mounted according to the system policy." + "\nCurrently mounted devices will not be changed.\n\n")
    main()

