{%- if salt['file.file_exists']('/sbin/runlevel') %}

salt-minion:
  service.dead:
    - name: salt-minion
    - enable: False

{% endif %}

salt-minion-placeholder:
  test.nop
