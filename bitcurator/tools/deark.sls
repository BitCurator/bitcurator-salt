# Name: deark
# Website: https://entropymine.com/deark/
# Description: File extraction and conversion tool
# Category: 
# Author: Jason Summers
# License: MIT-Style (https://github.com/jsummers/deark/blob/master/COPYING)
# Version: 1.6.7
# Notes: 

{% set version = 'v1.6.7' %}

include:
  - bitcurator.packages.git
  - bitcurator.packages.build-essential

deark-git:
  git.latest:
    - name: https://github.com/jsummers/deark
    - target: /usr/local/src/deark
    - user: root
    - rev: {{ version }}
    - submodules: True
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git
      - sls: bitcurator.packages.build-essential

deark-build:
  cmd.run:
    - names:
      - make -s
      - make install -s
    - cwd: /usr/local/src/deark

deark-cleanup:
  file.absent:
    - name: /usr/local/src/deark
    - require:
      - git: deark-git
      - cmd: deark-build
