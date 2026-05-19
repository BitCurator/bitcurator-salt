{% set codename = grains['oscodename'] %}

# BitCurator manages Ubuntu's apt source configuration via the
# canonical deb822 location at /etc/apt/sources.list.d/ubuntu.sources
# on every supported release.
#
# On noble (24.04) and resolute (26.04), this is already the Ubuntu
# default, so we're just ensuring the file exists with the correct
# contents (and defending against software-properties-common's
# observed habit of truncating ubuntu.sources on resolute).
#
# On jammy (22.04), Ubuntu still uses the legacy /etc/apt/sources.list
# by default. We rename it to /etc/apt/sources.list.legacy and write
# ubuntu.sources, bringing jammy systems in line with the noble+
# layout. The user's original sources.list is preserved at .legacy
# for inspection or recovery. The rename state's onlyif check makes
# this idempotent: it fires only when sources.list has at least one
# active deb line, so subsequent salt runs (and runs on noble or
# resolute where sources.list has no active sources) are no-ops.
#
# The global archive.ubuntu.com mirror is used rather than a
# geographic one (e.g. us.archive.ubuntu.com); users who prefer a
# closer mirror can edit ubuntu.sources manually post-install, with
# the understanding that salt will overwrite on next run unless this
# state file is also updated.

bitcurator-ubuntu-base-legacy-rename:
  file.rename:
    - name: /etc/apt/sources.list.legacy
    - source: /etc/apt/sources.list
    - onlyif: 'grep -qE "^\s*deb\s" /etc/apt/sources.list'

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
    - require:
      - file: bitcurator-ubuntu-base-legacy-rename

bitcurator-ubuntu-base-refresh:
  cmd.run:
    - name: apt-get update
    - onchanges:
      - file: bitcurator-ubuntu-base-sources
      - file: bitcurator-ubuntu-base-legacy-rename
