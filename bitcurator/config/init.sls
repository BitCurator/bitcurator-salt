include:
  - bitcurator.config.user
  - bitcurator.config.timezone
  - bitcurator.config.salt-minion
  - bitcurator.config.ssh

bitcurator-config:
  test.nop:
    - name: bitcurator-config
    - require:
      - sls: bitcurator.config.user
      - sls: bitcurator.config.timezone
      - sls: bitcurator.config.salt-minion
      - sls: bitcurator.config.ssh
