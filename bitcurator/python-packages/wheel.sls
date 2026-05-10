{% set codename = grains['oscodename'] %}

{% set install_wheel = {
     'jammy':    True,
     'noble':    False,
     'resolute': False,
   }.get(codename, False) %}

{% if install_wheel %}
include:
  - bitcurator.python-packages.pip

wheel:
  pip.installed:
    - bin_env: /usr/bin/python3
    - force_reinstall: True
    - upgrade: True
    - require:
      - sls: bitcurator.python-packages.pip
{% endif %}
