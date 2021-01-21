#!/bin/bash
if [ $UID -eq 0 ]; then
user=$1vcpb #Make change here if you changed username
exec su "$user" "$0" -- "$@"
fi
echo "This will be run from user $UID"
cp -f /home/__init__.py /home/vcbot/config/__init__.py
mv /home/Telegram /home/vcpb/Telegram #Move Telegram to VCPB's Home (make changes according to username)
pactl load-module module-null-sink sink_name=MySink #loading MySink
echo "Pulseaudio MySink Loaded"
pactl set-default-sink MySink #setting Mysink as default Mic
echo "MySink Is Now Your Default Mic"
echo "Now Start xrdp and login and join a VoiceChat"
cd /home/vcbot 
python3 bot.py
