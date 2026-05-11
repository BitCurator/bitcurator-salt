include:
  - bitcurator.repos.ubuntu-base
  - bitcurator.repos.docker
#  - bitcurator.repos.siegfried

bitcurator-repos:
  test.nop:
    - name: bitcurator-repos
    - require:
      - sls: bitcurator.repos.ubuntu-base
      - sls: bitcurator.repos.docker
#      - sls: bitcurator.repos.siegfried
