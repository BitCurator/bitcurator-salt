{% set codename = grains['oscodename'] %}

{% set vmfs_pkgs = {
     'jammy':    ['vmfs-tools'],
     'noble':    ['vmfs-tools'],
     'resolute': [],
   }.get(codename, []) %}

{% if vmfs_pkgs %}
vmfs-packages:
  pkg.installed:
    - pkgs: {{ vmfs_pkgs }}
{% endif %}
