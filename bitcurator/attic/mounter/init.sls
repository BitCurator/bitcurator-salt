include:
  - bitcurator.mounter.bcmounter
  - bitcurator.mounter.bcpolicyapp
  - bitcurator.mounter.bcautostart

bitcurator-mounter:
  test.nop:
    - name: bitcurator-mounter
    - require:
      - sls: bitcurator.mounter.bcmounter
      - sls: bitcurator.mounter.bcpolicyapp
      - sls: bitcurator.mounter.bcautostart
