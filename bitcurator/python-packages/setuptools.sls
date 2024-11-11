{% if grains['oscodename'] != 'noble' %}

include:
  - bitcurator.python-packages.pip

setuptools:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: bitcurator.python-packages.pip

{% else %}
Noble requires a virtualenv to install setuptools via pip:
  test.nop

{% endif %}

