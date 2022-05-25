{%- set user = salt['pillar.get']('bitcurator_user', 'bcadmin') -%}

include:
  - bitcurator.packages.docker

bitcurator-theme-cleanup-extra-apps:
  pkg.removed:
    - pkgs:
      - aisleriot
      - avahi-daemon
      - transmission
      - caffeine
      - cheese
      - gnome-mahjongg
      - gnome-mines
      - rhythmbox
      - gnome-sudoku
      - unattended-upgrades
      - transmission-gtk
      - gnome-2048
      - yelp

bitcurator-theme-cleanup-disable-auto-upgrades:
  file.append:
    - name: /etc/apt/apt.conf.d/20auto-upgrades
    - text: "APT::Periodic::Update-Package-Lists \"0\";\nAPT::Periodic::Unattended-Upgrade \"0\";"
    - makedirs: True

{%- if salt['file.file_exists']('/sbin/runlevel') %}

bitcurator-theme-cleanup-service-bluetooth:
  service.dead:
    - name: bluetooth
    - enable: False

bitcurator-theme-cleanup-service-docker:
  service.dead:
    - name: docker
    - enable: False
    - require:
      - sls: bitcurator.packages.docker

bitcurator-theme-cleanup-docker-wrapper:
  file.managed:
    - replace: False
    - user: root
    - group: root
    - mode: 755
    - name: /usr/local/bin/docker
    - source: salt://bitcurator/theme/cleanup/docker-wrapper.sh
    - makedirs: True
    - require:
      - sls: bitcurator.packages.docker

{% endif %}

bitcurator-theme-cleanup-autoremove:
  cmd.run:
    - name: apt-get autoremove -y --purge
