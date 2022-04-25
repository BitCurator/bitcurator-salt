include:
  - bitcurator.packages.python3
  - bitcurator.packages.git

bitcurator-python-packages-dfxml:
  pip.installed:
    - name: git+https://github.com/dfxml-working-group/dfxml_python.git
    - bin_env: /usr/bin/python3
    - require:
      - sls: bitcurator.packages.python3
      - sls: bitcurator.packages.git

