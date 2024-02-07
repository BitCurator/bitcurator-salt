include:
  - bitcurator.tools.hfsexplorer
  - bitcurator.tools.dumpfloppy
  - bitcurator.tools.regripper
  - bitcurator.tools.nsrllookup

bitcurator-tools:
  test.nop:
    - name: bitcurator-tools
    - require:
      - sls: bitcurator.tools.hfsexplorer
      - sls: bitcurator.tools.dumpfloppy
      - sls: bitcurator.tools.regripper
      - sls: bitcurator.tools.nsrllookup
