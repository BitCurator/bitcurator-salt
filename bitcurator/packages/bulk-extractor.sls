{% set be_rev = 'v2.1.1' %}
{% set codename = salt['grains.get']('oscodename') %}

include:
  - bitcurator.packages.build-essential
  - bitcurator.packages.g++
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
      - sls: bitcurator.packages.g++
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

bulk-extractor-bootstrap:
  cmd.run:
    - name: ./bootstrap.sh
    - cwd: /usr/local/src/bulk_extractor
    - require:
      - git: bulk-extractor-source

bulk-extractor-configure:
  cmd.run:
{% if codename == 'resolute' %}
    - name: ./configure CC=gcc-13 CXX=g++-13
{% else %}
    - name: ./configure
{% endif %}
    - cwd: /usr/local/src/bulk_extractor
    - require:
      - cmd: bulk-extractor-bootstrap

{% if codename == 'resolute' %}
# Strip unbalanced -Wl,--push-state/--pop-state directives that autoconf
# scrambles when concatenating abseil/re2 pkg-config output into LIBS.
# Modern strict linkers (binutils 2.43+, mold, lld) reject the resulting
# malformed link line. Remove once upstream fixes configure.ac.
bulk-extractor-strip-linker-state-directives:
  cmd.run:
    - name: sed -i 's/-Wl,--pop-state//g; s/-Wl,--push-state,--as-needed//g' src/Makefile
    - cwd: /usr/local/src/bulk_extractor
    - onlyif: grep -q 'push-state\|pop-state' src/Makefile
    - require:
      - cmd: bulk-extractor-configure
{% endif %}

bulk-extractor-make:
  cmd.run:
    - name: make -s
    - cwd: /usr/local/src/bulk_extractor
    - require:
      - cmd: bulk-extractor-configure
{% if codename == 'resolute' %}
      - cmd: bulk-extractor-strip-linker-state-directives
{% endif %}

bulk-extractor-install:
  cmd.run:
    - name: make install -s
    - cwd: /usr/local/src/bulk_extractor
    - require:
      - cmd: bulk-extractor-make

bulk-extractor-cleanup:
  file.absent:
    - name: /usr/local/src/bulk_extractor
    - require:
      - cmd: bulk-extractor-install
