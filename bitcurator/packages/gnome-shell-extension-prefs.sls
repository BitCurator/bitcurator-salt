{% if grains['oscodename'] == "bionic" %}
no-gnome-shell-extension-prefs:
  test.nop
{% elif grains['oscodename'] == "focal" %}
gnome-shell-extension-prefs:
  pkg.installed
{% endif %}
