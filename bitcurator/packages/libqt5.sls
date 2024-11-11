{% if grains['oscodename'] != 'noble' %}

libqt5-packages-{{ grains['oscodename'] }}:
  pkg.installed:
    - names:
      - libqt5core5a
      - libqt5dbus5
      - libqt5gui5
      - libqt5widgets5

{% else %}

libqt5-packages-noble:
  pkg.installed:
    - names:
      - libqt5core5t64
      - libqt5dbus5t64
      - libqt5gui5t64
      - libqt5widgets5t64

{% endif %}
