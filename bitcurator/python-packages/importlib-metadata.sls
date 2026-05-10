{% set codename = grains['oscodename'] %}

{% set install_importlib_metadata = {
     'jammy':    True,
     'noble':    False,
     'resolute': False,
   }.get(codename, False) %}

{% if install_importlib_metadata %}
include:
  - bitcurator.python-packages.pip

importlib_metadata:
  pip.installed:
    - bin_env: /usr/bin/python3
    - force_reinstall: True
    - upgrade: True
    - require:
      - sls: bitcurator.python-packages.pip
{% else %}
importlib_metadata:
  test.nop: []
{% endif %}
