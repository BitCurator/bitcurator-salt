## Generating a release
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
