{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}

include:
  - bitcurator.config.user.user
  - bitcurator.theme.xhost

bitcurator-theme-terminal-profile-file:
  file.managed:
    - name: /usr/share/bitcurator/resources/terminal-profile.txt
    - source: salt://bitcurator/theme/terminal-profile.txt
    - user: root
    - group: root
    - mode: 0644
    - makedirs: True

bitcurator-dbus-address:
  cmd.run:
    - name: export DBUS_SESSION_BUS_ADDRESS=$(dbus-launch | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-)
    - shell: /bin/bash
    - runas: {{ user }}
    - cwd: {{ home }}
    - require:
      - user: bitcurator-user-{{ user }}
      - sls: bitcurator.theme.xhost

bitcurator-theme-terminal-profile-install:
  cmd.run:
    - name: dconf load /org/gnome/terminal/legacy/profiles:/ < /usr/share/bitcurator/resources/terminal-profile.txt
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - require:
      - file: bitcurator-theme-terminal-profile-file
      - user: bitcurator-user-{{ user }}
      - sls: bitcurator.theme.xhost
      - cmd: bitcurator-dbus-address
    - watch:
      - file: bitcurator-theme-terminal-profile-file
      - sls: bitcurator.theme.xhost
      - cmd: bitcurator-dbus-address
