
hl.config({
    input = {
        kb_layout = "fr",
     }
})
hl.monitor({
    output = "DP-1",
    mode = "5120x1440@240",
    position = "0x0",
    scale = "1.25"
})
hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto",
    scale = "1",
    mirror = "DP-1"
})

