# Name: python-evtx
# Website: https://github.com/williballenthin/python-evtx
# Description: Pure Python parser for Windows Event Log (.evtx) files
# Category:
# Author: Willi Ballenthin
# License: Apache License 2.0 (https://github.com/williballenthin/python-evtx/blob/master/LICENSE.TXT)
# Notes: evtx_dump.py, evtx_dump_chunk_slack.py, evtx_dump_json.py, evtx_info.py

{% set codename = grains['oscodename'] %}
{% set commit = '1a1357accd3a75524794a6d6dcdec03c09e1660d' %}
{% set venv_path = '/opt/python-evtx' %}

{% set files = [
     'evtx_dump',
     'evtx_dump_chunk_slack',
     'evtx_dump_json',
     'evtx_eid_record_numbers',
     'evtx_extract_record',
     'evtx_filter_records',
     'evtx_info',
     'evtx_record_structure',
     'evtx_structure',
     'evtx_templates',
   ] %}

{# Python version per Ubuntu release. Update when adding new releases. #}
{% set pyver = {
     'jammy':    '3.10',
     'noble':    '3.12',
     'resolute': '3.14',
   }.get(codename, '3.14') %}

include:
  - bitcurator.packages.python3-virtualenv
  - bitcurator.packages.git

bitcurator-python-package-python-evtx-venv:
  virtualenv.managed:
    - name: {{ venv_path }}
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - importlib-metadata>=8.0.0
      - xmltodict
      - lxml
    - require:
      - sls: bitcurator.packages.python3-virtualenv

bitcurator-python-package-python-evtx:
  pip.installed:
    - name: git+https://github.com/williballenthin/python-evtx.git@{{ commit }}
    - bin_env: {{ venv_path }}/bin/python3
    - upgrade: True
    - require:
      - virtualenv: bitcurator-python-package-python-evtx-venv

bitcurator-python-package-python-evtx-import-fix:
  file.replace:
    - name: {{ venv_path }}/lib/python{{ pyver }}/site-packages/evtx_scripts/evtx_eid_record_numbers.py
    - pattern: 'from filter_records'
    - repl: 'from evtx_scripts.evtx_filter_records'
    - count: 1
    - backup: False
    - require:
      - pip: bitcurator-python-package-python-evtx

{% for file in files %}
bitcurator-python-package-python-evtx-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}.py
    - target: {{ venv_path }}/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: bitcurator-python-package-python-evtx
{% endfor %}
