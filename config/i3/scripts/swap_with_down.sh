#!/bin/bash
i3-msg "mark swap_with_down"
i3-msg "focus down"
i3-msg "swap container with mark swap_with_down"
i3-msg "unmark swap_with_down"
i3-msg "focus down"

