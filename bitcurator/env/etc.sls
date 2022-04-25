/etc:
  file.recurse:
    - source: salt://bitcurator/env/etc
    - user: root
    - group: root
    - makedirs: True
    - file_mode: keep