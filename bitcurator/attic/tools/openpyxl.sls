openpyxl:
  cmd.run:
    - name: |
        cd /tmp
        hg clone https://bitbucket.org/openpyxl/openpyxl
        cd openpyxl
        python3 setup.py build
        python3 setup.py install
        ldconfig
        cd /tmp
        rm -rf openpyxl
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 12000
