{% set codename = grains['oscodename'] %}

# Ensure Ubuntu's base apt sources remain intact, even if
# software-properties-common (or anything else) rewrites ubuntu.sources
# during the highstate.
#
# The global archive.ubuntu.com mirror is used rather than a geographic
# one (e.g. us.archive.ubuntu.com). Users who prefer a closer mirror can
# edit /etc/apt/sources.list.d/ubuntu.sources manually post-install;
# salt will overwrite the change on next run, so the edit needs to be
# carried into this file if persistence is wanted.

bitcurator-ubuntu-base-sources:
  file.managed:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - mode: 644
    - user: root
    - group: root
    - contents: |
        Types: deb
        URIs: http://archive.ubuntu.com/ubuntu/
        Suites: {{ codename }} {{ codename }}-updates {{ codename }}-backports
        Components: main restricted universe multiverse
        Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

        Types: deb
        URIs: http://security.ubuntu.com/ubuntu/
        Suites: {{ codename }}-security
        Components: main restricted universe multiverse
        Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# Clean up the redundant per-component .sources files that earlier
# branches of this work created. With ubuntu.sources covering all four
# components, these add nothing and just create confusion.

bitcurator-old-multiverse-cleanup:
  file.absent:
    - name: /etc/apt/sources.list.d/bitcurator-multiverse.sources

bitcurator-old-multiverse-security-cleanup:
  file.absent:
    - name: /etc/apt/sources.list.d/bitcurator-multiverse-security.sources

bitcurator-old-universe-cleanup:
  file.absent:
    - name: /etc/apt/sources.list.d/bitcurator-universe.sources

# Also clean up the .list-extension versions from the pre-deb822
# iteration of this branch, in case any test systems still have them.

bitcurator-old-multiverse-list-cleanup:
  file.absent:
    - name: /etc/apt/sources.list.d/bitcurator-multiverse.list

bitcurator-old-multiverse-security-list-cleanup:
  file.absent:
    - name: /etc/apt/sources.list.d/bitcurator-multiverse-security.list

bitcurator-old-universe-list-cleanup:
  file.absent:
    - name: /etc/apt/sources.list.d/bitcurator-universe.list

# Refresh apt's cache when any of the source files change.

bitcurator-ubuntu-base-refresh:
  cmd.run:
    - name: apt-get update
    - onchanges:
      - file: bitcurator-ubuntu-base-sources
      - file: bitcurator-old-multiverse-cleanup
      - file: bitcurator-old-multiverse-security-cleanup
      - file: bitcurator-old-universe-cleanup
      - file: bitcurator-old-multiverse-list-cleanup
      - file: bitcurator-old-multiverse-security-list-cleanup
      - file: bitcurator-old-universe-list-cleanup
