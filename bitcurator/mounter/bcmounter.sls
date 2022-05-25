/usr/local/bin/bc_mounter.py:
  file.managed:
    - source: salt://bitcurator/mounter/bc_mounter.py
    - user: root
    - group: root
    - mode: 755
