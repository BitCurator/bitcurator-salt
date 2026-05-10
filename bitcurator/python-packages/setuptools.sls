{% set codename = grains['oscodename'] %}

{% set install_setuptools = {
     'jammy':    True,
     'noble':    False,
     'resolute': False,
   }.get(codename, False) %}

{% if install_setuptools %}
include:
  - bitcurator.python-packages.pip

setuptools:
  pip.installed:
    - bin_env: /usr/bin/python3
    - force_reinstall: True
    - upgrade: True
    - require:
      - sls: bitcurator.python-packages.pip
{% else %}
setuptools:
  test.nop: []
{% endif %}
