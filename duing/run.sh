#!/bin/bash
docker run -d --name duing \
           -p 3389:3389 \
           --shm-size 1g \
           -dit --restart unless-stopped \
           kairops/duing
