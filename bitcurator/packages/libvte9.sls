{% if grains['oscodename'] == 'jammy' %}

libvte9:
  pkg.installed

{% else %}

libvte9t64:
  pkg.installed

{% endif %}
