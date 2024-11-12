include:
  - bitcurator.packages.libicu-dev
  - bitcurator.packages.pkg-config

python3-icu:
  pkg.installed:
    - require:
      - sls: bitcurator.packages.libicu-dev
      - sls: bitcurator.packages.pkg-config
