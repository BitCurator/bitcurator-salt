include:
  - bitcurator.packages.software-properties-common

bitcurator-gift-repo:
  pkgrepo.managed:
    - name: gift
    - ppa: gift/stable
    - keyid: 3ED1EAECE81894B171D7DA5B5E80511B10C598B8
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: bitcurator.packages.software-properties-common
