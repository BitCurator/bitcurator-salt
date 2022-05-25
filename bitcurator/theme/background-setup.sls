{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

#include:
#  - bitcurator.packages.ubuntu-gnome-desktop

background-setup:
  cmd.run:
    - names:
      - gsettings set org.gnome.desktop.background primary-color '#3464A2'
      - gsettings set org.gnome.desktop.background secondary-color '#3464A2'
      - gsettings set org.gnome.desktop.background color-shading-type 'solid'
      - gsettings set org.gnome.desktop.background draw-background false
      - gsettings set org.gnome.desktop.background picture-uri file:///usr/share/bitcurator/resources/images/BitCuratorEnv3Logo300px.png
      - gsettings set org.gnome.desktop.background draw-background true
    - user: {{ user }}
    - group: {{ user }}
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 12000
#    - require:
#      - sls: bitcurator.packages.ubuntu-gnome-desktop
