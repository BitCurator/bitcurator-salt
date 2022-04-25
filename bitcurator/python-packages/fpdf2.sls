include:
  - bitcurator.packages.python3

fpdf2:
  pip.installed:
    - bin_env: /usr/bin/python3
    - require:
      - sls: bitcurator.packages.python3
