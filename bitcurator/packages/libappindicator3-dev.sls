include:
  - bitcurator.packages.libappindicator3-1

libappindicator3-dev:
  pkg.installed:
    - require:
      - sls: bitcurator.packages.libappindicator3-1
