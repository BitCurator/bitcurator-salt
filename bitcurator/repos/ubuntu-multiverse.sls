bitcurator-multiverse-repo:
  pkgrepo.managed:
    - name: deb http://archive.ubuntu.com/ubuntu/ {{ grains['lsb_distrib_codename'] }} multiverse
    - refresh_db: true

bitcurator-multiverse-repo-security:
  pkgrepo.managed:
    - name: deb http://archive.ubuntu.com/ubuntu/ {{ grains['lsb_distrib_codename'] }}-security multiverse
    - refresh_db: true