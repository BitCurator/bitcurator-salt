# Use of sources requires that the 'source:' field be the Package value from:
# dpkg -I <deb_file>
# Anything else will not be accepted and state will fail.

guymager-deb:
  pkg.installed:
    - sources:
      - guymager-beta: salt://bitcurator/files/guymager-beta_0.8.12-1_amd64.deb
    - install_recommends: True
