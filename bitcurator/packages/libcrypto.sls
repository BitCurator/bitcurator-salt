{% set codename = grains['oscodename'] %}

{% set libcrypto_pkgs = {
     'jammy':    ['libcrypto++8'],
     'noble':    ['libcrypto++8t64'],
     'resolute': ['libcrypto++8t64'],
   }.get(codename, ['libcrypto++8t64']) %}

libcrypto-packages:
  pkg.installed:
    - pkgs: {{ libcrypto_pkgs }}
