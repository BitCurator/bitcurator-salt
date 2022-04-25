![Logo](https://github.com/BitCurator/bitcurator.github.io/blob/master/logos/BitCurator-Basic-400px.png)

# bitcurator-distro-salt disk image mount tools

This directory includes disk and disk image mount support tools that were available in version of BitCurator up to 1.8.16. These tools should be considered deprecated / no longer supported (see explanations below) and are retained only for legacy reference.

## bc_policyapp

A mount policy appindicator that can be used to set the state of the system mount policy (read only or read write) by installing or removing rbfstab (enabling or disabling custom control of fstab.

Appindicators are no longer officially supported in Ubuntu / GNOME, and the functionality of this tool will (eventually) be shifted to a standalone desktop application.

## bc_mounter

A standalone mount GUI with extremely simple functionality - allowing users to select and mount devices according to the current system policy. This app is not useful without bc_policyapp.
