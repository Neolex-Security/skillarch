-- Reads the ML4W-generated colors.conf at runtime so theme / wallpaper
-- recoloring keeps working even though the main config is now Lua.
-- Returns a table like { primary = "rgba(ffb59dff)", on_primary = "rgba(55200cff)", ... }

local M = {}

local home = os.getenv("HOME") or ""
local path = home .. "/.config/hypr/colors.conf"

local f = io.open(path, "r")
if f then
    for line in f:lines() do
        local k, v = line:match("^%s*%$([%w_]+)%s*=%s*(rgba%(%x+%))")
        if k and v then
            M[k] = v
        end
    end
    f:close()
end

-- Sensible fallbacks so borders are never nil if colors.conf is missing.
M.primary = M.primary or "rgba(ffb59dff)"
M.on_primary = M.on_primary or "rgba(55200cff)"

return M
