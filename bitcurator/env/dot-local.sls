{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

/home/{{ user }}/.local:
  file.recurse:
    - source: salt://bitcurator/env/.local
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
    - file_mode: keep
