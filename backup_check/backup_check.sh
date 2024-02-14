#!/bin/bash
# import secrets
source secret.env
# get hostname
host=$(hostname)
# set data path
file_path="/data-backup/duplicati"
# 3600 sec = 1 hour, or use another trashhold
threshold_seconds=3600

# backup variables:
# check file size in backup folder
backup_size=$(du -sh "$file_path" | cut -f1)
# get current time for diff
current_time=$(date +%s)
# time var for diff
last_modified_time=$(stat -c %Y "$file_path")
# var date for print
last_modified_date=$(date -d "@$last_modified_time" +%d-%m-%Y)
# diff variable
time_difference=$((current_time - last_modified_time))

if [ "$time_difference" -gt "$threshold_seconds" ]; then
    # if file diff older then  60 min = ERROR
    unsuccess="Backup File Not Modified, The file $file_path has not been modified recently. Last modified on: $last_modified_date"
    curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="❌_💀 $unsuccessfully 💀_❌ $host" > /dev/null

else
    # else file time creation less then 60 min  = SUCCESS
    sucess="The file $file_path backup successfully created $last_modified_date "
	curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="✅_👍 $sucess 👍_😄 $host $backup_size 🇺🇦" > /dev/null

fi