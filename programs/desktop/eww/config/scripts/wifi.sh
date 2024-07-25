#!/bin/sh

nmcli m | while read -r line; do
  nmcli -t -f name,device c show --active | rg -F ":wlo1" -r ""\
  || echo ""
done
