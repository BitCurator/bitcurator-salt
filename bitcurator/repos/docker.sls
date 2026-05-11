{% set codename = grains['oscodename'] %}

{% set docker_codename = {
     'jammy':    'jammy',
     'noble':    'noble',
     'resolute': 'resolute',
   }.get(codename, 'noble') %}

docker-repo-key:
  file.managed:
    - name: /usr/share/keyrings/docker.pgp
    - source: https://download.docker.com/linux/ubuntu/gpg
    - skip_verify: True
    - makedirs: True

docker:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb [arch=amd64 signed-by=/usr/share/keyrings/docker.pgp] https://download.docker.com/linux/ubuntu {{ docker_codename }} stable
    - file: /etc/apt/sources.list.d/docker.sources
    - refresh: True
    - aptkey: False
    - clean_file: True
    - require:
      - file: docker-repo-key
