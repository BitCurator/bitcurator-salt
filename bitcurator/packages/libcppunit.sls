{% if grains['oscodename'] == "bionic" %}

libcppunit-1.14-0:
  pkg.installed

{% elif grains['oscodename'] == "focal" %}

libcppunit-1.15-0:
  pkg.installed

{% endif %}
