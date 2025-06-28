#!/bin/bash
#set -x

DISTRO=${DISTRO:="jammy"}
SALT=${SALT:="3006"}
STATE=$1
echo "salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls bitcurator.${STATE}  pillar='{\"bitcurator_user\": \"bcadmin\"}' --log-file=/saltstack.log --log-file-level=debug --out-file=/saltstack.log --out-file-append"

docker run -it --rm --name="bitcurator-state-${DISTRO}" -v `pwd`/bitcurator:/srv/salt/bitcurator --cap-add SYS_ADMIN digitalsleuth/bitcurator-tester:${DISTRO}-${SALT} \
  /bin/bash
