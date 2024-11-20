{% if grains['oscodename'] == 'focal' %}
  {% set be_rev = 'v2.0.0' %}
{% else %}
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

bulk-extractor-cleanup:
  file.absent:
    - name: /usr/local/src/bulk_extractor
    - require:
      - cmd: bulk-extractor-build
