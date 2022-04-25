{%- if salt['file.file_exists']('/sbin/runlevel') %}

Etc/UTC:
  timezone.system

{% endif %}

timezone-placeholder:
  test.nop
