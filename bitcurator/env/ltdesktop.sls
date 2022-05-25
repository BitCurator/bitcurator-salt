{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

/home/{{ user }}/.config/autostart/launcher-trust.desktop:
  file.managed:
    - source: salt://bitcurator/env/launcher-trust.desktop
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
