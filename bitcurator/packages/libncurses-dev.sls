{% if grains['oscodename'] != 'noble' %}

libncurses5-dev:
  pkg.installed

libncursesw5-dev:
  pkg.installed

{% else %}

libncurses-dev:
  pkg.installed

{% endif %}
