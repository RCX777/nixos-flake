#!/bin/sh

nmcli -t -f name,device connection show --active | grep wlo1 | cut -d\: -f1
