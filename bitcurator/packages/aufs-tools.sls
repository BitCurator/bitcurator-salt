{% if grains['oscodename'] == 'focal' %}

aufs-tools:
  pkg.installed

{% else %}

aufs-tools-not-on-jammy-and-noble:
  test.nop

{% endif %}
