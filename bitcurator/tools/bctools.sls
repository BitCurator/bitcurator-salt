include:
  - bitcurator.packages.git
  - bitcurator.packages.python3

bctools-source:
  git.latest:
    - name: https://github.com/bitcurator/bitcurator-distro-tools
    - target: /tmp/bctools
    - user: root
    - rev: main
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git

bctools-build:
  cmd.run:
    - name: /usr/bin/python3 setup.py build
    - cwd: /tmp/bctools
    - require:
      - git: bctools-source

bctools-install:
  pip.installed:
    - bin_env: /usr/bin/python3
    - name: /tmp/bctools/

bctools-cleanup:
  file.absent:
    - name: /tmp/bctools/
