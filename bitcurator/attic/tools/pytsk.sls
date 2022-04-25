pytsk:
  cmd.run:
    - name: |
        cd /tmp
        wget -q https://github.com/py4n6/pytsk/releases/download/20160721/pytsk3-20160721.tar.gz
        echo "Got pytsk3 with wget" >> /var/log/bitcurator-install.log 2>&1
        tar -zxf pytsk3-20160721.tar.gz >> /var/log/bitcurator-install.log 2>&1
        cd pytsk3-20160721
        python3 setup.py build >> /var/log/bitcurator-install.log 2>&1
        python3 setup.py install >> /var/log/bitcurator-install.log 2>&1
        cd /tmp
        rm -rf pytsk3-20160721
        rm pytsk3-20160721.tar.gz
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 12000
