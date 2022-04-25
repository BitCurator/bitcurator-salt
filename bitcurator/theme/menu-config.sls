{%- set user = salt['pillar.get']('bitcurator_user', 'bcadmin') -%}

{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else %}
  {%- set home = "/home/" + user -%}
{%- endif -%}

include:
  - bitcurator.config.user
  - bitcurator.packages.gnome-sushi
  - bitcurator.packages.gnome-system-tools
  - bitcurator.packages.gnome-tweaks
  - bitcurator.packages.gnome-shell-extensions
  - bitcurator.packages.gnome-shell-extension-prefs

bitcurator-theme-applications-merged-dir:
  file.directory:
    - name: /etc/xdg/menus/applications-merged
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode
    - require:
      - sls: bitcurator.packages.gnome-sushi
      - sls: bitcurator.packages.gnome-system-tools
      - sls: bitcurator.packages.gnome-tweaks
      - sls: bitcurator.packages.gnome-shell-extensions
      - sls: bitcurator.packages.gnome-shell-extension-prefs

bitcurator-theme-menu-config-menus:
  file.recurse:
    - name: /etc/xdg/menus/applications-merged/
    - source: salt://bitcurator/theme/menu-config
    - include_pat: '*.menu'
    - user: root
    - group: root
    - file_mode: 644
    - require:
      - file: bitcurator-theme-applications-merged-dir

bitcurator-theme-menu-config-directories:
  file.recurse:
    - name: /usr/share/desktop-directories/
    - source: salt://bitcurator/theme/menu-config/
    - include_pat: '*.directory'
    - user: root
    - group: root
    - file_mode: 644
    - require:
      - file: bitcurator-theme-menu-config-menus

bitcurator-theme-applications-desktop-files:
  file.recurse:
    - name: /usr/share/applications/
    - source: salt://bitcurator/theme/menu-config/
    - include_path: '*.desktop'
    - user: root
    - group: root
    - file_mode: 644
    - require:
      - file: bitcurator-theme-menu-config-directories
