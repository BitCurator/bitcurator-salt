{% set version = '2021.10.9' %}
{% set hash = '1dfc2183ebcd5f4ca283def3d3a0061542bdbf43d62a1c35208a4b95bf2b9d8e' %}

include:
  - bitcurator.packages.openjdk-8-jdk

hfsexplorer-download:
  file.managed:
    - name: /tmp/hfsexplorer-{{ version }}-bin.zip
    - source: https://github.com/unsound/hfsexplorer/releases/download/hfsexplorer-{{ version }}/hfsexplorer-{{ version }}-bin.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

hfsexplorer-extract:
  archive.extracted:
    - name: /usr/share/hfsexplorer/
    - source: /tmp/hfsexplorer-{{ version }}-bin.zip
    - enforce_toplevel: False
    - require:
      - file: hfsexplorer-download

hfsexplorer-wrapper:
  file.managed:
    - name: /usr/local/bin/hfsexplorer
    - mode: 755
    - contents:
      - '#!/bin/bash'
      - /usr/share/hfsexplorer/bin/hfsexplorer "$@"
    - require:
      - sls: bitcurator.packages.openjdk-8-jdk

hfsexplorer-cleanup:
  file.absent:
    - name: /tmp/hfsexplorer-{{ version }}-bin.zip
    - require:
      - archive: hfsexplorer-extract
      - file: hfsexplorer-wrapper
