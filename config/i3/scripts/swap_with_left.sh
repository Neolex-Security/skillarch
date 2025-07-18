#!/bin/bash
i3-msg "mark swap_with_left"
i3-msg "focus left"
i3-msg "swap container with mark swap_with_left"
i3-msg "unmark swap_with_left"
i3-msg "focus left"
