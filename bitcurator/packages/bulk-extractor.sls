{% set files = ['build_stoplist.py', 'bulk_diff.py', 'cda_tool.py', 'post_process_exif.py'] %}
{% if grains['oscodename'] == 'focal' %}
  {% set py_ver = 'python3.8' %}
  {% set be_rev = 'v2.0.0' %}
{% elif grains['oscodename'] == 'jammy' %}
  {% set py_ver = 'python3.10' %}
  {% set be_rev = 'v2.1.1' %}
{% else %}
  {% set py_ver = 'python3.12' %}
  {% set be_rev = 'v2.1.1' %}
{% endif %}

include:
  - bitcurator.packages.build-essential
  - bitcurator.packages.libssl-dev
  - bitcurator.packages.flex
  - bitcurator.packages.libewf
  - bitcurator.packages.libewf-dev
  - bitcurator.packages.libexpat1-dev
  - bitcurator.packages.libre2-dev
  - bitcurator.packages.libxml2-utils
  - bitcurator.packages.libtool
  - bitcurator.packages.pkg-config
  - bitcurator.packages.zlib1g-dev
  - bitcurator.packages.make
  - bitcurator.packages.git

bulk-extractor-source:
  git.latest:
    - name: https://github.com/simsong/bulk_extractor
    - target: /usr/local/src/bulk_extractor
    - user: root
    - rev: {{ be_rev }}
    - submodules: True
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.build-essential
      - sls: bitcurator.packages.libssl-dev
      - sls: bitcurator.packages.flex
      - sls: bitcurator.packages.libewf
      - sls: bitcurator.packages.libewf-dev
      - sls: bitcurator.packages.libexpat1-dev
      - sls: bitcurator.packages.libre2-dev
      - sls: bitcurator.packages.libxml2-utils
      - sls: bitcurator.packages.libtool
      - sls: bitcurator.packages.pkg-config
      - sls: bitcurator.packages.zlib1g-dev
      - sls: bitcurator.packages.make
      - sls: bitcurator.packages.git

bulk-extractor-build:
  cmd.run:
    - names:
      - ./bootstrap.sh
      - ./configure
      - make -s
      - make install -s
    - cwd: /usr/local/src/bulk_extractor
    - require:
      - git: bulk-extractor-source

{% for file in files %}

bulk-extractor-{{ file }}:
  file.managed:
    - name: /usr/local/bin/{{ file }}
    - source: /usr/local/src/bulk_extractor/python/{{ file }}
    - user: root
    - group: root
    - makedirs: True
    - mode: 0755
    - require:
      - git: bulk-extractor-source

{% endfor %}

bulk-extractor-identify-filenames:
  file.managed:
    - name: /usr/local/bin/identify_filenames.py
    - source: salt://bitcurator/files/identify_filenames.py
    - user: root
    - group: root
    - mode: 0755
    - require:
      - git: bulk-extractor-source

bulk-extractor-bulk-extractor-reader:
  file.managed:
    - name: /usr/local/lib/{{ py_ver }}/dist-packages/bulk_extractor_reader.py
    - source: /usr/local/src/bulk_extractor/python/bulk_extractor_reader.py
    - user: root
    - group: root
    - makedirs: True
    - mode: 0644
    - require:
      - git: bulk-extractor-source

bulk-extractor-cleanup:
  file.absent:
    - name: /usr/local/src/bulk_extractor
    - require:
      - cmd: bulk-extractor-build
