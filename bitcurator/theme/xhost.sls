{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

include:
  - bitcurator.config.user

bitcurator-xhost:
  cmd.run:
    - name: "xhost +"
    - shell: /bin/bash
    - require:
      - user: bitcurator-user-{{ user }}
