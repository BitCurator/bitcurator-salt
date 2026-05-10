{% set codename = grains['oscodename'] %}

{% set audio_convert_pkgs = {
     'jammy':    ['nautilus-script-audio-convert'],
     'noble':    [],
     'resolute': [],
   }.get(codename, []) %}

{% if audio_convert_pkgs %}
nautilus-script-audio-convert:
  pkg.installed:
    - pkgs: {{ audio_convert_pkgs }}
{% endif %}
