![Logo](https://github.com/BitCurator/bitcurator.github.io/blob/main/logos/BitCurator-Basic-400px.png)

# bitcurator-salt

[![GitHub issues](https://img.shields.io/github/issues/bitcurator/bitcurator-salt.svg)](https://github.com/bitcurator/bitcurator-salt/issues)
[![GitHub forks](https://img.shields.io/github/forks/bitcurator/bitcurator-salt.svg)](https://github.com/bitcurator/bitcurator-salt/network)

Configuration and support files to build the BitCurator environment in a Ubuntu LTS release. BitCurator provides a dedicated installer and uses [Salt](https://saltproject.io/) automation to create a custom desktop environment that includes archival processing, metadata management, forensic analysis, and security tools.

Visit https://github.com/BitCurator/bitcurator-distro/wiki/Releases to view the Quick Start Guide. Or, begin with the instructions in the next section if you are comfortable installing Ubuntu and using command-line tools.

**Note: BitCurator must be deployed on an x86/amd64 version of Ubuntu. Currently, Ubuntu cannot be installed as the host OS or in a VM on systems with ARM processors, including Apple silicon (M1-M4 series).**

If you wish to build the environment from scratch on your own physical host or VM, follow the instructions below. An internet connection is **required** during installation.

## Install Ubuntu (24.04LTS, 22.04LTS)

Download the most recent 64-bit Ubuntu 24.04 Desktop image from https://releases.ubuntu.com/noble/ and install on your local machine or in a VM. If you're using a VM, we recommend allocating a minimum of 8GB of RAM and 64GB of disk space to the instance. You may alternatively use the previous LTS release of Ubuntu, 22.04LTS, if needed.

You may use any hostname, username, and password. If you wish to replicate the default configuration in the BitCurator documentation, when prompted use `BitCurator` for the Full Name, `bcadmin` for the username, and `bcadmin` for the password. This is not recommended for production environments.

When installation is completed, reboot, log in, and open a terminal.

## Using the Installer

**1. Prepare your environment**

To ensure you have all tools and updates necessary for the BitCurator environment to install correctly, update the local `apt` repository and install some required tools:

```shell
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install gnupg curl git -y
```

`gnupg` is required for the BitCurator installer to validate the signature of the BitCurrator configuration files during install.
`curl` can be used when developing or testing state files.
`git` is used to clone local GitHub repos, and can be used when testing state files from the [BitCurator SaltStack Repo](https://github.com/bitcurator/bitcurator-salt).

**2. Download the BitCurator CLI installer**

BitCurator uses a standalone command-line tool for installation and upgrade. First, download the latest release of the tool with the following command:

```shell
wget https://github.com/BitCurator/bitcurator-cli/releases/download/v2.0.0/bitcurator-cli-linux
```

Generate a SHA-256 hash of the downloaded file:

```shell
sha256sum bitcurator-cli-linux
```

and verify that the hash of this version (current release: v2.0.0) matches the value below:

```shell
f739a25e8a0a5648aacce5792ee0c4b8d24044947b7c6d75c010f28251846c21
```

Move and rename the BitCurator installer, and set it as executable:

```shell
sudo mv bitcurator-cli-linux /usr/local/bin/bitcurator
sudo chmod +x /usr/local/bin/bitcurator
```

**3. Run the BitCurator CLI Installer**

Finally, run the BitCurator installer. This may take up to an hour to complete, depending on your internet speed and system:

```shell
sudo bitcurator install
```

If an error occurs, it may be possible to identify the issue by reviewing `saltstack.log` file under `/var/cache/bitcurator/cli/X.X.X`, where X.X.X is the release version you are installing. Search for the log file for `result: false` messages and look at the surrounding 5 lines or the 8 lines above each message to see the state file that caused the issue. You can do this with:

```shell
grep -i -C 5 'result: false' /var/cache/bitcurator/cli/<version>/saltstack.log or grep -i -B 8 'result: false' /var/cache/bitcurator/cli/<version>/saltstack.log
```

**5. Reboot**

When the installation is complete, reboot your system from the terminal:

```shell
sudo reboot now
```

After reboot, log in using the credentials your provided earlier. (If you selected Automatic Login during the Ubuntu install, you will reboot directly to the desktop).

## Updating and Upgrading

Once BitCurator is installed, you may install additional software and update the Ubuntu OS as normal, either from the Software Center or with `sudo apt-get update && sudo apt-get upgrade` on the command line. 

We recommend that you decline LTS-to-LTS upgrades (for example, a pop-up notice in Ubuntu 22.04LTS announcing that 24.04LTS is available) and perform a clean install when moving to a new LTS.

The BitCurator CLI tool may also be used to selectively upgrade those packages specifically associated with the BitCurator environment, and to upgrade the BitCurator verion. To see all options for the BitCurator CLI, type the following in a terminal:

```shell
bitcurator --help
```

This will print a list showing the following options:

```shell
$ bitcurator --help
Usage:
  bitcurator [options] list-upgrades [--pre-release]
  bitcurator [options] install [--pre-release] [--version=<version>] [--mode=<mode>] [--user=<user>]
  bitcurator [options] update
  bitcurator [options] upgrade [--pre-release] [--mode=<mode>] [--user=<user>]
  bitcurator [options] version
  bitcurator [options] debug
  bitcurator -h | --help | -v

Options:
  --dev                 Developer Mode (do not use, dangerous, bypasses checks)
  --version=<version>   Specific version install [default: latest]
  --mode=<mode>         bitcurator installation mode (dedicated or addon, default: dedicated)
  --user=<user>         User used for bitcurator configuration [default: kamwoods]
  --no-cache            Ignore the cache, always download the release files
  --verbose             Display verbose logging
```

To update the packages and compiled tools specific to the BitCurator environment, enter the command:

```shell
sudo bitcurator update
```

To upgrade the BitCurator environment to a new release, use the upgrade option. For example, if you were using release 5.0.0 and wished to upgrade to 5.1.0, the following command would be used:

```shell
sudo bitcurator upgrade 5.1.0
```

To see a list of available upgrades, type:

```shell
bitcurator list-upgrades
```

## What's in this repository

This repository has been organized to make the process of maintaining and contributing to BitCurator development as transparent as possible. An explanation of the layout follows.

The `.ci/` directory contains a selection of shell scripts used to build and test BitCurator releases.

The `bitcurator/` directory contains all support files and salt states in a number of different directories:

- `config/`: Salt states and support files for environment and user configuration
- `env/`: Environment support files and salt states for the user desktop and various tools
- `files/`: Source packages and deb packages for tools where a legacy version is required, or no readily available, stable packaging exists
- `mounter/`: Mount policy tools
- `packages/`: all deb packages (to be installed with apt-get)
- `python-packages/`: all Python 3 packages (to be installed with pip3)
- `repos/`: additional repositories that must be enabled
- `theme/`: BitCurator theme resources
- `tools`/: tools that must be installed from source

## BitCurator documentation, help, and discussions

Visit the [BitCurator wiki on GitHub](https://github.com/BitCurator/bitcurator-distro/wiki/Releases) to find the [latest version of our Quickstart Guide](https://github.com/BitCurator/bitcurator-distro/wiki/Releases#quickstart-guide).

Have a question or need help? Visit the [bitcurator-users Google Group](https://groups.google.com/d/forum/bitcurator-users).

Some community maintained documentation and resources are available at
[the BitCurator documentation hosted on GitHub Pages](https://bitcurator.github.io/documentation/). Note that the information on this site may lag behind the latest release(s).

A [BitCurator Discussions](https://github.com/orgs/BitCurator/discussions) board is also available for ideas or comments.

## License(s)

The BitCurator logo, BitCurator project documentation, and other non-software products of the BitCurator team are subject to the the Creative Commons Attribution 4.0 Generic license (CC By 4.0).

Unless otherwise indicated, software items in this repository are distributed under the terms of the GNU General Public License v3.0. See the LICENSE file for additional details.

In addition to software produced by the BitCurator team, BitCurator packages and modifies open source software produced by other developers. Licenses and attributions are retained here where applicable.

## Development Team and Support

The BitCurator environment is volunteer-maintained. BitCurator was originally developed in the School of Library and Information Science at the University of North Carolina at Chapel Hill with funding provided by the Andrew W. Mellon Foundation (2011-2014).

Community support is managed by the BitCurator Consortium. Find out more at:

https://bitcuratorconsortium.org/
