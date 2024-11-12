include:
  - bitcurator.packages.python3-virtualenv

imagemounter-venv:
  virtualenv.managed:
    - name: /opt/imagemounter
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - python-magic>=0.4.27
      - pytsk>=20231007
    - require:
      - sls: bitcurator.packages.python3-virtualenv

imagemounter:
  pip.installed:
    - bin_env: /opt/imagemounter/bin/python3
    - upgrade: True
    - require:
      - virtualenv: imagemounter-venv

imagemounter-symlink:
  file.symlink:
    - name: /usr/local/bin/imount
    - target: /opt/imagemounter/bin/imount
    - makedirs: False
    - require:
      - pip: imagemounter

