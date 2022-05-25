{% if grains['oscodename'] == "bionic" %}

include:
  - bitcurator.packages.build-essential
  - bitcurator.packages.autotools-dev
  - bitcurator.packages.autoconf
  - bitcurator.packages.automake
  - bitcurator.packages.autopoint
  - bitcurator.packages.libtool
  - bitcurator.packages.pkg-config
  - bitcurator.packages.libfuse-dev
  - bitcurator.packages.libssl-dev
  - bitcurator.packages.zlib1g-dev
  - bitcurator.packages.flex
  - bitcurator.packages.bison
  - bitcurator.tools.libuna
  - bitcurator.packages.libbz2-dev
  - bitcurator.packages.byacc

libewf-source:
  archive.extracted:
    - name: /tmp/
    - source: salt://bitcurator/files/libewf-20140608.tar.gz
    - enforce_toplevel: true

libewf-compile:
  cmd.run:
    - names:
      - ./configure --enable-v1-api
      - make
      - make install
      - ldconfig
    - cwd: /tmp/libewf-20140608
    - shell: /bin/bash
    - unless: test -x /usr/local/bin/ewfinfo
    - require:
      - sls: bitcurator.packages.build-essential
      - sls: bitcurator.packages.autotools-dev
      - sls: bitcurator.packages.autoconf
      - sls: bitcurator.packages.automake
      - sls: bitcurator.packages.autopoint
      - sls: bitcurator.packages.libtool
      - sls: bitcurator.packages.pkg-config
      - sls: bitcurator.packages.libfuse-dev
      - sls: bitcurator.packages.libssl-dev
      - sls: bitcurator.packages.zlib1g-dev
      - sls: bitcurator.packages.flex
      - sls: bitcurator.packages.bison
      - sls: bitcurator.tools.libuna
      - sls: bitcurator.packages.libbz2-dev
      - sls: bitcurator.packages.byacc

libewf2:
  pkg.installed

/tmp/libewf-20140608:
  file.absent

{% elif grains['oscodename'] == "focal" %}

libewf2:
  pkg.installed

{% endif %}
