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
  - bitcurator.packages.sleuthkit

ficlam-config:
  file.directory:
    - name: {{ home }}/.fiwalk
    - user: {{ user }}
    - group: {{ group }}
    - file_mode: 755
    - dir_mode: 755
    - makedirs: True
    - require:
      - user: bitcurator-user-{{ user }}

ficlam-script:
  file.managed:
    - name: {{ home }}/.fiwalk/ficlam.sh
    - source: salt://bitcurator/files/ficlam.sh
    - user: {{ user }}
    - group: {{ group }}
    - mode: 755
    - require:
      - sls: bitcurator.packages.sleuthkit
