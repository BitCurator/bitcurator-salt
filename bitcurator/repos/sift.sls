include:
  - bitcurator.packages.software-properties-common

bitcurator-sift-repo:
  pkgrepo.managed:
    - ppa: sift/stable
    - keyid: 3E04D0A9A043FAFD66F5E774B2A668DD0744BEC3
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: bitcurator.packages.software-properties-common
