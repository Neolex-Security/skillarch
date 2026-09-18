#!/usr/bin/env bash
if [ -f /usr/bin/waypaper ]; then
    waypaper $1 &
elif [ -f $HOME/.local/bin/waypaper ]; then
    $HOME/.local/bin/waypaper $1 &
else
    echo ":: waypaper not found"
fi
