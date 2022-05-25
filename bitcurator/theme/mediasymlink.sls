{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

include:
  - bitcurator.config.user

mediasymlink:
  file.symlink:
    - name: /home/{{ user }}/Desktop/Shared Folders and Media
    - target: /media
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: bitcurator-user-{{ user }}
