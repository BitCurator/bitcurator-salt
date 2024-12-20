#!/bin/bash
echo "salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls bitcurator.  pillar='{\"bitcurator_user\": \"bcadmin\"}' --log-file=/saltstack.log --log-file-level=debug --out-file=/saltstack.log --out-file-append"
set -x

DISTRO=${DISTRO:="focal"}
SALT=${SALT:="3006"}
STATE=$1

docker run -it --rm --name="bitcurator-state-${DISTRO}" -v `pwd`/bitcurator:/srv/salt/bitcurator --cap-add SYS_ADMIN digitalsleuth/bitcurator-tester:${DISTRO}-${SALT} \
  /bin/bash
