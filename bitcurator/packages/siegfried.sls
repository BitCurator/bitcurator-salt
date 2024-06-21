# Name: siegfried
# Website: https://github.com/richardlehane/siegfried
# Description: Signature-based file format identification
# Category: 
# Author: Richard Lehane
# License: Apache License 2.0 (https://github.com/richardlehane/siegfried/blob/main/LICENSE.txt)
# Version: 1.11.0
# Notes: Temporarily installed using deb package

{% set version = '1.11.0' %}
{% set hash = '95422e7cb250b4e759187e80a8a35c02ddc09e47bd95cf15c3706837de4983a3' %}

siegfried-pkg-download:
  file.managed:
    - name: /tmp/siegfried_{{ version }}-1_amd64.deb
    - source: https://github.com/richardlehane/siegfried/releases/download/v{{ version }}/siegfried_{{ version }}-1_amd64.deb
    - source_hash: sha256={{ hash }}
    - makedirs: True

siegfried-install:
  pkg.installed:
    - sources:
      - siegfried: /tmp/siegfried_{{ version }}-1_amd64.deb
    - require:
      - file: siegfried-pkg-download

