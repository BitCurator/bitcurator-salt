![Logo](https://github.com/BitCurator/bitcurator.github.io/blob/main/logos/BitCurator-Basic-400px.png)

# bitcurator-salt

[![GitHub issues](https://img.shields.io/github/issues/bitcurator/bitcurator-salt.svg)](https://github.com/bitcurator/bitcurator-salt/issues)
[![GitHub forks](https://img.shields.io/github/forks/bitcurator/bitcurator-salt.svg)](https://github.com/bitcurator/bitcurator-salt/network)
[![Twitter Follow](https://img.shields.io/twitter/follow/bitcurator.svg?style=social&label=Follow)](https://twitter.com/bitcurator)

This repo includes the SaltStack states and supporting files to install the data analysis, forensics, security tools, and environment modifications that form the BitCurator environment. See details below for how to deploy in a recent Ubuntu LTS release.

Visit https://github.com/BitCurator/bitcurator-distro/wiki/Releases to view the Quickstart Guide. Pre-configured VMs are also available for some current and past releases.

**Note: BitCurator must be deployed on an x86/amd64 version of Ubuntu. Currently, it is not possible to deploy it as the host OS or in a VM on systems with ARM processors (including Apple M1 and M2).**

If you wish to build the environment from scratch on your own physical host or VM, follow the instructions below. An internet connection is **required** during installation.

## Install Ubuntu (22.04LTS or 20.04LTS)

Download the most recent 64-bit Ubuntu 22.04 Desktop image from https://releases.ubuntu.com/jammy/ and install on your local machine or in a VM. If you're using a VM, we recommend allocating a minimum of 8GB of RAM and 64GB of disk space to the instance. You may also use a release of Ubuntu 20.04LTS if needed.

To remain consistent with the default configuration of BitCurator, when prompted use **BitCurator** for the Full Name, **bcadmin** for the username, and **bcadmin** for the password.

When installation is completed, reboot, log in, and open a terminal.


## Using the Installer

**1. Download the BitCurator CLI installer**

BitCurator uses a standalone command-line tool for installation and upgrade. First, download the latest release of the tool with the following command:

```shell
wget https://distro.ibiblio.org/bitcurator/bitcurator-cli-linux
```

Verify that the SHA-256 has of the downloaded file (current release: v1.0.0) matches the value below:

```shell
5acab7abcafa24864d49e4872f8e2b562c16bf4842256ad3f994aae8d0df77c1
```

You can generate the hash of your downloaded file with:

```shell
sha256sum bitcurator-cli-linux
```

Next, adjust some permissions and move the BitCurator installer to the correct location:

```shell
mv bitcurator-cli-linux bitcurator
chmod +x bitcurator
sudo mv bitcurator /usr/local/bin
```

**2. Install GnuPG**

GnuPG is required for the BitCurator installer to validate the signature of the BitCurrator configuration files during install. To install GnuPG, run:

```shell
sudo apt install -y gnupg
```

**3. Run the BitCurator CLI Installer**

Next, run the BitCurator installer. This may take up to an hour to complete, depending on your internet speed and system:

```shell
sudo bitcurator install
```

The installation may take up to an hour, depending on the speed of your system.

If you encounter an error, you may be able to identify the issue by reviewing saltstack.log file under /var/cache/bitcurator/cli in the subdirectory that matches the BitCcurator state-files version you're installing. Search for the log file for result: false messages and look at the surrounding 5 lines or the 8 lines above each message to see the state file that caused the issue. You can do this with:

```shell
grep -i -C 5 'result: false' or grep -i -B 8 'result: false'
```

**5. Reboot**

When the installation is complete, reboot your system from the terminal:

```shell
sudo reboot
```

After the reboot, you will be automatically logged in to BitCurator.


## What's in this repository

This repository has been organized to make the process of maintaining and contributing to BitCurator development as transparent as possible. An explanation of the layout follows.

The **.ci** directory contains a selection of shell scripts used to build and test BitCurator releases.

The **bitcurator** directory contains all support files and salt states in a number of different directories:

- **config**: Salt states and support files for environment and user configuration
- **env**: Environment support files and salt states for the user desktop and various tools
- **files**: Source packages and deb packages for tools where a legacy version is required, or no packaging exists
- **mounter**: Mount policy tools
- **packages**: all deb packages (to be installed with apt-get)
- **python-packages**: all Python 3 packages (to be installed with pip3)
- **repos**: additional repositories that must be enabled
- **theme**: BitCurator theme resources
- **tools**: tools that must be installed from source

## BitCurator documentation, help, and discussions

Visit the [BitCurator wiki on GitHub](https://github.com/BitCurator/bitcurator-distro/wiki/Releases) to find the [latest version of our Quickstart Guide](https://github.com/BitCurator/bitcurator-distro/wiki/Releases#quickstart-guide).

Have a question, idea, or use case to share? Post it to the [BitCurator Discussions](https://github.com/orgs/BitCurator/discussions) board!

Some community maintained documentation and resources are available at
[the BitCurator Confluence instance hosted by Educopia](https://confluence.educopia.org/display/BC). Note that the information on this site may lag behind the latest release(s).

Questions and comments can also be sent to the [bitcurator-users Google Group](https://groups.google.com/d/forum/bitcurator-users).

## License(s)

The BitCurator logo, BitCurator project documentation, and other non-software products of the BitCurator team are subject to the the Creative Commons Attribution 4.0 Generic license (CC By 4.0).

Unless otherwise indicated, software items in this repository are distributed under the terms of the GNU General Public License v3.0. See the LICENSE file for additional details.

In addition to software produced by the BitCurator team, BitCurator packages and modifies open source software produced by other developers. Licenses and attributions are retained here where applicable.

## Development Team and Support

The BitCurator environment is volunteer-maintained. BitCurator was originally developed in the School of Library and Information Science at the University of North Carolina at Chapel Hill with funding provided by the Andrew W. Mellon Foundation (2011-2014).

Community support is managed by the BitCurator Consortium. Find out more at:

http://www.bitcuratorconsortium.net/

