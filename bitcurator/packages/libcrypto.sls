{% if grains['oscodename'] == 'focal' %}

libcrypto++6:
  pkg.installed

{% elif grains['oscodename'] == 'jammy' %}

libcrypto++8:
  pkg.installed

{% else %}

libcrypto++8t64:
  pkg.installed

{% endif %}
