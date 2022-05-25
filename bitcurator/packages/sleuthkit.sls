{%- set base_url = "https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-" -%}
{%- set version = "4.11.1" -%}
{%- set filename = "sleuthkit-4.11.1.tar.gz" -%}
{%- set hash = "8ad94f5a69b7cd1a401afd882ab6b8e5daadb39dd2a6a3bbd5aecee2a2ea57a0" -%}
{%- set files = ['ficlam.sh','clamconfig.txt','ficonfig.txt'] -%}

{% if grains['oscodename'] == "focal" %}

include:
  - bitcurator.repos.gift
  - bitcurator.packages.libewf-dev
  - bitcurator.packages.libvmdk-dev
  - bitcurator.packages.libafflib-dev
  - bitcurator.packages.zlib1g-dev
  - bitcurator.packages.libvhdi-dev
  - bitcurator.packages.build-essential

{% elif grains['oscodename'] == "bionic" %}

include:
  - bitcurator.packages.libewf-dev
  - bitcurator.packages.libvmdk-dev
  - bitcurator.packages.libafflib-dev
  - bitcurator.packages.zlib1g-dev
  - bitcurator.packages.libvhdi-dev
  - bitcurator.packages.build-essential

{% endif %}

bitcurator-packages-sleuthkit-source:
  file.managed:
    - name: /usr/local/src/bitcurator/files/{{ filename }}
    - source: {{ base_url }}{{ version }}/{{ filename }}
    - source_hash: sha256={{ hash }}
    - makedirs: true

bitcurator-packages-sleuthkit-archive:
  archive.extracted:
    - name: /usr/local/src/bitcurator/
    - source: /usr/local/src/bitcurator/files/{{ filename }}
    - enforce_toplevel: true
    - watch:
      - file: bitcurator-packages-sleuthkit-source

{% for file in files %}

bitcurator-packages-plugin-{{ file }}:
  file.managed:
    - name: /usr/local/src/bitcurator/sleuthkit-{{ version }}/tools/fiwalk/plugins/{{ file }}
    - source: salt://bitcurator/files/{{ file }}
    - require:
      - archive: bitcurator-packages-sleuthkit-archive

{% endfor %}

bitcurator-packages-sleuthkit-configure:
  cmd.run:
    - name: ./configure && make && make install
    - unless: test -x /usr/local/bin/tsk_loaddb && test $(tsk_loaddb -V | awk '{print $5}') = {{ version }}
    - cwd: /usr/local/src/bitcurator/sleuthkit-{{ version }}
    - watch:
      - archive: bitcurator-packages-sleuthkit-archive
    - require:
      - sls: bitcurator.packages.libewf-dev
      - sls: bitcurator.packages.libvmdk-dev
      - sls: bitcurator.packages.libafflib-dev
      - sls: bitcurator.packages.zlib1g-dev
      - sls: bitcurator.packages.libvhdi-dev
      - sls: bitcurator.packages.build-essential

bitcurator-packages-sleuthkit-rm-dir:
  file.absent:
    - name: /usr/local/src/bitcurator/sleuthkit-{{ version }}
    - watch:
      - cmd: bitcurator-packages-sleuthkit-configure
