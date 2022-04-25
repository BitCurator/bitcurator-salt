include:
  - bitcurator.env.dot-local
  - bitcurator.env.etc
  - bitcurator.env.guymager-config 
  - bitcurator.env.lib
  - bitcurator.env.mountwinalias
  - bitcurator.env.sudoers
  - bitcurator.env.floppyconfig
  - bitcurator.env.ficlam
  - bitcurator.env.usr
  - bitcurator.env.vimrc
  - bitcurator.env.vim-support

bitcurator-env:
  test.nop:
    - name: bitcurator-env
    - require:
      - sls: bitcurator.env.dot-local
      - sls: bitcurator.env.etc
      - sls: bitcurator.env.guymager-config
      - sls: bitcurator.env.lib
      - sls: bitcurator.env.mountwinalias
      - sls: bitcurator.env.sudoers
      - sls: bitcurator.env.floppyconfig
      - sls: bitcurator.env.ficlam
      - sls: bitcurator.env.usr
      - sls: bitcurator.env.vimrc
      - sls: bitcurator.env.vim-support
