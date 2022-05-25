{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
bitcurator-user-{{ user }}:
  user.present:
    - name: {{ user }}
    - home: {{ home }}
{% else %}
bitcurator-user-{{ user }}:
  group.present:
    - name: {{ user }}
  user.present:
    - name: {{ user }}
    - gid: {{ user }}
    - fullname: BitCurator
    - shell: /bin/bash
    - home: {{ home }}
    - password: $6$xyz$MupamTWNaNx5O.weIQ3PD0qubs.VFMVRc2qMV5bdv5OAj9gSk1mMf4lcRXUNgOip507Kx5uZ1yD9cZSEHXGOT0
{% endif %}
