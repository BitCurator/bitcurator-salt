#!/bin/bash

docker run -it --rm --name="bitcurator-test-all" -v `pwd`/bitcurator:/srv/salt/bitcurator --cap-add SYS_ADMIN digitalsleuth/mat-salt-tester:bionic:focal \
  salt-call -l info --local --retcode-passthrough --state-output=mixed state.sls bitcurator pillar='{"bitcurator_user": "bcadmin"}'
