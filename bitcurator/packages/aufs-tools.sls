{% if grains['oscodename'] != 'jammy' %}

aufs-tools:
  pkg.installed

{% else %}

aufs-tools-not-on-jammy:
  test.nop

{% endif %}
