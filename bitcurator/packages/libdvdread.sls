{% if grains['oscodename'] == "bionic" %}

libdvdread4:
  pkg.installed

{% elif grains['oscodename'] == "focal" %}

libdvdread7:
  pkg.installed

{% endif %}
