include:
  - bitcurator.packages.build-essential
  - bitcurator.tools.protobuf

sdhash-source:
  file.managed:
    - name: /tmp/v4.0.tar.gz
    - source: https://github.com/sdhash/sdhash/archive/v4.0.tar.gz
    - source_hash: sha256=5d45974c3096311f0ad4ddd872094dcf2db17bdb5ab874ce04971ba23011e1d7

sdhash-extract:
  archive.extracted:
    - name: /tmp/sdhash/
    - source: /tmp/v4.0.tar.gz
    - enforce_toplevel: False
    - require:
      - file: sdhash-source

sdhash-build:
  cmd.run:
    - names:
      - make
      - make install
      - ldconfig
    - cwd: /tmp/sdhash/sdhash-4.0/
    - shell: /bin/bash
    - require:
      - archive: sdhash-extract
    - unless: test -x /usr/local/bin/sdhash

sdhash-cleanup:
  file.absent:
    - names:
      - /tmp/v4.0.tar.gz
      - /tmp/sdhash/
    - require:
      - cmd: sdhash-build
