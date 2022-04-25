{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

include:
  - bitcurator.config.user

/home/{{ user }}/.config/autostart/bcpolicyapp.py.desktop:
  file.managed:
    - source: salt://bitcurator/mounter/bcpolicyapp.py.desktop
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - require:
      - user: bitcurator-user-{{ user }}
