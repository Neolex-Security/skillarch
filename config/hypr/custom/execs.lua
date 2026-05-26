-- execs.lua
hl.on("hyprland.start", function()
	local apps = {
		"thunderbird",
		"flamshot",
		os.getenv("HOME") .. "/.config/kanata/layer-listener.sh",
		"webcord",
		"google-chrome-stable",
	}

	for _, app in ipairs(apps) do
		hl.exec_cmd(app)
	end
end)
