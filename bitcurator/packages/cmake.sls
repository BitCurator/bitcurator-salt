include:
  - bitcurator.repos.kitware

cmake:
  pkg.installed:
    - allow_updates: True
    - upgrade: True
    - require:
      - sls: bitcurator.repos.kitware
