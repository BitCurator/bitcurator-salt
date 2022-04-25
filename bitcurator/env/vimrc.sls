{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

/home/{{ user }}/.vimrc:
  file.managed:
    - source: salt://bitcurator/env/.vimrc
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - dir_mode: 755
