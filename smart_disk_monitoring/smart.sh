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
date=$(date) 
echo '#######' "$date" '########' >> smart_log.txt
for device in /dev/sd*; do
  echo "=== SMART status for $device ===" >> smart_log.txt
  status=$(sudo smartctl -H "$device" | grep -E "SMART status for*|SMART overall-health *" )
  echo "$status" >> smart_log.txt
done
#cat smart_log.txt | grep  "SMART overall-health self-assessment test result: FAILED"
if grep -q "SMART overall-health self-assessment test result: FAILED" smart_log.txt; then
 #!/bin/bash
        TOKEN="TOKEN_FOR_TELEGRAM"
        CHAT_ID="TELEGRAM_CHAT_ID"
        smart=$(tail -n 7 smart_log.txt)
        # %0A print from new row
        curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="Some_disks_has_en_ERRORS: %0A $smart" > /dev/null
fi
