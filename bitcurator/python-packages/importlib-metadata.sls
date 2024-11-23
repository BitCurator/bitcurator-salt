{% if grains['oscodename'] != 'noble' %}

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

Forced version upgrade of importlib_metadata not required for Noble:
  test.nop

{% endif %}
