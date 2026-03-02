#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 100 \
        --delay 0.1 \
        --scroll-padding "  " \
        --match-command "`dirname $0`/tidal.sh status" \
        --match-text "playing" "--scroll 1" \
        --match-text "paused" "--scroll 0" \
        --update-check true "`dirname $0`/tidal.sh info" &

wait

