{% set codename = grains['oscodename'] %}

{% set pkg_map = {
     'jammy':    ['libncurses5-dev', 'libncursesw5-dev'],
     'noble':    ['libncurses-dev'],
     'resolute': ['libncurses-dev'],
   } %}

libncurses-dev-pkgs:
  pkg.installed:
    - pkgs: {{ pkg_map.get(codename, ['libncurses-dev']) }}
