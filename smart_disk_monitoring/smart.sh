#!/bin/bash
source secret.env
 # check if smartmontools installed
if ! command -v smartctl &> /dev/null; then
    echo "smartmontools is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install smartmontools
else
    echo "smartmontools is already installed."
fi
for device in /dev/sd*; do
  echo "=== SMART status for $device ==="
  sudo smartctl -l selftest "$device"
done
sleep 10
date=$(date "+%Y-%m-%d")
log_file=$(date '+%Y-%m-%d')_smart_log.txt
touch "$log_file"
echo '#######' "$date" '########' >> $log_file
for device in /dev/sd*; do
  echo "=== SMART status for $device ===" >> $log_file
  status=$(sudo smartctl -H "$device" | grep -E "SMART status for*|SMART overall-health *" )
  echo "$status" >> $log_file
done
# check errors in log.txt
if grep -q "FAILED" $log_file; then
 #!/bin/bash
        # get token & chat_id from secret.env
        #TOKEN=
        #CHAT_ID=
        file=$(date "+%Y-%m-%d")*.txt
        log_file=$(date '+%Y-%m-%d')_smart_log.txt
        smart=$(grep -B 1 'FAILED' $log_file )
        curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="❗💾❗🚨🚨🚨🚨🚨%0A Some disks has en ERRORS:%0A $smart%0A❗💾❗ 🆘 👀%0A  🍆🍆🍆🍆🍆🍆"> /dev/null

fi
