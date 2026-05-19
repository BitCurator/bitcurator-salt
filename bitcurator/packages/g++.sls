{% set codename = salt['grains.get']('oscodename') %}

g++:
  pkg.installed

{% if codename == 'resolute' %}
g++-13:
  pkg.installed
{% endif %}
