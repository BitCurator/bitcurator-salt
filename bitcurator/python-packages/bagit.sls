include:
  - bitcurator.packages.python3-virtualenv

bagit-venv:
  virtualenv.managed:
    - name: /opt/bagit
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: bitcurator.packages.python3-virtualenv

bagit:
  pip.installed:
    - bin_env: /opt/bagit/bin/python3
    - upgrade: True
    - require:
      - virtualenv: bagit-venv

bagit-symlink:
  file.symlink:
    - name: /usr/local/bin/bagit.py
    - target: /opt/bagit/bin/bagit.py
    - force: True
    - makedirs: False
    - require:
      - pip: bagit
