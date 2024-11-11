# Required by identify_filenames.py

{% if grains['oscodename'] != 'noble' %}

include:
  - bitcurator.packages.git
  - bitcurator.packages.python-is-python3
  - bitcurator.python-packages.pip

bitcurator-python-packages-dfxml:
  pip.installed:
    - name: git+https://github.com/dfxml-working-group/dfxml_python.git
    - bin_env: /usr/bin/python3
    - require:
      - sls: bitcurator.packages.git
      - sls: bitcurator.packages.python-is-python3
      - sls: bitcurator.python-packages.pip

{% else %}
Noble requires a virtualenv to install dfxml-python via pip:
  test.nop

{% endif %}
