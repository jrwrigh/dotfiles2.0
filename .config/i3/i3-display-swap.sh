#!/usr/bin/env bash
# requires jq
# Taken from comments in gist: https://gist.github.com/fbrinker/df9cfbc84511d807f45041737ff3ea02

[ -x $(command -v jq) ] || i3-nagbar -m 'jq required for display swap, but not found'

INITIAL_WORKSPACE=$(i3-msg -t get_workspaces \
  | jq '.[] | select(.focused==true).name' \
  | cut -d"\"" -f2)

DISPLAY_CONFIG=($(i3-msg -t get_outputs | jq -r '.[]|"\(.name):\(.current_workspace)"'))

echo 'INITIAL_WORKSPACE: ' $INITIAL_WORKSPACE
echo 'DISPLAY_CONFIG: ' $DISPLAY_CONFIG

for ROW in "${DISPLAY_CONFIG[@]}"
do
	IFS=':'
	read -ra CONFIG <<< "${ROW}"
	if [ "${CONFIG[0]}" != "null" ] && [ "${CONFIG[1]}" != "null" ]; then
		echo "moving ${CONFIG[1]} right..."
		i3-msg -- workspace --no-auto-back-and-forth "${CONFIG[1]}"
		i3-msg -- move workspace to output right
	fi
done

# Focus on original workspace
i3-msg -- workspace --no-auto-back-and-forth $INITIAL_WORKSPACE
