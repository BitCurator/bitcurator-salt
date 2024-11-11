include:
  - bitcurator.packages.python3-virtualenv

analyzemft-venv:
  virtualenv.managed:
    - name: /opt/analyzemft
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: bitcurator.packages.python3-virtualenv

analyzemft:
  pip.installed:
    - bin_env: /opt/analyzemft/bin/python3
    - upgrade: True
    - require:
      - virtualenv: analyzemft-venv

analyzemft-symlink:
  file.symlink:
    - name: /usr/local/bin/analyzemft
    - target: /opt/analyzemft/bin/analyzemft
    - makedirs: False
    - require:
      - pip: analyzemft
