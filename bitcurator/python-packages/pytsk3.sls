{% set pytsk_files = ['fsstat','ffind','fls','icat','ifind','ils','istat','blkcat','blkls','blkstat','blkcalc','jcat','jls','mmls','mmstat','mmcat','img_stat','img_cat','disk_sreset','disk_stat','hfind','mactime','sorter','sigfind','tsk_comparedir','tsk_gettimes','tsk_loaddb','tsk_recover'] %}

include:
  - bitcurator.packages.python3-virtualenv

pytsk3-venv:
  virtualenv.managed:
    - name: /opt/pytsk3
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: bitcurator.packages.python3-virtualenv

pytsk3:
  pip.installed:
    - bin_env: /opt/pytsk3/bin/python3
    - upgrade: True
    - require:
      - virtualenv: pytsk3-venv

{% for file in pytsk_files %}
pytsk3-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/pytsk3/bin/{{ file }}
    - makedirs: False
    - require:
      - pip: pytsk3

{% endfor %}
