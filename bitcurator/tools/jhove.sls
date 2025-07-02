# Name: jhove
# Website: https://jhove.openpreservation.org/
# Description: JSTOR/Harvard Object Validation Environment - File validation and characterisation
# Category: Archival
# Author: Open Preservation Foundation
# License: GNU Lesser Public License v2.1 (https://github.com/openpreserve/jhove/blob/integration/LICENSE)
# Version: 1.32.1
# Notes: Packaged separately for silent unattended installation

{% set version = '1.32.1' %}
{% set hash = '92c9f95df20b85ae604b61471846d66538482b1671969ec113e3abd75b03b1cd' %}

include:
  - bitcurator.packages.openjdk-adoptium

jhove-download:
  file.managed:
    - name: /tmp/jhove.jar
    - source: https://software.openpreservation.org/rel/jhove-latest.jar
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - mode: 755
    - require:
      - sls: bitcurator.packages.openjdk-adoptium

jhove-auto-install:
  file.managed:
    - name: /tmp/auto-install.xml
    - source: salt://bitcurator/files/auto-install.xml
    - skip_verify: True
    - require:
      - file: jhove-download

jhove-install:
  cmd.run:
    - name: /usr/bin/java -jar /tmp/jhove.jar /tmp/auto-install.xml
    - shell: /bin/bash
    - require:
      - file: jhove-auto-install

jhove-cli-symlink:
  file.symlink:
    - name: /usr/local/bin/jhove
    - target: /usr/local/src/jhove/jhove
    - force: True
    - makedirs: False
    - require:
      - cmd: jhove-install

jhove-gui-symlink:
  file.symlink:
    - name: /usr/local/bin/jhove-gui
    - target: /usr/local/src/jhove/jhove-gui
    - force: True
    - makedirs: False
    - require:
      - cmd: jhove-install
