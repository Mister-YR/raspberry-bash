# Hello, this bash script shutdown machine when you reach limit {some value}tb of traffic!
######################################################################

#!/bin/bash
# updated script version from 11.1.2023
threshold_tb=19
threshold_check=$(vnstat -i eth0 -m | grep "GiB" | awk '{ print $8}' | awk 'NR==3')
# check if vn stat installed
./vnstat_check.sh
# add script to cron
./cron_add.sh
# main script body
while true; do
    # Check if threshold_check is greater than threshold_tb
    if (( $(echo "$threshold_check > $threshold_tb" | bc -l) )); then
    echo "threshold_tb is greater than threshold_check. Shutting down... %0A traffic statistics reset.."
    # send notification to telegram bot
        sleep 20
        # notify via tlegram
        ./notification.sh
        sleep 10
        # reset traffic stat
        ./vnstat_reset.sh
        sleep 120
        # shutdown machine
        sudo shutdown -h now
        exit 0
    else
        echo "threshold_tb is not greater than threshold_check. No action taken."
    fi
    # check every 2 minutes
    sleep 120
done