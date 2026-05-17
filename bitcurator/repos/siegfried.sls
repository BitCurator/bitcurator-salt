bitcurator-siegfried-key:
  file.managed:
    - name: /usr/share/keyrings/SIEGFRIED-PGP-KEY.asc
    - source: http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x20F802FE798E6857
    - skip_verify: True
    - makedirs: True
    - mode: 644

# Siegfried publishes one codename-agnostic apt repo, keyed under
# the Debian "buster" codename for historical reasons. The same URL
# is used for all Debian/Ubuntu releases.
bitcurator-siegfried-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/siegfried.sources
    - mode: 644
    - contents: |
        Types: deb
        Architectures: amd64
        URIs: https://www.itforarchivists.com/
        Suites: buster
        Components: main
        Signed-By: /usr/share/keyrings/SIEGFRIED-PGP-KEY.asc
    - require:
      - file: bitcurator-siegfried-key

# Clean up the legacy .list-extension sources file from when this
# state used pkgrepo.managed.
bitcurator-siegfried-repo-cleanup:
  file.absent:
    - name: /etc/apt/sources.list.d/siegfried.list

bitcurator-siegfried-repo-refresh:
  cmd.run:
    - name: apt-get update
    - onchanges:
      - file: bitcurator-siegfried-repo
      - file: bitcurator-siegfried-repo-cleanup
