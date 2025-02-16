# Name: lightgrep
# Website: https://github.com/strozfriedberg/lightgrep
# Description: Regular Expression engine
# Category: Utilities
# Author: Stroz Friedberg LLC
# License: Apache License 2.0 (https://github.com/strozfriedberg/lightgrep/blob/main/LICENSE.txt)
# Version: 1.5.0
# Notes: lightgrep

include:
  - bitcurator.packages.build-essential
  - bitcurator.packages.git
  - bitcurator.packages.pkg-config
  - bitcurator.packages.dh-autoreconf
  - bitcurator.packages.libicu-dev
  - bitcurator.packages.libboost-dev
  - bitcurator.packages.bison
  - bitcurator.packages.libboost-program-options-dev

bitcurator-package-lightgrep-git:
  git.latest:
    - name: https://github.com/strozfriedberg/lightgrep
    - target: /usr/local/src/lightgrep
    - user: root
    - submodules: True
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git

bitcurator-package-lightgrep-build:
  cmd.run:
    - names:
      - autoreconf -fi
      - ./configure
      - make -j4
      - make install
      - ldconfig
    - cwd: /usr/local/src/lightgrep
    - require:
      - git: bitcurator-package-lightgrep-git
      - sls: bitcurator.packages.build-essential
      - sls: bitcurator.packages.git
      - sls: bitcurator.packages.pkg-config
      - sls: bitcurator.packages.dh-autoreconf
      - sls: bitcurator.packages.libicu-dev
      - sls: bitcurator.packages.libboost-dev
      - sls: bitcurator.packages.bison
      - sls: bitcurator.packages.libboost-program-options-dev

bitcurator-package-lightgrep-cleanup:
  file.absent:
    - name: /usr/local/src/lightgrep
    - require:
      - cmd: bitcurator-package-lightgrep-build
