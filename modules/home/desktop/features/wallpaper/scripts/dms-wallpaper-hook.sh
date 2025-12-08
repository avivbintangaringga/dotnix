#!/bin/sh

sleep 2

primary="$(jq -r ".colors.dark.primary" $HOME/.cache/DankMaterialShell/dms-colors.json | cut -d "#" -f2-)"
asusctl aura static -c $primary
