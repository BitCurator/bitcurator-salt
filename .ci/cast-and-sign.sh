#!/bin/bash -x

set -x

if [ "x`which jq`" == "x" ]; then
  echo "jq is required to use this script"
  exit 10
fi

if [ $# -ne 1 ]; then
  echo "Usage: $0 TAG_NAME"
  exit 1
fi

if [ "x${GITHUB_ACCESS_TOKEN}" == "x" ]; then
  echo "GITHUB_ACCESS_TOKEN env var must be set for authentication"
  exit 5
fi

TAG_NAME=$1
PRERELEASE=false

`echo $TAG_NAME | grep -q "rc"`
if [ $? -eq 0 ]; then
  PRERELEASE="true"
fi

STASH_RESULTS=`git stash -u`

echo "==> Getting GitHub Release"
RELEASE_ID=`curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -q https://api.github.com/repos/bitcurator/bitcurator-salt/releases -d "{\"tag_name\": \"$TAG_NAME\", \"prerelease\": $PRERELEASE}" | jq .id`

echo "==> Generating tag ${TAG_NAME} and pushing"
git tag $TAG_NAME && git push origin --tags

echo "==> Sleeping, waiting for tar.gz file to be generated"
sleep 3

echo "==> Changing to main branch"
git checkout main

echo "==> Performing a git pull"
git pull

echo "==> Generating Cast release"
cast release -l debug --rm-dist

echo "==> Downloading tar.gz file for tag from GitHub"
curl -qL -o /tmp/bitcurator-salt-${TAG_NAME}.tar.gz https://github.com/bitcurator/bitcurator-salt/archive/$TAG_NAME.tar.gz

echo "==> Generating SHA256 of tar.gz"
shasum -a 256 /tmp/bitcurator-salt-$TAG_NAME.tar.gz > /tmp/bitcurator-salt-$TAG_NAME.tar.gz.sha256

echo "==> Generating GPG Signature of SHA256"
gpg --armor --clearsign --digest-algo SHA256 -u 1ACB8887 /tmp/bitcurator-salt-$TAG_NAME.tar.gz.sha256

echo "==> Generating GPG Signature of tar.gz file"
gpg --armor --detach-sign -u 1ACB8887 /tmp/bitcurator-salt-$TAG_NAME.tar.gz

echo "==> Uploading bitcurator-salt-$TAG_NAME.tar.gz.sha256"
curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Content-Type: text/plain" -q "https://uploads.github.com/repos/bitcurator/bitcurator-salt/releases/${RELEASE_ID}/assets?name=bitcurator-salt-${TAG_NAME}.tar.gz.sha256" --data-binary @/tmp/bitcurator-salt-$TAG_NAME.tar.gz.sha256

echo "==> Uploading bitcurator-salt-$TAG_NAME.tar.gz.sha256.asc"
curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Content-Type: text/plain" -q "https://uploads.github.com/repos/bitcurator/bitcurator-salt/releases/${RELEASE_ID}/assets?name=bitcurator-salt-${TAG_NAME}.tar.gz.sha256.asc" --data-binary @/tmp/bitcurator-salt-$TAG_NAME.tar.gz.sha256.asc

echo "==> Uploading bitcurator-salt-$TAG_NAME.tar.gz.asc"
curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Content-Type: text/plain" -q "https://uploads.github.com/repos/bitcurator/bitcurator-salt/releases/${RELEASE_ID}/assets?name=bitcurator-salt-${TAG_NAME}.tar.gz.asc" --data-binary @/tmp/bitcurator-salt-$TAG_NAME.tar.gz.asc

rm /tmp/bitcurator-salt-${TAG_NAME}.tar.gz
rm /tmp/bitcurator-salt-$TAG_NAME.tar.gz.sha256
rm /tmp/bitcurator-salt-$TAG_NAME.tar.gz.sha256.asc
rm /tmp/bitcurator-salt-$TAG_NAME.tar.gz.asc

if [ "${STASH_RESULTS}" != "No local changes to save" ]; then
  git stash pop
fi
