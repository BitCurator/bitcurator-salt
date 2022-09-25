include:
  - bitcurator.tools.libuna
  - bitcurator.tools.hfsexplorer
  - bitcurator.tools.dumpfloppy
#  - bitcurator.tools.protobuf
#  - bitcurator.tools.sdhash
  - bitcurator.tools.regripper
  - bitcurator.tools.nsrllookup

bitcurator-tools:
  test.nop:
    - name: bitcurator-tools
    - require:
      - sls: bitcurator.tools.libuna
      - sls: bitcurator.tools.hfsexplorer
      - sls: bitcurator.tools.dumpfloppy
#      - sls: bitcurator.tools.protobuf
#      - sls: bitcurator.tools.sdhash
      - sls: bitcurator.tools.regripper
      - sls: bitcurator.tools.nsrllookup
