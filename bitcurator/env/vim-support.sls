{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

include:
  - bitcurator.config.user

/home/{{ user }}/.vim:
  file.recurse:
    - source: salt://bitcurator/env/.vim
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
    - file_mode: keep
    - require:
      - user: bitcurator-user-{{ user }}

vim-directories:
  file.directory:
    - names:
      - /home/{{ user }}/.vim/backups
      - /home/{{ user }}/.vim/swaps
    - user: {{ user }}
    - file_mode: 755
    - dir_mode: 755
    - group: {{ user }}
    - makedirs: True
    - require:
      - file: /home/{{ user }}/.vim
