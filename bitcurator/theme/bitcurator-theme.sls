{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
  {% set group = salt['cmd.run']('id -gn ' + user) %}
{% else %}
  {% set group = user %}
{% endif %}

include:
  - bitcurator.config.user

bitcurator-theme-config:
  file.managed:
      - name: /usr/share/bitcurator/bitcurator-theme.sh
      - source: salt://bitcurator/theme/bitcurator-theme.sh
      - mode: 755
      - makedirs: True

bitcurator-theme-config-autostart:
  file.managed:
    - replace: False
    - user: {{ user }}
    - group: {{ group }}
    - name: {{ home }}/.config/autostart/bitcurator-theme.desktop
    - source: salt://bitcurator/theme/bitcurator-theme.desktop
    - makedirs: True
    - require:
      - user: bitcurator-user-{{ user }}
      - file: bitcurator-theme-config
