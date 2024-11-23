{% set files = ['build-stoplist','bulk-diff','cda-tool','cda2-tool','identify-filenames','post-process-exif','walk_to_dfxml','make_differential_dfxml'] %}

include:
  - bitcurator.packages.python3-virtualenv
  - bitcurator.packages.git

bitcurator-python-tools-venv:
  virtualenv.managed:
    - name: /opt/bitcurator-python-tools
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: bitcurator.packages.python3-virtualenv

bitcurator-python-tools-install:
  pip.installed:
    - name: git+https://github.com/bitcurator/bitcurator-python-tools.git
    - bin_env: /opt/bitcurator-python-tools/bin/python3
    - upgrade: True
    - require:
      - virtualenv: bitcurator-python-tools-venv

bitcurator-python-tools-symlink:
  file.symlink:
    - name: /usr/local/bin/identify_filenames.py
    - target: /opt/bitcurator-python-tools/bin/identify-filenames
    - force: True
    - backupname: identify_filenames_old.py
    - require:
      - pip: bitcurator-python-tools-install

{% for file in files %}

bitcurator-python-tools-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/bitcurator-python-tools/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: bitcurator-python-tools-install

{% endfor %}

