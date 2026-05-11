{% set codename = grains['oscodename'] %}

include:
  - bitcurator.packages.software-properties-common

bitcurator-kitware-key:
  file.managed:
    - name: /usr/share/keyrings/KITWARE-PGP-KEY.asc
    - source: https://apt.kitware.com/keys/kitware-archive-latest.asc
    - skip_verify: True
    - makedirs: True

bitcurator-kitware-repo:
  pkgrepo.managed:
    - humanname: Kitware
    - name: deb [signed-by=/usr/share/keyrings/KITWARE-PGP-KEY.asc arch=amd64] https://apt.kitware.com/ubuntu/ {{ codename }} main
    - file: /etc/apt/sources.list.d/kitware.list
    - aptkey: False
    - clean_file: True
    - refresh: True
    - require:
      - sls: bitcurator.packages.software-properties-common
      - file: bitcurator-kitware-key
