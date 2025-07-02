include:
  - bitcurator.repos.ubuntu-multiverse
  - bitcurator.repos.ubuntu-universe
  - bitcurator.repos.docker
#  - bitcurator.repos.siegfried

bitcurator-repos:
  test.nop:
    - name: bitcurator-repos
    - require:
      - sls: bitcurator.repos.ubuntu-multiverse
      - sls: bitcurator.repos.ubuntu-universe
      - sls: bitcurator.repos.docker
#      - sls: bitcurator.repos.siegfried
