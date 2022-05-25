/lib:
  file.recurse:
    - source: salt://bitcurator/env/lib
    - user: root
    - group: root
    - makedirs: True
    - file_mode: keep