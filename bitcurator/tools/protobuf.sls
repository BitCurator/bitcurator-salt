include:
  - bitcurator.packages.build-essential

protobuf-source:
  file.managed:
    - name: /tmp/protobuf-cpp-3.19.4.tar.gz
    - source: https://github.com/protocolbuffers/protobuf/releases/download/v3.19.4/protobuf-cpp-3.19.4.tar.gz
    - source_hash: sha256=89ac31a93832e204db6d73b1e80f39f142d5747b290f17340adce5be5b122f94

protobuf-extract:
  archive.extracted:
    - name: /tmp/
    - source: /tmp/protobuf-cpp-3.19.4.tar.gz
    - enforce_toplevel: False
    - require:
      - file: protobuf-source

protobuf-build:
  cmd.run:
    - names:
      - ./configure
      - make
      - make install
      - ldconfig
    - cwd: /tmp/protobuf-3.19.4/
    - shell: /bin/bash
    - require:
      - archive: protobuf-extract

protobuf-cleanup:
  file.absent:
    - names:
      - /tmp/protobuf-3.19.4/
      - /tmp/protobuf-cpp-3.19.4.tar.gz
    - require:
      - cmd: protobuf-build
