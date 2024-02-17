#!/bin/bash
# achive envs:
source_folder="/path/to/log"
destination_folder="/path/to/achive_log"
archive_name="smart_log_$(date '+%Y%m%d').tar.gz"
# archive logs
sudo find "$source_folder" -name '*.txt' -mtime +360 -exec tar -czvf "$destination_folder/$archive_name" -C "$source_folder" {} +
# remove logs
sudo find "$source_folder" -name '*.txt' -mtime +360 -exec rm {} \;