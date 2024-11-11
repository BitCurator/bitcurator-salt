include:
  - bitcurator.repos
  - bitcurator.python-packages
  - bitcurator.packages
  - bitcurator.config
  - bitcurator.env
  - bitcurator.tools
  - bitcurator.mounter

bitcurator-version-file:
  file.managed:
    - name: /etc/bitcurator-version
    - source: salt://bitcurator/VERSION
    - user: root
    - group: root
    - require:
      - sls: bitcurator.repos
      - sls: bitcurator.python-packages
      - sls: bitcurator.packages
      - sls: bitcurator.config
      - sls: bitcurator.env
      - sls: bitcurator.tools
      - sls: bitcurator.mounter
