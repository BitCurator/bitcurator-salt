{% set release = grains['oscodename'] %}

include:
  - bitcurator.packages.software-properties-common

bitcurator-kitware-repo:
  pkgrepo.managed:
    - humanname: kitware
    - name: deb [arch=amd64] https://apt.kitware.com/ubuntu/ {{ release }} main
    - file: /etc/apt/sources.list.d/kitware.list
    - key_url: salt://bitcurator/repos/files/KITWARE-PGP-KEY.asc
    - refresh: true
    - require:
      - sls: bitcurator.packages.software-properties-common
