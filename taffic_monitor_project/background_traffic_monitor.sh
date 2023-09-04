# Hello, this bash script when you reach limit 19tb of traffic!
######################################################################
# install vnstat:
#sudo apt-get install vnstat
#sudo systemctl reload vnstat
#check vnstat result via command:
# vnstat --oneline | awk '{ print $11 }'
######################################################################
# crontab -e
# @reboot nohup ./background_traffic_monitor.sh > /dev/null 2>&1 &
######################################################################
# chmod +x background_traffic_monitor.sh
######################################################################
# .sh name background_traffic_monitor.sh
######################################################################

#!/bin/bash
# Define the two floating-point variables
threshold_tb=17.5
threshold_check=$(vnstat -i eth0 -m | grep "GiB" | awk '{ print $8}' | awk 'NR==3')

while true; do

    # Check if threshold_check is greater than threshold_tb
    if (( $(echo "$threshold_check > $threshold_tb" | bc -l) )); then
    echo "threshold_tb is greater than threshold_check. Shutting down..."
    # send notification to telegram bot
        ./notification.sh
        sudo shutdown -h now
        exit 0
    else
        echo "threshold_tb is not greater than threshold_check. No action taken."
    fi
    # check every 2 minutes
    sleep 120
done