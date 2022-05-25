include:
  - bitcurator.packages.git
  - bitcurator.packages.build-essential

dumpfloppy-git-configure:
  git.config_set:
    - name: http.sslVerify
    - value: false
    - global: True

dumpfloppy-source:
  git.cloned:
    - name: https://offog.org/git/dumpfloppy.git
    - target: /tmp/dumpfloppy
#    - user: root
#    - force_checkout: True
#    - force_reset: True
    - require:
      - sls: bitcurator.packages.git
      - sls: bitcurator.packages.build-essential

dumpfloppy-build:
  cmd.run:
    - names: 
      - aclocal --force
      - autoconf -f
      - automake --add-missing
      - ./configure
      - make
      - make install
      - ldconfig
    - cwd: /tmp/dumpfloppy/
    - shell: /bin/bash
    - unless: test -x /usr/local/bin/dumpfloppy
    - require:
      - git: dumpfloppy-source

dumpfloppy-cleanup:
  file.absent:
    - name: /tmp/dumpfloppy/
    - require:
      - cmd: dumpfloppy-build

dumpfloppy-git-reset:
  git.config_set:
    - name: http.sslVerify
    - value: true
    - global: True
    - require:
      - cmd: dumpfloppy-build
