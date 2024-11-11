{% if grains['oscodename'] != 'noble' %}

nautilus-script-audio-convert:
  pkg.installed

{% else %}
nautilus-script-audio-convert-not-available-in-noble:
  test.nop

{% endif %}

