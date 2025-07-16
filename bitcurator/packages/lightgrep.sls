# Name: lightgrep
# Website: https://github.com/strozfriedberg/lightgrep
# Description: Regular Expression engine
# Category: Utilities
# Author: Stroz Friedberg LLC
# License: Apache License 2.0 (https://github.com/strozfriedberg/lightgrep/blob/main/LICENSE.txt)
# Version: 1.5.0
# Notes: lightgrep

{% set version = '1.5.0' %}
{% set hash = 'fe7aa3ed64472b6f57b5048b5584d3df2794507747e5d76213f60c256f8c82fa' %}

include:
  - bitcurator.packages.build-essential
  - bitcurator.packages.git
  - bitcurator.packages.pkg-config
  - bitcurator.packages.dh-autoreconf
  - bitcurator.packages.libicu-dev
  - bitcurator.packages.libboost-dev
  - bitcurator.packages.bison
  - bitcurator.packages.libboost-program-options-dev

bitcurator-package-lightgrep-download:
  file.managed:
    - name: /usr/local/src/files/lightgrep-{{ version }}.tar.gz
    - source: https://github.com/strozfriedberg/lightgrep/releases/download/{{ version }}/lightgrep-{{ version }}.tar.gz
    - source_hash: sha256={{ hash }}
    - makedirs: True

bitcurator-package-lightgrep-extract:
  archive.extracted:
    - name: /usr/local/src/
    - source: /usr/local/src/files/lightgrep-{{ version }}.tar.gz
    - enforce_toplevel: False
    - require:
      - file: bitcurator-package-lightgrep-download

bitcurator-package-lightgrep-rename:
  file.rename:
    - name: /usr/local/src/lightgrep
    - source: /usr/local/src/lightgrep-{{ version }}
    - force: True
    - require:
      - archive: bitcurator-package-lightgrep-extract

bitcurator-package-lightgrep-build:
  cmd.run:
    - names:
      - autoreconf -fi
      - ./configure
      - make -j8
      - make install
      - ldconfig
    - cwd: /usr/local/src/lightgrep
    - require:
      - file: bitcurator-package-lightgrep-download
      - archive: bitcurator-package-lightgrep-extract
      - file: bitcurator-package-lightgrep-rename
      - sls: bitcurator.packages.build-essential
      - sls: bitcurator.packages.git
      - sls: bitcurator.packages.pkg-config
      - sls: bitcurator.packages.dh-autoreconf
      - sls: bitcurator.packages.libicu-dev
      - sls: bitcurator.packages.libboost-dev
      - sls: bitcurator.packages.bison
      - sls: bitcurator.packages.libboost-program-options-dev

bitcurator-package-lightgrep-cleanup:
  file.absent:
    - name: /usr/local/src/lightgrep
    - require:
      - cmd: bitcurator-package-lightgrep-build
