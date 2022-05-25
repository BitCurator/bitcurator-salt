#!/bin/bash

set -x

DISTRO=${DISTRO:="focal"}
STATE=$1

docker run -it --rm --name="bitcurator-state-${STATE}" -v `pwd`/bitcurator:/srv/salt/bitcurator --cap-add SYS_ADMIN digitalsleuth/mat-salt-tester:${DISTRO} \
  salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls ${STATE} pillar="{bitcurator_user: bcadmin}"
