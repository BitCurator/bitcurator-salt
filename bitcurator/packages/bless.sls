{% if grains['oscodename'] != 'noble' %}

bless:
  pkg.installed

{% else %}
bless-not-available-in-noble:
  test.nop

{% endif %}
