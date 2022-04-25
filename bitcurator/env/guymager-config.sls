include:
  - bitcurator.packages.guymager

guymager-lang:
  file.managed:
    - name: /usr/share/guymager/guymager_en-CH.qm
    - source: salt://bitcurator/env/guymager-config/guymager_en-CH.qm
    - makedirs: True
    - require:
      - sls: bitcurator.packages.guymager

guymager-config:
  file.managed:
    - name: /etc/guymager/local.cfg
    - source: salt://bitcurator/env/guymager-config/local.cfg
    - makedirs: True
    - require:
      - sls: bitcurator.packages.guymager
