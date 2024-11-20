## Generating a release

These instructions are intended for maintainers generating new releases of the BitCurator environment. **For instructions on installing BitCurator, see the main README**.

#### Step 1 - Preparing the work environment
In the .ci directory of the repo, there is a script called `tag-and-sign.sh`. This script must be updated to contain the proper `VERSION_FILE` value, and the URLs throughout must point to the appropriate repo.

Additionally, throughout you will see that `gpg --armor` is used to sign the release. After the `-u` variable, you should place your 8-character public signing key value.

The remainder of the scripts in this directory are all for testing salt-states, so it would be good to customize those as well, including generating your own docker environment for testing (which is how these scripts are used).

Finally, you will need to add your GitHub Access Token to the environment. The easiest way to do this would be to put it in your `~/.bashrc` file and then `source ~/.bashrc`. However, you can customize the `tag-and-sign.sh` script as you wish if you decide you'd rather pass it manually as an argument.
Or you can just `export GITHUB_ACCESS_TOKEN=<token>` then unset it after you're done.

#### Step 2 - Generating the release
Once you've made the changes you require, to your salt-states, edit the `VERSION` file (as you indicated with the variable `VERSION_FILE` in Step 1) to reflect the new version.
Then push your changes:
```bash
$ git add -A
$ git commit -m '<message here>'
$ git push
```
Once your push is complete, go to the root of your repo folder and run:
`$ ./.ci/tag-and-sign.sh <version>` where `<version>` is the version number you added in the `VERSION` file, and wish to create a tag for.

Once successful, the release will be available on your GitHub repo.

#### Step 3 - Profit
If done properly, you should only ever have to do Step 2 from here-on-in, unless you change your dev environment frequently.

## Building Releases of the BitCurator Environment

See **BUILD.md** for info on how releases are generated using the existing shell scripts.

## Manual Builds of the BitCurator Environment

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

and log in with your user credentials.
