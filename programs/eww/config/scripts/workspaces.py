import subprocess
import io
import sys
import os
import json

current = int (subprocess.check_output(['xdotool', 'get_desktop']))
used    = subprocess.check_output(['wmctrl', '-l']).decode('UTF-8')

buttons = [
    "(button :onclick 'wmctrl -s 0 && python3 ./scripts/workspaces.py' :class '",
    "(button :onclick 'wmctrl -s 1 && python3 ./scripts/workspaces.py' :class '",
    "(button :onclick 'wmctrl -s 2 && python3 ./scripts/workspaces.py' :class '",
    "(button :onclick 'wmctrl -s 3 && python3 ./scripts/workspaces.py' :class '",
    "(button :onclick 'wmctrl -s 4 && python3 ./scripts/workspaces.py' :class '",
    "(button :onclick 'wmctrl -s 5 && python3 ./scripts/workspaces.py' :class '"]

workspaces = ["workspace_inactive","workspace_inactive","workspace_inactive","workspace_inactive","workspace_inactive","workspace_inactive"]

for line in used.splitlines():
    temp = int(line[12:][0])
    if temp > 6:
        break
    workspaces[temp] = "workspace_active"

workspaces[current] = "workspace_current"

for i in range(6):
    workspaces[i] = buttons[i] + workspaces[i] + "')"

print("(box :class 'workspace_container' :halign 'center' :orientation 'h' :spacing 10 " + workspaces[0] + workspaces[1] + workspaces[2] + workspaces[3] + workspaces[4] + workspaces[5] + ')')
