include:
  - bitcurator.packages.libewf
  - bitcurator.packages.libewf-dev

ewf-tools:
  pkg.installed:
    - requires:
      - sls: bitcurator.packages.libewf
      - sls: bitcurator.packages.libewf-dev
