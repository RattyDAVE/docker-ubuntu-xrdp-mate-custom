#!/bin/bash
if [ $UID -eq 0 ]; then
user=$1vcpb
exec su "$user" "$0" -- "$@"
fi
echo "This will be run from user $UID"
cd /home/vcbot
python3 bot.py
