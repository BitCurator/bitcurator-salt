bitcurator-siegfried-key:
  file.managed:
    - name: /usr/share/keyrings/SIEGFRIED-PGP-KEY.asc
    - source: http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x20F802FE798E6857
    - skip_verify: True
    - makedirs: True

bitcurator-siegfried-repo:
  pkgrepo.managed:
    - humanname: siegfried
    - name: deb [signed-by=/usr/share/keyrings/SIEGFRIED-PGP-KEY.asc arch=amd64] https://www.itforarchivists.com/ buster main
    - file: /etc/apt/sources.list.d/siegfried.list
    - aptkey: False
    - refresh: true
    - require:
      - file: bitcurator-siegfried-key
