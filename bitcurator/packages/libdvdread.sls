{% set codename = grains['oscodename'] %}

{% set libdvdread_pkgs = {
     'jammy':    ['libdvdread8'],
     'noble':    ['libdvdread8t64'],
     'resolute': ['libdvdread8t64'],
   }.get(codename, ['libdvdread8t64']) %}

libdvdread-packages:
  pkg.installed:
    - pkgs: {{ libdvdread_pkgs }}
