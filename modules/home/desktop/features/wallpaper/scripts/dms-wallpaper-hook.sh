#!/bin/sh

sleep 3

primary="$(jq -r ".colors.dark.primary" dms-colors.json | cut -d "#" -f2-)"
asusctl aura static -c $primary
