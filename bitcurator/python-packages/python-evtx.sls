# Name: python-evtx
# Website: https://github.com/williballenthin/python-evtx
# Description: Pure Python parser for Windows Event Log (.evtx) files
# Category:
# Author: Willi Ballenthin
# License: Apache License 2.0 (https://github.com/williballenthin/python-evtx/blob/master/LICENSE.TXT)
# Notes: evtx_dump.py, evtx_dump_chunk_slack.py, evtx_dump_json.py, evtx_info.py

{% set files = ['evtx_dump.py','evtx_dump_chunk_slack.py','evtx_dump_json.py','evtx_eid_record_numbers.py','evtx_extract_record.py','evtx_filter_records.py','evtx_info.py','evtx_record_structure.py','evtx_structure.py','evtx_templates.py'] %}

include:
  - bitcurator.packages.python3-virtualenv
  - bitcurator.packages.git

bitcurator-python-package-python-evtx-venv:
  virtualenv.managed:
    - name: /opt/python-evtx
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - xmltodict
      - lxml
    - require:
      - sls: bitcurator.packages.python3-virtualenv

bitcurator-python-package-python-evtx:
  pip.installed:
    - name: git+https://github.com/williballenthin/python-evtx.git
    - bin_env: /opt/python-evtx/bin/python3
    - upgrade: True
    - require:
      - virtualenv: bitcurator-python-package-python-evtx-venv

bitcurator-python-package-python-evtx-import-fix:
  file.replace:
    - name: /opt/python-evtx/bin/evtx_eid_record_numbers.py
    - pattern: 'from filter_records'
    - repl: 'from evtx_filter_records'
    - count: 1
    - require:
      - pip: bitcurator-python-package-python-evtx

{% for file in files %}
bitcurator-python-package-python-evtx-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/python-evtx/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: bitcurator-python-package-python-evtx
{% endfor %}
