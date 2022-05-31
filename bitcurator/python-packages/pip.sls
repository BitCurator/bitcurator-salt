include:
  - bitcurator.packages.python3-pip

bitcurator-python-packages-pip3:
  pip.installed:
    - name: pip>=21.2.4
    - bin_env: /usr/bin/python3
    - require:
      - sls: bitcurator.packages.python3-pip
