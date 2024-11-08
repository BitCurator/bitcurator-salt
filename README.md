![Logo](https://github.com/BitCurator/bitcurator.github.io/blob/main/logos/BitCurator-Basic-400px.png)

# bitcurator-salt

[![GitHub issues](https://img.shields.io/github/issues/bitcurator/bitcurator-salt.svg)](https://github.com/bitcurator/bitcurator-salt/issues)
[![GitHub forks](https://img.shields.io/github/forks/bitcurator/bitcurator-salt.svg)](https://github.com/bitcurator/bitcurator-salt/network)

This repo includes the SaltStack states and supporting files to install the data analysis, forensics, security tools, and environment modifications that form the BitCurator environment. See details below for how to deploy in a recent Ubuntu LTS release.

Visit https://github.com/BitCurator/bitcurator-distro/wiki/Releases to view the Quickstart Guide. Pre-configured VMs are also available for some current and past releases.

**Note: BitCurator must be deployed on an x86/amd64 version of Ubuntu. Currently, it is not possible to deploy it as the host OS or in a VM on systems with ARM processors (including Apple M1 and M2).**

If you wish to build the environment from scratch on your own physical host or VM, follow the instructions below. An internet connection is **required** during installation.

## Install Ubuntu (24.04 LTS, 22.04LTS, or 20.04LTS)

Download the most recent 64-bit Ubuntu 24.04 Desktop image from https://releases.ubuntu.com/jammy/ and install on your local machine or in a VM. If you're using a VM, we recommend allocating a minimum of 8GB of RAM and 64GB of disk space to the instance. You may alternatively use previous LTS releases of Ubuntu (22.04LTS or 20.04LTS) if needed.

To remain consistent with the default configuration of BitCurator, when prompted use **BitCurator** for the Full Name, **bcadmin** for the username, and **bcadmin** for the password.

When installation is completed, reboot, log in, and open a terminal.


## Using the Installer

**1. Prepare your environment**

To ensure you have all of the tools, and updates necessary for the BitCurator environment to succeed, you should update the local `apt` repository and install the necessary tools:

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

Verify that the SHA-256 has of the downloaded file (current release: v2.0.0) matches the value below:

```shell
UPDATE ON RELEASE
```

You can generate the hash of your downloaded file with:

```shell
sha256sum bitcurator-cli-linux
```

Next, adjust some permissions and move the BitCurator installer to the correct location:

```shell
sudo mv bitcurator-cli-linux /usr/local/bin/bitcurator
sudo chmod +x /usr/local/bin/bitcurator
```

**3. Run the BitCurator CLI Installer**

Next, run the BitCurator installer. This may take up to an hour to complete, depending on your internet speed and system:

```shell
sudo bitcurator install
```

The installation may take up to an hour, depending on the speed of your system.

If you encounter an error, you may be able to identify the issue by reviewing saltstack.log file under /var/cache/bitcurator/cli in the subdirectory that matches the BitCurator state-files version you're installing. Search for the log file for result: false messages and look at the surrounding 5 lines or the 8 lines above each message to see the state file that caused the issue. You can do this with:

```shell
grep -i -C 5 'result: false' /var/cache/bitcurator/<version>/cli/saltstack.log or grep -i -B 8 'result: false' /var/cache/bitcurator/<version>/cli/saltstack.log
```

**5. Reboot**

When the installation is complete, reboot your system from the terminal:

```shell
sudo reboot now
```

After the reboot, you will be automatically logged in to BitCurator.


## Manual Installation

Manual installation outside of the BitCurator CLI installer can be useful for testing and development. Following installation of Ubuntu:

**1. Install curl, git, and gnupg if not already installed**

Curl is required for manual installation of the Salt Project tools.
```shell
sudo apt update && sudo apt install curl gnupg git -y
```

**2. Install Salt**

Follow the instructions at https://docs.saltproject.io/salt/install-guide/en/latest/topics/install-by-operating-system/linux-deb.html, to install Salt 3006 in the base Ubuntu environment:

Run the following command to install the Salt Project repository:

```shell
# Ensure keyrings dir exists
mkdir -p /etc/apt/keyrings
# Download public key
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
# Create apt repo target configuration
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
```

Update metadata and install salt-common:

```shell
sudo apt update
sudo apt install salt-common
```

**3. Clone the bitcurator-salt repo**

Clone the bitcurator-salt repo to create local copies of the environment configuration files for use in installation.

```shell
git clone https://github.com/BitCurator/bitcurator-salt.git
```

**4. Run Salt to install the environment**

Navigate to the location of the cloned repo. From inside the `bitcurator-salt` directory, run the command below:

```shell
sudo salt-call -l debug --file-root . --local --retcode-passthrough --state-output=mixed state.sls bitcurator.dedicated pillar='{"bitcurator_user": "<username>"}'
```

Using the `dedicated` mode/state of the install will include all of the tools and the interface customizations, just as if using the `sudo bitcurator install` command with the CLI. Using the `addon` mode/state will only install just the tools, with no change to theme, colors, or other interface bits. The `<username>` is the user for which you'd like the environment to be configured. This must be an existing user on the system.

**5. Reboot**

When the installation is complete, reboot your system from the terminal:

```shell
sudo reboot now
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

Have a question or need help? Visit the [bitcurator-users Google Group](https://groups.google.com/d/forum/bitcurator-users).

Some community maintained documentation and resources are available at
[the BitCurator documentation hosted on GitHub Pages]((https://bitcurator.github.io/documentation/). Note that the information on this site may lag behind the latest release(s).

A [BitCurator Discussions](https://github.com/orgs/BitCurator/discussions) board is also available for ideas or comments.

## License(s)

The BitCurator logo, BitCurator project documentation, and other non-software products of the BitCurator team are subject to the the Creative Commons Attribution 4.0 Generic license (CC By 4.0).

Unless otherwise indicated, software items in this repository are distributed under the terms of the GNU General Public License v3.0. See the LICENSE file for additional details.

In addition to software produced by the BitCurator team, BitCurator packages and modifies open source software produced by other developers. Licenses and attributions are retained here where applicable.

## Development Team and Support

The BitCurator environment is volunteer-maintained. BitCurator was originally developed in the School of Library and Information Science at the University of North Carolina at Chapel Hill with funding provided by the Andrew W. Mellon Foundation (2011-2014).

Community support is managed by the BitCurator Consortium. Find out more at:

https://bitcuratorconsortium.org/
