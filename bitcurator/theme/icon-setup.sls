{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

include:
  - bitcurator.packages.gnome-tweaks

icon-setup:
  cmd.run:
    - names:
      - gsettings set org.gnome.desktop.background show-desktop-icons true
      - gsettings set org.gnome.shell.extensions.desktop-icons show-trash true
      - gsettings set org.gnome.shell.extensions.desktop-icons show-home true
    - user: {{ user }}
    - group: {{ user }}
    - cwd: /tmp
    - shell: /bin/bash
    - require:
      - sls: bitcurator.packages.gnome-tweaks
