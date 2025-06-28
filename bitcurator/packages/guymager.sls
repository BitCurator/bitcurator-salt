include:
  - bitcurator.packages.libqt5
  - bitcurator.packages.hdparm
  - bitcurator.packages.smartmontools

guymager:
  pkg.installed:
    - require:
      - sls: bitcurator.packages.libqt5
      - sls: bitcurator.packages.hdparm
      - sls: bitcurator.packages.smartmontools
