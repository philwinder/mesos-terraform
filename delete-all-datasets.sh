#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	echo "Not yet implemented. See OSX implementation."
elif [[ "$OSTYPE" == "darwin"* ]]; then
	curl -XGET -k --cert user.p12:password https://$MASTER:4523/v1/configuration/datasets 2>/dev/null | grep -Eo '"dataset_id": ".*?[^\\]",' | awk -F: '{print $2}' | tr -d '\", ' | xargs -I % sh -c 'curl -XDELETE -k --cert user.p12:password https://$MASTER:4523/v1/configuration/datasets/%'
fi
