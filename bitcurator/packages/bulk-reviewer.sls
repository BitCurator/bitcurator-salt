{% set version = "0.3.1" %}
{% set hash = 'a1df480582468dfded74119e27573da9e7fa6ef7ecbc6dbd814cdcdfc845dadc' %}

include:
  - bitcurator.packages.libfuse-dev

bulk-reviewer-download:
  file.managed:
    - name: /usr/share/bulk-reviewer/BulkReviewer-{{ version }}.AppImage
    - source: https://github.com/bulk-reviewer/bulk-reviewer/releases/download/v{{ version }}/BulkReviewer-{{ version }}.AppImage
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - mode: 755
    - require:
      - sls: bitcurator.packages.libfuse-dev

bulk-reviewer-wrapper:
  file.managed:
    - name: /usr/local/bin/bulk-reviewer
    - mode: 755
    - contents:
      - '#!/bin/bash'
      - '/usr/share/bulk-reviewer/BulkReviewer-{{ version }}.AppImage --no-sandbox &'
    - require:
      - file: bulk-reviewer-download

bulk-reviewer-icon:
  file.managed:
    - name: /usr/share/icons/bitcurator/bulk-reviewer.png
    - source: https://github.com/bulk-reviewer/bulk-reviewer/raw/main/build/icons/512x512.png
    - source_hash: sha256=4380f5442b9940cdbc710ebaec22ea447257d0f694ed8d2b03d0af9b36f29eb2
    - makedirs: True
    - mode: 755
    - require:
      - file: bulk-reviewer-wrapper

