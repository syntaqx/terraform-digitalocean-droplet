#!/usr/bin/env bash
set -eo pipefail
[[ $TRACE ]] && set -x

echo 'Waiting for cloud-init...'
sleep 5

# @TODO: Timeout after a few minutes instead of forever looping
until [ -f /var/lib/cloud/instance/boot-finished ]; do
  echo 'Still waiting for cloud-init...'
  sleep 3
done

echo 'Boot cloud-init complete'
