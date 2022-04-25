include:
  - bitcurator.addon
  - bitcurator.theme

bitcurator-dedicated:
  test.nop:
    - require:
      - sls: bitcurator.addon
      - sls: bitcurator.theme
