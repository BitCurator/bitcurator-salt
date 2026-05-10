{% set codename = grains['oscodename'] %}

{% set sip_pkgs = {
     'jammy':    ['python3-sip-dev'],
     'noble':    ['python3-sip-dev'],
     'resolute': ['python3-sipbuild', 'sip-tools'],
   }.get(codename, ['python3-sipbuild', 'sip-tools']) %}

python3-sip-dev:
  pkg.installed:
    - pkgs: {{ sip_pkgs }}
