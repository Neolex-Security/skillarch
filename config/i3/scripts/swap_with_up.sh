#!/bin/bash
i3-msg "mark swap_with_up"
i3-msg "focus up"
i3-msg "swap container with mark swap_with_up"
i3-msg "unmark swap_with_up"
i3-msg "focus up"
