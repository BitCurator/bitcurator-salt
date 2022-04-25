/usr/local/bin/bc_policyapp.py:
  file.managed:
    - source: salt://bitcurator/mounter/bc_policyapp.py
    - user: root
    - group: root
    - mode: 755