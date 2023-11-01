#!/bin/bash

# cron template
cron_job="@reboot /bin/bash /root/traffic_monitor_vnstat.sh > /dev/null 2>&1"

# Check if the cron job exist
if ! crontab -l | grep -Fq "$cron_job"; then
    # Add the cron job to the crontab
    (crontab -l; echo "$cron_job") | crontab -
    echo "Added the cron job to the crontab."
else
    echo "Cron job already exists."
fi