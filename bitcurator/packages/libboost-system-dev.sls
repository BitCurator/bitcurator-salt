{% set codename = grains['oscodename'] %}
{% set boost_system = {
    'jammy': 'libboost-system-dev',
    'noble': 'libboost-system-dev',
    'resolute': 'libboost-dev',
  }.get(codename, 'libboost-system-dev') %}

libboost-system-dev:
  pkg.installed:
    - name: {{ boost_system }}
