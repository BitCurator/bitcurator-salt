{% set codename = grains['oscodename'] %}

{% set libvte9_pkgs = {
     'jammy':    ['libvte9'],
     'noble':    ['libvte9t64'],
     'resolute': [],
   }.get(codename, []) %}

{% if libvte9_pkgs %}
libvte9-packages:
  pkg.installed:
    - pkgs: {{ libvte9_pkgs }}
{% else %}
libvte9-packages:
  test.nop: []
{% endif %}
