{% set codename = grains['oscodename'] %}

{% set adoptium_codename = {
     'jammy':    'jammy',
     'noble':    'noble',
     'resolute': 'noble',
   }.get(codename, 'noble') %}

# Cleanup: remove the legacy openjdk-r PPA if it was configured by an
# earlier BitCurator release. Harmless on fresh installs.
openjdk-repo:
  pkgrepo.absent:
    - ppa: openjdk-r/ppa
    - refresh: True

openjdk-repo-file-delete:
  file.absent:
    - name: /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-{{ codename }}.list
    - require:
      - pkgrepo: openjdk-repo

openjdk-repo-file-delete-sources:
  file.absent:
    - name: /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-{{ codename }}.sources
    - require:
      - pkgrepo: openjdk-repo

# Adoptium signing key. Fetched from Adoptium's published URL at
# install time; skip_verify: True is retained from the previous
# iteration.
adoptium-repo-key:
  file.managed:
    - name: /etc/apt/keyrings/adoptium.asc
    - source: https://packages.adoptium.net/artifactory/api/gpg/key/public
    - skip_verify: True
    - makedirs: True
    - mode: 644

# Adoptium does not yet publish a resolute repo; resolute uses the
# noble repo, which works since the deb packages are codename-agnostic.
# When Adoptium adds resolute support, change the resolute entry in
# the adoptium_codename map above.
adoptium-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/adoptium.sources
    - mode: 644
    - contents: |
        Types: deb
        Architectures: amd64
        URIs: https://packages.adoptium.net/artifactory/deb
        Suites: {{ adoptium_codename }}
        Components: main
        Signed-By: /etc/apt/keyrings/adoptium.asc
    - require:
      - file: adoptium-repo-key
      - pkgrepo: openjdk-repo
      - file: openjdk-repo-file-delete
      - file: openjdk-repo-file-delete-sources

adoptium-repo-refresh:
  cmd.run:
    - name: apt-get update
    - onchanges:
      - file: adoptium-repo
