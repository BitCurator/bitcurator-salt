{% if grains['oscodename'] != 'noble' %}

libvte9:
  pkg.installed

{% else %}

libvte9t64:
  pkg.installed

{% endif %}
