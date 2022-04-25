include:
  - bitcurator.repos.sift

liblightgrep:
  pkg.installed:
    - require:
      - sls: bitcurator.repos.sift
