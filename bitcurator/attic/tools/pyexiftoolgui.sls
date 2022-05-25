{% set user = salt['pillar.get']('bitcurator_user') %}

pyexiftoolgui:
  cmd.run:
    - name: |
        cd /tmp
        wget -q https://github.com/hvdwolf/pyExifToolGUI/archive/0.5.tar.gz
        tar zxf 0.5.tar.gz
        cd pyExifToolGUI-0.5
        ./install_remove.py install
        if [ ! -d $HOME/.pyexiftoolgui ]; then
            mkdir -p $HOME/.pyexiftoolgui
        fi
        ldconfig
        cd /tmp
        rm -rf pyExifToolGUI-0.5
        rm 0.5.tar.gz
        chown {{ user }} /home/{{ user }}/.pyexiftoolgui
        chgrp {{ user }} /home/{{ user }}/.pyexiftoolgui
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 12000
    - unless: test -x /usr/bin/pyexiftoolgui
