{% if grains['oscodename'] == 'jammy' %}

libdvdread8:
  pkg.installed

{% elif grains['oscodename'] == 'noble' %}

libdvdread8t64:
  pkg.installed

{% else %}

libdvdread8t64:
  pkg.installed

{% endif %}
