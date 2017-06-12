#!/bin/bash

mount -a


#This has to be the last command!
/usr/bin/supervisord -n
