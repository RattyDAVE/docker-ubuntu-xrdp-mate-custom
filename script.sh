#!/bin/bash

if [ $UID -eq 0 ]; then
user=$1vcpb
exec su "$user" "$0" -- "$@"
fi
cd /home/vcbot
python3 bot.py
