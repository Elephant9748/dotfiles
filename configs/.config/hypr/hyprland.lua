-- hl.monitor({
--     mode = "preferred",
--     position = "auto",
--     scale = "auto",
-- })

hl.monitor({
    output = "eDP-1",
    disabled = true,
})

-- hl.monitor({
--     output = "eDP-1",
--     mode = "preferred",
--     position = "auto",
--     scale = "auto",
-- })
-- hl.monitor({
--     output = "eDP-1",
--     mode = "1920x0",
--     position = "auto",
--     scale = "1",
-- })
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = "1",
})

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/autostart.sh")
end)

-- monitor=HDMI-A-1,1920x1080@74.97,0x0,1

-- See https://wiki.hyprland.org/Configuring/Keywords/ for more

-- Execute your favorite apps at launch

-- Source a file (multi-file configs)
-- source = ~/.config/hypr/myColors.conf

-- Some default env vars.
--env = GTK_THEME, Adwaita:dark
-- TODO: manual review — malformed env on line 21: GDK_BACKEND, wayland,x11
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct:qt6ct")
--env = GBM_BACKEND, nvidia-drm
--env = __GLX_VENDOR_LIBRARY_NAME, nvidia

-- cursor
--env = HYPRCURSOR_THEME,phinger-cursors-dark
hl.env("HYPRCURSOR_THEME", "breeze_cursors")
hl.env("HYPRCURSOR_SIZE", "16")
-- env = HYPRCURSOR_THEME,Pop
-- env = HYPRCURSOR_SIZE,14

--Window-Rules

-- Inline
hl.window_rule({
    match = {
        class = "Alacritty",
    },
    workspace = "2",
})

hl.window_rule({
    match = {
        class = "firefox-developer-edition",
    },
    workspace = "1",
})

hl.window_rule({
    match = {
        class = "Mullvad Browser Alpha",
    },
    workspace = "3",
})

hl.window_rule({
    match = {
        class = "chromium",
    },
    workspace = "3",
})

hl.window_rule({
    match = {
        class = "jetbrains-studio",
    },
    workspace = "3",
})

hl.window_rule({
    match = {
        class = "virt-manager",
    },
    workspace = "4",
})

hl.window_rule({
    match = {
        class = "org.gnome.Nautilus",
    },
    workspace = "4",
})

hl.window_rule({
    match = {
        class = "thunar",
    },
    workspace = "4",
})

hl.window_rule({
    match = {
        class = "Tor Browser Alpha",
    },
    workspace = "4",
})

-- rpi-imager
hl.window_rule({
    match = {
        class = "com.raspberrypi.rpi-imager",
    },
    move = "1233 403",
    size = "680 651",
    float = true,
    pin = true,
})

-- localsend rules
hl.window_rule({
    match = {
        class = "localsend",
    },
    size = "400 731",
    move = "1487 320",
    float = true,
    pin = true,
})

-- nextcloud rules
hl.window_rule({
    match = {
        title = "Nextcloud",
    },
    float = true,
    move = "1532 4",
    size = "389 1054",
    workspace = "6",
})

hl.window_rule({
    match = {
        title = "Nextcloud Settings",
    },
    float = true,
    workspace = "6",
    move = "1382 7",
    size = "537 1050",
})

-- cryptomator rules
hl.window_rule({
    match = {
        title = "Cryptomator",
    },
    float = true,
    move = "1266 519",
    size = "650 537",
})

-- qemu rule
hl.window_rule({
    match = {
        class = "qemu-system-x86_64",
    },
    workspace = "4",
    float = false,
})

-- signal windowrules
hl.window_rule({
    match = {
        title = "Signal",
    },
    float = true,
    move = "1230 228",
    size = "684 830",
})

-- steam windowrules
hl.window_rule({
    match = {
        class = "steam",
    },
    float = true,
    move = "427 211",
    size = "1024 660",
})

-- scrcpy
hl.window_rule({
    match = {
        class = "scrcpy",
    },
    pin = true,
    float = true,
    move = "1459 71",
    size = "454 984",
})

-- Picture-in-Picture Firefox
hl.window_rule({
    match = {
        title = "Picture-in-Picture",
    },
    float = true,
    move = "1204 13",
    size = "702 398",
    pin = true,
})

-- Gnome calculator
hl.window_rule({
    match = {
        class = "org.gnome.Calculator",
    },
    float = true,
    move = "1554 40",
    size = "360 616",
    pin = true,
})

-- Veracrypt
hl.window_rule({
    match = {
        class = "veracrypt",
    },
    float = true,
    move = "1327 503",
    size = "584 553",
})

-- disks
hl.window_rule({
    match = {
        class = "org.gnome.DiskUtility",
    },
    size = "592 598",
    move = "1323 459",
    float = true,
    pin = true,
})

