{% set codename = grains['oscodename'] %}

{% set libappindicator1_pkgs = {
     'jammy':    ['libappindicator1'],
     'noble':    [],
     'resolute': [],
   }.get(codename, []) %}

{% if libappindicator1_pkgs %}
libappindicator1:
  pkg.installed:
    - pkgs: {{ libappindicator1_pkgs }}
{% endif %}
