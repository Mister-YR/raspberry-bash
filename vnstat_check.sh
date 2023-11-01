#!/bin/bash

# Check the version of vnstat
vnstat_version=$(vnstat --version 2>&1)

# Check if the response is empty
if [ -z "$vnstat_version" ]; then
    # Install the latest version of vnstat
    sudo apt-get update
    sudo apt-get install vnstat
    sudo systemctl reload vnstat
else
    echo "vnstat version: $vnstat_version"
fi