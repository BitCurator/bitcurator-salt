{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% set additional = ['antiword','bcreport','bless','clamtk','fido','fiwalk','ghex','gtkhash\:gtkhash','hardinfo','hashrat','hfs','identfile','nwipe','readpst','vlc'] %}
{% set forensic = ['BEViewer','bcdat','bcgui','bcmnt','brunnhilde','disktype','fiwalk','hashdb','md5deep','nsrllookup','photorec','regripper','sdhash','ssdeep','testdisk'] %}
{% set imaging = ['brasero','cdrdao','clonezilla','dcfldd','dd','ddrescue','dumpfloppy','ewfacquire','guymager'] %}
{% set packaging = ['bagit-python','grsync'] %}

{% for file in additional %}
/home/{{ user }}/Desktop/Additional Tools/{{ file }}.desktop:
  file.managed:
    - mode: 755
    - user: {{ user }}
    - group: {{ user }}
{% endfor %}

{% for file in forensic %}
/home/{{ user }}/Desktop/Forensics and Reporting/{{ file }}.desktop:
  file.managed:
    - mode: 755
    - user: {{ user }}
    - group: {{ user }}
{% endfor %}

{% for file in imaging %}
/home/{{ user }}/Desktop/Imaging and Recovery/{{ file }}.desktop:
  file.managed:
    - mode: 755
    - user: {{ user }}
    - group: {{ user }}
{% endfor %}

{% for file in packaging %}
/home/{{ user }}/Desktop/Packaging and Transfer/{{ file }}.desktop:
  file.managed:
    - mode: 755
    - user: {{ user }}
    - group: {{ user }}
{% endfor %}

/home/{{ user }}/.config/autostart/launcher-trust.desktop:
  file.managed:
    - source: salt://bitcurator/env/launcher-trust.desktop
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - require:
      - user: bitcurator-user-{{ user }}
