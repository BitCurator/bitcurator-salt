{% set codename = grains['oscodename'] %}

{% set needs_ubuntu_sources = {
     'jammy':    False,
     'noble':    True,
     'resolute': True,
   }.get(codename, True) %}

# On noble (24.04) and later, the canonical Ubuntu apt sources live in
# /etc/apt/sources.list.d/ubuntu.sources (deb822 format), and Ubuntu's
# software-properties-common has been observed to truncate that file
# during the highstate on resolute, removing the archive.ubuntu.com
# stanza and leaving apt without coverage of main/restricted. We write
# the canonical content explicitly so that any damage is repaired on
# the next salt run.
#
# On jammy (22.04), the canonical sources are still in
# /etc/apt/sources.list, and ubuntu.sources is unused by default.
# Writing ubuntu.sources on jammy creates duplicate-target warnings on
# apt update because the same components are then configured in both
# files. The bitcurator-ubuntu-base-sources state is therefore a
# test.nop on jammy.
#
# The global archive.ubuntu.com mirror is used on noble/resolute
# rather than a geographic one (e.g. us.archive.ubuntu.com). Users who
# prefer a closer mirror can edit ubuntu.sources manually post-install;
# salt will overwrite the change on next run, so the edit needs to be
# carried into this file if persistence is wanted.

{% if needs_ubuntu_sources %}

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

bitcurator-ubuntu-base-refresh:
  cmd.run:
    - name: apt-get update
    - onchanges:
      - file: bitcurator-ubuntu-base-sources

{% else %}

# Jammy's canonical sources live in /etc/apt/sources.list. Don't touch
# it - the installer-provided file is correct, and writing
# ubuntu.sources here would create duplicate entries and apt warnings.
bitcurator-ubuntu-base-sources:
  test.nop: []

{% endif %}
