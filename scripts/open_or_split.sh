#!/bin/bash
# From https://pastebin.com/XSuXNJZs by StingyKarmaWhore and u/yramagicman (upstream https://www.reddit.com/r/godot/comments/b7ad4u/open_terminalvim_from_godot/eqtavz1/)
# Modifed by haxpor: auto read from external changes, getting rid of line, and properly target an existing file on server
[ -n "$1" ] && server=$1
[ -n "$2" ] && file=$2

serverlist=`echo $(vim --serverlist)`
echo ${serverlist,,}
if [[ ${serverlist,,} == *"${server,,}"* ]]; then
    nvim +'set autoread|au CursorHold * checktime' --servername $server --remote-tab-silent $file
else
    nvim +'set autoread|au CursorHold * checktime' --servername $server $file
fi
