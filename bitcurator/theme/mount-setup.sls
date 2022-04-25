{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

include:
  - bitcurator.packages.gnome-tweaks

{% if grains['oscodename'] == "bionic" %}

mount-setup:
  cmd.run:
    - names:
      - gsettings set org.gnome.nautilus.desktop volumes-visible true
      - gsettings set org.gnome.desktop.media-handling automount false
      - gsettings set org.gnome.desktop.media-handling automount-open false
    - user: {{ user }}
    - group: {{ user }}
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 12000
    - require:
      - sls: bitcurator.packages.gnome-tweaks

{% elif grains['oscodename'] == "focal" %}

mount-setup:
  cmd.run:
    - names:
      - gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true
      - gsettings set org.gnome.desktop.media-handling automount false
      - gsettings set org.gnome.desktop.media-handling automount-open false
    - user: {{ user }}
    - group: {{ user }}
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 12000
    - require:
      - sls: bitcurator.packages.gnome-tweaks

{% endif %}
