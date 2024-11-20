include:
  - bitcurator.python-packages.importlib-metadata
  - bitcurator.python-packages.analyzemft
  - bitcurator.python-packages.bagit
  - bitcurator.python-packages.brunnhilde
  - bitcurator.python-packages.imagemounter
  - bitcurator.python-packages.opf-fido
  - bitcurator.python-packages.python-evtx
  - bitcurator.python-packages.bitcurator-python-tools
  - bitcurator.python-packages.pip
  - bitcurator.python-packages.setuptools
  - bitcurator.python-packages.wheel

bitcurator-python-packages:
  test.nop:
    - name: bitcurator-python-packages
    - require:
      - sls: bitcurator.python-packages.importlib-metadata
      - sls: bitcurator.python-packages.analyzemft
      - sls: bitcurator.python-packages.bagit
      - sls: bitcurator.python-packages.brunnhilde
      - sls: bitcurator.python-packages.imagemounter
      - sls: bitcurator.python-packages.opf-fido
      - sls: bitcurator.python-packages.python-evtx
      - sls: bitcurator.python-packages.bitcurator-python-tools
      - sls: bitcurator.python-packages.pip
      - sls: bitcurator.python-packages.setuptools
      - sls: bitcurator.python-packages.wheel
