include:
  - bitcurator.packages.git
  - bitcurator.packages.build-essential
  - bitcurator.packages.libboost-dev
  - bitcurator.packages.libewf-dev
  - bitcurator.packages.zlib1g-dev

hashdb-source:
  git.latest:
    - name: https://github.com/NPS-DEEP/hashdb
    - target: /tmp/hashdb
    - branch: master
    - force_reset: True
    - force_checkout: True
    - user: root
    - require:
      - sls: bitcurator.packages.git

hashdb-build:
  cmd.run:
    - names:
      - ./bootstrap.sh
      - ./configure
      - make
      - make install
      - ldconfig
    - cwd: /tmp/hashdb/
    - shell: /bin/bash
    - require:
      - git: hashdb-source
      - sls: bitcurator.packages.build-essential
      - sls: bitcurator.packages.libboost-dev
      - sls: bitcurator.packages.libewf-dev
      - sls: bitcurator.packages.zlib1g-dev

hashdb-cleanup:
  file.absent:
    - name: /tmp/hashdb/
    - require:
      - cmd: hashdb-build
