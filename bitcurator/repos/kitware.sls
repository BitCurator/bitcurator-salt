{% set codename = grains['oscodename'] %}

include:
  - bitcurator.packages.software-properties-common

bitcurator-kitware-key:
  file.managed:
    - name: /usr/share/keyrings/KITWARE-PGP-KEY.asc
    - source: https://apt.kitware.com/keys/kitware-archive-latest.asc
    - skip_verify: True
    - makedirs: True
    - mode: 644

bitcurator-kitware-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/kitware.sources
    - mode: 644
    - contents: |
        Types: deb
        Architectures: amd64
        URIs: https://apt.kitware.com/ubuntu/
        Suites: {{ codename }}
        Components: main
        Signed-By: /usr/share/keyrings/KITWARE-PGP-KEY.asc
    - require:
      - file: bitcurator-kitware-key

bitcurator-kitware-repo-refresh:
  cmd.run:
    - name: apt-get update
    - onchanges:
      - file: bitcurator-kitware-repo
