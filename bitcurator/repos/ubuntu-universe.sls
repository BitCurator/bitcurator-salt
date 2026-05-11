{% set codename = grains['oscodename'] %}

bitcurator-universe-repo:
  pkgrepo.managed:
    - name: deb [signed-by=/usr/share/keyrings/ubuntu-archive-keyring.gpg] http://archive.ubuntu.com/ubuntu/ {{ codename }} universe
    - file: /etc/apt/sources.list.d/bitcurator-universe.sources
    - aptkey: False
    - clean_file: True
    - refresh_db: True
