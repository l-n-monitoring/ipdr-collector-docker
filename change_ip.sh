#!/bin/bash

### RUN THIS BEFORE YOU RUN DOCKER COMPOSE!!!!

# Check if the user provided an input string
if [ -z "$1" ]; then
    echo "Usage: $0 <new_ip>"
    exit 1
fi

# Store the provided input in a variable
new_ip="$1"

# Use the find command to locate files and execute sed on each of them
find . -type f -exec sed -i "s/THIS_SERVER_IP/$new_ip/g" {} +