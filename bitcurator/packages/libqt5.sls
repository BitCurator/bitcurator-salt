{% set codename = grains['oscodename'] %}

{% set t64_pkgs = ['libqt5core5t64', 'libqt5dbus5t64', 'libqt5gui5t64', 'libqt5widgets5t64'] %}
{% set libqt5_pkgs = {
     'jammy':    ['libqt5core5a', 'libqt5dbus5', 'libqt5gui5', 'libqt5widgets5'],
     'noble':    t64_pkgs,
     'resolute': t64_pkgs,
   }.get(codename, t64_pkgs) %}

libqt5-packages:
  pkg.installed:
    - pkgs: {{ libqt5_pkgs }}
