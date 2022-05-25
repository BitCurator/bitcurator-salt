include:
  - bitcurator.repos.siegfried

siegfried:
  pkg.installed:
    - require:
      - sls: bitcurator.repos.siegfried
