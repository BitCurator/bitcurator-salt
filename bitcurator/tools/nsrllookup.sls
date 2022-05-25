include:
  - bitcurator.packages.build-essential
  - bitcurator.packages.cmake
  - bitcurator.packages.libboost-dev

nsrllookup-source:
  file.managed:
    - name: /tmp/1.4.2.tar.gz
    - source: https://github.com/rjhansen/nsrllookup/archive/refs/tags/1.4.2.tar.gz
    - source_hash: sha256=bdc17e38880f909eeaec60804db2276761c309279735eb42c781f6757edd4061

nsrllookup-extract:
  archive.extracted:
    - name: /tmp/
    - source: /tmp/1.4.2.tar.gz
    - enforce_toplevel: False
    - require:
      - file: nsrllookup-source

nsrllookup-build:
  cmd.run:
    - names:
      - cmake -D CMAKE_BUILD_TYPE=Release .
      - make
      - make install
    - cwd: /tmp/nsrllookup-1.4.2
    - shell: /bin/bash
    - require:
      - archive: nsrllookup-extract
      - sls: bitcurator.packages.build-essential
      - sls: bitcurator.packages.cmake
      - sls: bitcurator.packages.libboost-dev
    - unless: test -x /usr/local/bin/nsrllookup

nsrllookup-cleanup:
  file.absent:
    - names:
      - /tmp/nsrllookup-1.4.2/
      - /tmp/1.4.2.tar.gz
    - require:
      - cmd: nsrllookup-build
