{% if grains['oscodename'] == "bionic" %}

python3-pyqt4:
  pkg.installed

{% elif grains['oscodename'] == "focal" %}

python3-pyqt5:
  pkg.installed

{% endif %}
