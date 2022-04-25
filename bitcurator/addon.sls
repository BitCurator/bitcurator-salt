include:
  - bitcurator.repos
  - bitcurator.packages
  - bitcurator.python-packages
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
      - sls: bitcurator.packages
      - sls: bitcurator.python-packages
      - sls: bitcurator.config
      - sls: bitcurator.env
      - sls: bitcurator.tools
      - sls: bitcurator.mounter
