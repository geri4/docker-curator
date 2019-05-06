#!/bin/bash

set -e

if [ -f "/etc/curator/config.yml" ]; then
  envsubst < /etc/curator/config.yml > /etc/curator/config.yml
fi
if [ -f "/etc/curator/actions.yml" ]; then
  envsubst < /etc/curator/actions.yml > /etc/curator/actions.yml
fi

exec "$@"