-- rpi imager
hl.window_rule({
    match = {
        class = "Raspberry Pi Imager",
    },
    size = "585 520",
    move = "734 460",
    float = true,
    pin = true,
})
-- moonlight
hl.window_rule({
    match = {
        class = "com.moonlight_stream.Moonlight",
    },
    tile = true,
    workspace = "5"
})
hl.window_rule({
    match = {
        class = "Moonlight",
    },
    tile = true,
    workspace = "5"
})

-- workspace 6 rules
hl.workspace_rule({
    workspace = "6",
    -- gaps_out = "50 394 50 50",
    gaps_out = {
            top = 50,
            right = 394,
            bottom = 50,
            left = 50,
    },
    gaps_in = 5,
})

--disable pop update changelog
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 7,
    bezier = "myBezier",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "default",
    style = "popin 80%",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "default",
})
hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 8,
    bezier = "default",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 7,
    bezier = "default",
})
-- hl.animation({
--     leaf = "workspaces",
--     enabled = true,
--     speed = 6,
--     bezier = "default",
-- })
-- hl.animation({
--     leaf = "workspaces",
--     enabled = false,
--     speed = 3,
--     bezier = "default",
-- })
-- hl.animation({
--     leaf = "workspaces",
--     enabled = true,
--     speed = 6,
--     bezier = "default",
--     style = "slidefadevert -5%",
-- })
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "default",
    style = "slidefadevert 5%",
})
-- hl.animation({
--     leaf = "workspaces",
--     enabled = true,
--     speed = 6,
--     bezier = "default",
--     style = "slidefade -20%",
-- })
-- hl.animation({
--     leaf = "workspaces",
--     enabled = true,
--     speed = 6,
--     bezier = "default",
--     style = "slidefadevert",
-- })

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())

hl.bind(mainMod .. " + mouse:274", hl.dsp.window.close())

-- from doc
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("rofi -opacity 80 -show drun"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("rofi -show calc -modi calc -no-show-match -no-sort -no-history -calc-command \"echo '{result}' | wl-copy\""))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("rofi -show power-menu -modi \"power-menu:rofi-power-menu --choices=shutdown/lockscreen/logout/reboot\""))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("hyprpicker -a --format=hex"))

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("nm-applet"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("/usr/bin/kill nm-applet"))

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("waybar &"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("/usr/bin/kill waybar"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("wl-copy -c"))

hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | swappy -f -"))

hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("hyprctl dismissnotify"))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + SHIFT + ALT + h", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + l", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

local w1 = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/i.png\""
local w2 = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/ii.png\""
local w3 = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/iii.png\""
local w4 = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/iv.png\""
local w5 = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/v.png\""
local w6 = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/vi.png\""
local w7 = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/vii.png\""

hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 2", hl.dsp.exec_cmd(w2))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 3", hl.dsp.exec_cmd(w3))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 4", hl.dsp.exec_cmd(w4))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 5", hl.dsp.exec_cmd(w5))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 6", hl.dsp.exec_cmd(w6))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 7", hl.dsp.exec_cmd(w7))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.exec_cmd(w2))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.exec_cmd(w3))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.exec_cmd(w4))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.exec_cmd(w5))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.exec_cmd(w6))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.exec_cmd(w7))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())
hl.config({
    ecosystem = {
        no_update_news = true,
    },
    -- xwayland {
    --         create_abstract_socket = true
    --         force_zero_scaling = true
    -- }
    -- For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = false,
        },
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    },
    general = {
        gaps_in = 1,
        gaps_out = 3,
        border_size = 1,
        col = {
            -- active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            -- active_border = { colors = { "rgba(356F89ee)", "rgba(519C62ee)" }, angle = 45 },

            -- default
            -- active_border = { colors = { "rgba(427B58ee)", "rgba(076678ee)" }, angle = 45 },

            active_border = { colors = { "rgba(4c4c4cee)", "rgba(302c29ee)" }, angle = 45 },
            -- active_border = { colors = { "rgba(E0431Aee)", "rgba(304F47ee)" }, angle = 45 },
            -- active_border = { colors = { "rgba(40281Bee)", "rgba(3C3836ee)" }, angle = 45 },
            -- active_border = { colors = { "rgba(7C6F64ee)", "rgba(3C3836ee)" }, angle = 45 },

            -- default
            -- inactive_border = "rgba(595959aa)",

            -- inactive_border = "rgba(060606aa)",
            inactive_border = "rgba(0f0f0faa)",
        },
        layout = "dwindle",
    },
    decoration = {
        -- See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 1,
        blur = {
            enabled = false,
            size = 3,
            passes = 1,
        },
        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        vrr = 1,
    },
    animations = {
        enabled = true, 
    },
    dwindle = {
        preserve_split = true, 
        smart_resizing = true,
    },
    master = {
        -- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        -- new_is_master = false
        new_status = "slave",
    },
})


