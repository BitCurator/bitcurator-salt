{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

include:
  - bitcurator.config.user

sudoers:
  file.append:
    - name: /etc/sudoers.d/bitcurator
    - text:
      - "{{ user }} ALL=NOPASSWD: ALL\nDefaults env_keep += \"ftp_proxy http_proxy https_proxy no_proxy\""
    - makedirs: True
    - require:
      - user: bitcurator-user-{{ user }}
