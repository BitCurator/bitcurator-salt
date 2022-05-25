{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

include:
  - bitcurator.packages.gnome-tweaks

{% if grains['oscodename'] == "bionic" %}
icon-setup:
  cmd.run:
    - names:
      - gsettings set org.gnome.desktop.background show-desktop-icons true
      - gsettings set org.gnome.nautilus.desktop home-icon-visible true
      - gsettings set org.gnome.nautilus.desktop trash-icon-visible true
      - gsettings set org.gnome.nautilus.desktop network-icon-visible true
    - user: {{ user }}
    - group: {{ user }}
    - cwd: /tmp
    - shell: /bin/bash
    - require:
      - sls: bitcurator.packages.gnome-tweaks

{% elif grains['oscodename'] == "focal" %}
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
{% endif %}
