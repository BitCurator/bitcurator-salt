{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

include:
  - bitcurator.config.user
  - bitcurator.packages.sleuthkit

ficlam-config:
  file.directory:
    - name: /home/{{ user }}/.fiwalk
    - user: {{ user }}
    - file_mode: 755
    - dir_mode: 755
    - group: {{ user }}
    - makedirs: True
    - require:
      - user: bitcurator-user-{{ user }}

ficlam-script:
  file.managed:
    - name: /home/{{ user }}/.fiwalk/ficlam.sh
    - source: salt://bitcurator/files/ficlam.sh
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - sls: bitcurator.packages.sleuthkit
