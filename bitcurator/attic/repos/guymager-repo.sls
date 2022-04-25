guymager-repo:
  cmd.run:
    - name: |
        wget -nH -rP /etc/apt/sources.list.d/ http://deb.pinguin.lu/pinguin.lu.list
        wget -q http://deb.pinguin.lu/debsign_public.key -O- | sudo apt-key add - 
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 12000
