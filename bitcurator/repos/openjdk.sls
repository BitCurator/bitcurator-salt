include:
  - bitcurator.packages.software-properties-common

openjdk-repo:
  pkgrepo.managed:
    - ppa: openjdk-r/ppa
    - refresh: true
    - require:
      - sls: bitcurator.packages.software-properties-common
