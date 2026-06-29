hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("__GL_MaxFramesAllowed", "1")
hl.env("XWAYLAND_NO_GLAMOR", "1")
hl.env("NVD_BACKEND", "direct")
-- hl.env("__EGL_VENDOR_LIBRARY_DIRS", "/usr/share/glvnd/egl_vendor.d")
hl.env("qsScripts", os.getenv("HOME") .. "/.config/quickshell/ii/scripts")

-- Quickshell / Qt6 Wayland on NVIDIA 595
-- Silences the harmless "decorations EGLContext" warning (layer-shell needs no CSD)
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- NVIDIA 555+ explicit sync regression workaround (fixes random Qt6 EGL segfaults)
hl.env("__NV_DISABLE_EXPLICIT_SYNC", "1")
-- OpenGL avoids Intel Y_TILED_CCS DMA-BUF import failure when NVIDIA Vulkan
-- tries to import screencopy buffers allocated on the Intel GBM device.
hl.env("QSG_RHI_BACKEND", "opengl")
