	#!/bin/bash
    source secret.env
	TOKEN=
	CHAT_ID=
        traf_stat=$(vnstat -i eth0 -m | grep "GiB" | awk '{ print $8}' | awk 'NR==3')
        host=$(hostname)
	MESSAGE=$traf_stat
        MESSAGE1=$host
	curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="total:$MESSAGE TB server: $MESSAGE1 will be shutdown in 2 minutes" > /dev/null
