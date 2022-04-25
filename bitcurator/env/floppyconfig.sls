include:
  - bitcurator.env.lib

floppyconfig-rules-1:
  file.replace:
    - name: /lib/udev/rules.d/80-udisks2.rules
    - pattern: '{ID_DRIVE_FLOPPY}="1"'
    - repl: '{ID_DRIVE_FLOPPY}="0"'
    - require:
      - sls: bitcurator.env.lib

floppyconfig-rules-2:
  file.replace:
    - name: /lib/udev/rules.d/80-udisks2.rules
    - pattern: '{ID_DRIVE_FLOPPY_ZIP}="1"'
    - repl: '{ID_DRIVE_FLOPPY_ZIP}="0"'
    - require:
      - sls: bitcurator.env.lib
