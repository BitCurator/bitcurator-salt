include:
  - bitcurator.packages.python3-virtualenv

opf-fido-venv:
  virtualenv.managed:
    - name: /opt/fido
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: bitcurator.packages.python3-virtualenv

opf-fido:
  pip.installed:
    - bin_env: /opt/fido/bin/python3
    - upgrade: True
    - require:
      - virtualenv: opf-fido-venv

opf-fido-symlink:
  file.symlink:
    - name: /usr/local/bin/fido
    - target: /opt/fido/bin/fido
    - makedirs: False
    - require:
      - pip: opf-fido
