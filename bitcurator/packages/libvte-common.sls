{% set codename = grains['oscodename'] %}

{% set libvte_common_pkgs = {
     'jammy':    ['libvte-common'],
     'noble':    ['libvte-common'],
     'resolute': [],
   }.get(codename, []) %}

{% if libvte_common_pkgs %}
libvte-common-packages:
  pkg.installed:
    - pkgs: {{ libvte_common_pkgs }}
{% endif %}
