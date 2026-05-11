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

adoptium-repo-key:
  file.managed:
    - name: /usr/share/keyrings/adoptium.pgp
    - source: https://packages.adoptium.net/artifactory/api/gpg/key/public
    - skip_verify: True
    - makedirs: True

# Adoptium does not yet publish a resolute repo; resolute uses the
# noble repo, which works since the deb packages are codename-agnostic.
# When Adoptium adds resolute support, change the resolute entry in
# the adoptium_codename map above.
adoptium-repo:
  pkgrepo.managed:
    - humanname: Adoptium
    - name: deb [arch=amd64 signed-by=/usr/share/keyrings/adoptium.pgp] https://packages.adoptium.net/artifactory/deb {{ adoptium_codename }} main
    - file: /etc/apt/sources.list.d/adoptium.list
    - refresh: True
    - aptkey: False
    - clean_file: True
    - require:
      - file: adoptium-repo-key
      - pkgrepo: openjdk-repo
      - file: openjdk-repo-file-delete
