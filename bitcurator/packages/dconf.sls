{%- if grains['oscodename'] == "bionic" %}

dconf-tools:
  pkg.installed

{%- elif grains['oscodename'] == "focal" %}

dconf-cli:
  pkg.installed

dconf-editor:
  pkg.installed

{% endif %}
