{% if grains['oscodename'] == 'jammy' %}

libcrypto++8:
  pkg.installed

{% else %}

libcrypto++6:
  pkg.installed

{% endif %}
