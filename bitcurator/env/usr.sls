/usr:
  file.recurse:
    - source: salt://bitcurator/env/usr
    - user: root
    - group: root
    - makedirs: True
    - file_mode: 755
    - dir_mode: 755
