{% set codename = grains['oscodename'] %}

bitcurator-multiverse-repo:
  pkgrepo.managed:
    - name: deb [signed-by=/usr/share/keyrings/ubuntu-archive-keyring.gpg] http://archive.ubuntu.com/ubuntu/ {{ codename }} multiverse
    - file: /etc/apt/sources.list.d/bitcurator-multiverse.sources
    - aptkey: False
    - clean_file: True
    - refresh_db: True

bitcurator-multiverse-repo-security:
  pkgrepo.managed:
    - name: deb [signed-by=/usr/share/keyrings/ubuntu-archive-keyring.gpg] http://archive.ubuntu.com/ubuntu/ {{ codename }}-security multiverse
    - file: /etc/apt/sources.list.d/bitcurator-multiverse-security.sources
    - aptkey: False
    - clean_file: True
    - refresh_db: True
