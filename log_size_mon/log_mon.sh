#!/bin/bash
# path to log file
file_path="/home/pi/smart_log.txt"

# Define the threshold file size ~ 200MB
threshold_size_mb=200

# Get the current size of the file via du
file_size=$(du -m "$file_path" | cut -f1)

# Compare the file size to the threshold size
if [ "$file_size" -gt "$threshold_size_mb" ]; then
    # Send a notification via Telegram
    TELEGRAM_BOT_TOKEN="TE:EGRAM_BOT_TOKEN"
    CHAT_ID="TELEGRAM_CHAT_ID"
    MESSAGE="####### %0A Warning: $file_path exceeds $threshold_size_mb MB. Check_file_on_PI %0A #######"

    curl -s "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MESSAGE"
fi