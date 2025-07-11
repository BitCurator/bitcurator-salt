{% if grains['oscodename'] != 'noble' %}

include:
  - bitcurator.packages.python3-pip

bitcurator-python-packages-pip3:
  pip.installed:
    - name: pip>=24.3.1
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: bitcurator.packages.python3-pip

{% else %}
Pip installation via pip not required for Noble:
  test.nop

{% endif %}
