{% if grains['oscodename'] == 'focal' %}

gadmin-rsync:
  pkg.installed

{% else %}

gadmin-rsync-not-in-jammy-and-noble:
  test.nop

{% endif %}
