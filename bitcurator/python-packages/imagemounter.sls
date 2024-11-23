include:
  - bitcurator.packages.python3-virtualenv
  - bitcurator.packages.afflib-tools
  - bitcurator.packages.avfs
  - bitcurator.packages.disktype
  - bitcurator.packages.libbde-utils
  - bitcurator.packages.ewf-tools
  - bitcurator.packages.libvshadow-utils
  - bitcurator.packages.ntfs-3g
  - bitcurator.packages.python3-tsk
  - bitcurator.packages.qemu-utils
  - bitcurator.packages.sleuthkit
  - bitcurator.packages.testdisk
  - bitcurator.packages.vmfs-tools
  - bitcurator.packages.xfsprogs
  - bitcurator.packages.xmount
  - bitcurator.packages.libguestfs-tools
  - bitcurator.packages.mtd-utils
  - bitcurator.packages.squashfs-tools
  - bitcurator.packages.git
  - bitcurator.packages.build-essential
  - bitcurator.packages.python3-dev


imagemounter-venv:
  virtualenv.managed:
    - name: /opt/imagemounter
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - python-magic>=0.4.27
      - pytsk3>=20231007
    - require:
      - sls: bitcurator.packages.python3-virtualenv
      - sls: bitcurator.packages.afflib-tools
      - sls: bitcurator.packages.avfs
      - sls: bitcurator.packages.disktype
      - sls: bitcurator.packages.libbde-utils
      - sls: bitcurator.packages.ewf-tools
      - sls: bitcurator.packages.libvshadow-utils
      - sls: bitcurator.packages.ntfs-3g
      - sls: bitcurator.packages.python3-tsk
      - sls: bitcurator.packages.qemu-utils
      - sls: bitcurator.packages.sleuthkit
      - sls: bitcurator.packages.testdisk
      - sls: bitcurator.packages.vmfs-tools
      - sls: bitcurator.packages.xfsprogs
      - sls: bitcurator.packages.xmount
      - sls: bitcurator.packages.libguestfs-tools
      - sls: bitcurator.packages.mtd-utils
      - sls: bitcurator.packages.squashfs-tools
      - sls: bitcurator.packages.git
      - sls: bitcurator.packages.build-essential
      - sls: bitcurator.packages.python3-dev

imagemounter:
  pip.installed:
    - bin_env: /opt/imagemounter/bin/python3
    - upgrade: True
    - require:
      - virtualenv: imagemounter-venv

imagemounter-symlink:
  file.symlink:
    - name: /usr/local/bin/imount
    - target: /opt/imagemounter/bin/imount
    - force: True
    - makedirs: False
    - require:
      - pip: imagemounter

