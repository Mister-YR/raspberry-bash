#!/bin/bash

# Replace 'eth0' with the name of your network interface
interface="eth0"

# Stop vnstat service
sudo systemctl stop vnstat

# Remove or truncate the database file to reset statistics
db_file="/var/lib/vnstat/vnstat.db"
if [ -f "$db_file" ]; then
    sudo truncate -s 0 "$db_file"
    echo "Traffic statistics for $interface have been reset."
else
    echo "Database file not found for $interface. No action taken."
fi

# Start vnstat service
sudo systemctl start vnstat
sleep 60
sudo systemctl restart vnstat