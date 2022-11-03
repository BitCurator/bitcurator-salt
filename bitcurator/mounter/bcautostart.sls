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

{{ home }}/.config/autostart/bcpolicyapp.py.desktop:
  file.managed:
    - source: salt://bitcurator/mounter/bcpolicyapp.py.desktop
    - user: {{ user }}
    - group: {{ group }}
    - mode: 755
    - makedirs: True
    - require:
      - user: bitcurator-user-{{ user }}
