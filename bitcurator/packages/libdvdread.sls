{% if grains['oscodename'] == 'focal' %}

libdvdread7:
  pkg.installed

{% elif grains['oscodename'] == 'jammy' %}

libdvdread8:
  pkg.installed

{% else %}

libdvdread8t64:
  pkg.installed

{% endif %}
