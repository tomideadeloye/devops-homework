#!/usr/bin/env bash
set -ex
if [ "$DEPLOYMENT_GROUP_NAME" == "Portal" ]; then
  lsof -i -P -n | grep LISTEN | grep 5000
elif [ "$DEPLOYMENT_GROUP_NAME" == "Hardware" ]; then
  lsof -i -P -n | grep LISTEN | grep 5001
fi
