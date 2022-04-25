{% if grains['oscodename'] == "focal" %}

include:
  - bitcurator.repos.gift

bulk-extractor:
  pkg.installed:
    - version: latest
    - upgrade: True
    - require:
      - pkgrepo: bitcurator-gift-repo

{% elif grains['oscodename'] == "bionic" %}

bulk-extractor:
  pkg.installed

{% endif %}
