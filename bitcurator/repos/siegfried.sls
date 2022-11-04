bitcurator-siegfried-key:
  file.managed:
    - name: /usr/share/keyrings/SIEGFRIED-PGP-KEY.asc
    - source: salt://bitcurator/repos/files/SIEGFRIED-PGP-KEY.asc
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
