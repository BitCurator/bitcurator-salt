{% if grains['oscodename'] == "focal" %}

libdvdread7:
  pkg.installed

{% elif grains['oscodename'] == "jammy" %}

libdvdread8:
  pkg.installed

{% endif %}
