siegfried-repo:
  pkgrepo.managed:
    - humanname: siegfried
    - name: deb [arch=amd64] https://www.itforarchivists.com/ buster main
    - file: /etc/apt/sources.list.d/siegfried.list
    - key_url: salt://bitcurator/repos/files/SIEGFRIED-PGP-KEY.asc
    - refresh: true
