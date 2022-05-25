![Logo](https://github.com/BitCurator/bitcurator.github.io/blob/main/logos/BitCurator-Basic-400px.png)

# bitcurator-salt

[![GitHub issues](https://img.shields.io/github/issues/bitcurator/bitcurator-salt.svg)](https://github.com/bitcurator/bitcurator-salt/issues)
[![GitHub forks](https://img.shields.io/github/forks/bitcurator/bitcurator-salt.svg)](https://github.com/bitcurator/bitcurator-salt/network)
[![Twitter Follow](https://img.shields.io/twitter/follow/bitcurator.svg?style=social&label=Follow)](https://twitter.com/bitcurator)

**NOTE: Work on this updated repository and the related installer is in progress.**

This repo includes the SaltStack states and supporting files to install the data analysis, forensics, security tools, and environment modifications that form the BitCurator environment. See details below for how to deploy in a recent Ubuntu LTS release.

Visit https://github.com/BitCurator/bitcurator-distro/wiki/Releases to download pre-built VMs for specific releases.

## Pre-Installation Setup

Install Ubuntu 20.04LTS or 22.04LTS environment in a VM or on a dedicated host (see https://ubuntu.com/tutorials/tutorial-install-ubuntu-desktop for help with this). Our pre-built VMs use the hostname **bitcurator**, the username **bcadmin**, and the default password **bcadmin**. 

## Install

BitCurator uses a standalone command-line tool for installation and upgrade. Follow the steps below to download and run it.

Log in, ensure you are connected to a network, and execute the following in a terminalto ensure everything is up to date:

```shell
sudo apt-get update
sudo apt-get dist-upgrade
```

Next, download the installer tool:

```shell
wget https://distro.ibiblio.org/bitcurator/bitcurator-cli
```

Check that the SHA-256 hash of this file matches the following value:

```shell
TO BE ADDED HERE
```

You can generate the hash of your downloaded file with the following command:

```
sha256sum bitcurator-cli
```

Next, adjust some permissions and move the BitCurator installer to the correct location:

```
mv bitcurator-cli bitcurator
chmod +x bitcurator
sudo mv bitcurator /usr/local/bin
```

GnuPG is required for the BitCurator installer to validate the signature of the BitCurrator configuration files during install. To install GnuPG, run:

``
sudo apt install -y gnupg
```

Next, run the BitCurator installer. This may take an hour or longer to complete, depending on your system:

```
sudo bitcurator install
```

Finally, reboot the system and log in.

## What's in this repository

This repository has been organized to make the process of maintaining and contributing to BitCurator development as transparent as possible. An explanation of the layout follows.

The **.ci** directory contains a selection of shell scripts used to build and test BitCurator releases.

The **bitcurator** directory contains all support files and salt states in a number of different directories:

- **attic**: Legacy and unused files that have been kept for reference or potential future use
- **config**: Salt states and support files for environment and user configuration
- **env**: Environment support files and salt states for the user desktop and various tools
- **files**: Source packages and deb packages for tools where a legacy version is required, or no packaging exists
- **mounter**: Mount policy tools
- **packages**: all deb packages (to be installed with apt-get)
- **python-packages**: all Python 3 packages (to be installed with pip3)
- **repos**: additional repositories that must be enabled
- **theme**: BitCurator theme resources
- **tools**: tools that must be installed from source

## BitCurator documentation, help, and other information

User documentation and additional resources are available on
[the BitCurator Environment wiki](https://confluence.educopia.org/display/BC).

Questions and comments can also be directed to the bitcurator-users list.

[https://groups.google.com/d/forum/bitcurator-users](https://groups.google.com/d/forum/bitcurator-users)

## License(s)

The BitCurator logo, BitCurator project documentation, and other non-software products of the BitCurator team are subject to the the Creative Commons Attribution 4.0 Generic license (CC By 4.0).

Unless otherwise indicated, software items in this repository are distributed under the terms of the GNU General Public License v3.0. See the LICENSE file for additional details.

In addition to software produced by the BitCurator team, BitCurator packages and modifies open source software produced by other developers. Licenses and attributions are retained here where applicable.

## Development Team and Support

The BitCurator environment is a product of the BitCurator team housed at the School of Information and Library Science at the University of North Carolina at Chapel Hill. Funding between 2011 and 2014 was provided by the Andrew W. Mellon Foundation.

Ongoing support for the BitCurator environment is managed by the BitCurator Consortium. Find out more at:

http://www.bitcuratorconsortium.net/

