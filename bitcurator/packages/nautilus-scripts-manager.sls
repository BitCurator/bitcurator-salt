# nautilus-scripts-manager was dropped from Ubuntu 26.04 (resolute).
# Scripts in ~/.local/share/nautilus/scripts/ still work without it;
# only the GUI manager is gone.
{% if grains['oscodename'] == 'resolute' %}
nautilus-scripts-manager:
  test.nop
{% else %}
nautilus-scripts-manager:
  pkg.installed
{% endif %}
