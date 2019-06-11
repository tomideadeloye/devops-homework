#!/usr/bin/env bash
set -ex
if [ "$DEPLOYMENT_GROUP_NAME" == "Portal" ]; then
	pushd /home/ubuntu/rescale
	  nohup python3 portal.py > /dev/null 2>&1 &
	popd
elif [ "$DEPLOYMENT_GROUP_NAME" == "Hardware" ]; then
	pushd /home/ubuntu/rescale
	  nohup python3 hardware.py > /dev/null 2>&1 &
	popd
fi