{% set version = '20220611' %}
{% set hash = '20791e301d768be4b61f1ef551f304d0c386c32a78efa6619fa4cafa8ab9f231' %}

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
      - make -s
      - make install -s
      - ldconfig
    - cwd: /tmp/libuna-{{ version }}
    - shell: /bin/bash
    - unless: test -x /usr/local/bin/unabase

libuna-cleanup:
  file.absent:
    - names:
      - /tmp/libuna-{{ version }}/
      - /tmp/libuna-alpha-{{ version }}.tar.gz
