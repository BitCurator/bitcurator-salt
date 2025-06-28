{% if grains['oscodename'] == 'jammy' %}

libcrypto++8:
  pkg.installed

{% elif grains['oscodename'] == 'noble' %}

libcrypto++8t64:
  pkg.installed

{% else %}

libcrypto++8t64:
  pkg.installed

{% endif %}
