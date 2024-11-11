# Required by identify_filenames.py
{% if grains['oscodename'] != 'noble' %}

include:
  - bitcurator.python-packages.pip

et_xmlfile:
  pip.installed:
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: bitcurator.python-packages.pip

{% else %}
Noble requires a virtualenv to install et_xmlfile via pip:
  test.nop

{% endif %}

