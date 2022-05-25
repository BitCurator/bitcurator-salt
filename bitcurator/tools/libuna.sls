{% set version = '20220102' %}
{% set hash = '349e2c40e88b1248a2766a2b67699c17b3de3b90a2ffbe63c858ef4e9fcb0694' %}

include:
  - bitcurator.packages.build-essential

libuna-source:
  file.managed:
    - name: /tmp/libuna-alpha-{{ version }}.tar.gz
    - source: https://github.com/libyal/libuna/releases/download/{{ version }}/libuna-alpha-{{ version }}.tar.gz
    - source_hash: sha256={{ hash }}
    - makedirs: True

libuna-extract:
  archive.extracted:
    - name: /tmp/
    - source: /tmp/libuna-alpha-{{ version }}.tar.gz
    - enforce_toplevel: False

libuna-install:
  cmd.run:
    - names: 
      - ./configure
      - make
      - make install
      - ldconfig
    - cwd: /tmp/libuna-{{ version }}
    - shell: /bin/bash
    - unless: test -x /usr/local/bin/unabase

libuna-cleanup:
  file.absent:
    - names:
      - /tmp/libuna-{{ version }}/
      - /tmp/libuna-alpha-{{ version }}.tar.gz
