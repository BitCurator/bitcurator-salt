# Use of sources requires that the 'source:' field be the Package value from:
# dpkg -I <deb_file>
# Anything else will not be accepted and state will fail.

include:
  - bitcurator.packages.libqt5
  - bitcurator.packages.hdparm
  - bitcurator.packages.smartmontools

{% if grains['oscodename'] != 'jammy' %}

guymager-deb:
  pkg.installed:
    - sources:
      - guymager-beta: salt://bitcurator/files/guymager-beta_0.8.12-1_amd64.deb
    - require:
      - sls: bitcurator.packages.libqt5
      - sls: bitcurator.packages.hdparm
      - sls: bitcurator.packages.smartmontools

{% else %}

guymager:
  pkg.installed:
    - require:
      - sls: bitcurator.packages.libqt5
      - sls: bitcurator.packages.hdparm
      - sls: bitcurator.packages.smartmontools

{% endif %}
