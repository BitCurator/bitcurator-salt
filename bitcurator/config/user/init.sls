include:
  - bitcurator.config.user.user
  - bitcurator.config.user.bash-rc
  - bitcurator.config.user.folders

bitcurator-config-user:
  test.nop:
    - name: bitcurator-config-user
    - require:
      - sls: bitcurator.config.user.user
      - sls: bitcurator.config.user.bash-rc
      - sls: bitcurator.config.user.folders
