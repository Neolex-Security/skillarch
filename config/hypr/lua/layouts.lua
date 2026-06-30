-- Layouts + bind behavior  (was: conf/layouts/default.conf)
-- See https://wiki.hypr.land/Configuring/Layouts/

hl.config({
    dwindle = {
        preserve_split = true,
    },

    -- master = {
    --     new_status = "master", -- commented out due to compatibility reasons
    -- },

    binds = {
        workspace_back_and_forth = false,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
    },
})
