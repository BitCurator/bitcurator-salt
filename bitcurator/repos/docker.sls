{% set codename = grains['oscodename'] %}

{% set docker_codename = {
     'jammy':    'jammy',
     'noble':    'noble',
     'resolute': 'resolute',
   }.get(codename, 'noble') %}

# Cleanup: remove the legacy docker/stable PPA if it was configured by
# an earlier BitCurator release. Harmless on fresh installs.
remove-docker-ppa:
  pkgrepo.absent:
    - ppa: docker/stable

# Clean up the legacy .list-extension sources file from earlier
# iterations of this branch.
remove-docker-list:
  file.absent:
    - name: /etc/apt/sources.list.d/docker.list
    - require:
      - pkgrepo: remove-docker-ppa

# Docker signing key. Fetched from Docker's published URL at install
# time. The .asc extension matches Docker's official install docs.
docker-repo-key:
  file.managed:
    - name: /etc/apt/keyrings/docker.asc
    - source: https://download.docker.com/linux/ubuntu/gpg
    - skip_verify: True
    - makedirs: True
    - mode: 644

docker:
  file.managed:
    - name: /etc/apt/sources.list.d/docker.sources
    - mode: 644
    - contents: |
        Types: deb
        Architectures: amd64
        URIs: https://download.docker.com/linux/ubuntu
        Suites: {{ docker_codename }}
        Components: stable
        Signed-By: /etc/apt/keyrings/docker.asc
    - require:
      - file: docker-repo-key
      - pkgrepo: remove-docker-ppa
      - file: remove-docker-list

docker-repo-refresh:
  cmd.run:
    - name: apt-get update
    - onchanges:
      - file: docker
