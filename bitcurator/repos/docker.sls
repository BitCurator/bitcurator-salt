{% set codename = grains['oscodename'] %}

{% set docker_codename = {
     'jammy':    'jammy',
     'noble':    'noble',
     'resolute': 'resolute',
   }.get(codename, 'noble') %}

docker-repo-key:
  file.managed:
    - name: /etc/apt/keyrings/docker.asc
    - source: https://download.docker.com/linux/ubuntu/gpg
    - skip_verify: True
    - makedirs: True
    - mode: 644

docker:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu {{ docker_codename }} stable
    - file: /etc/apt/sources.list.d/docker.sources
    - refresh: True
    - aptkey: False
    - clean_file: True
    - require:
      - file: docker-repo-key
