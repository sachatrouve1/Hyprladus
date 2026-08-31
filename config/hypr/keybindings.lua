-- KEYBINDINGS

local scrPath = os.getenv("HOME") .. "/.local/share/bin"
local configPath = os.getenv("HOME") .. "/nixconfig"

local term = "foot"
local editor = "code"
local file = "nemo"
local browser = "librewolf"

-- Window / Session actions
hl.bind("SUPER + Q", hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh"), { repeating = true })

hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind("SUPER + ALT + Delete", hl.dsp.exit())
hl.bind("SUPER + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + G", hl.dsp.group.toggle())
hl.bind("SUPER + Delete", hl.dsp.exec_cmd("pidof hyprlock || hyprlock"))
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd(scrPath .. "/windowpin.sh"))
hl.bind("SUPER + Backspace", hl.dsp.exec_cmd(scrPath .. "/wlogout.sh"))
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd("pkill -9 waybar || waybar"))
hl.bind("SUPER + F12", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("F12", hl.dsp.window.fullscreen())

-- Application shortcuts
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(term))
hl.bind("SUPER + E", hl.dsp.exec_cmd(file))
hl.bind("SUPER + C", hl.dsp.exec_cmd(term .. " -e " .. editor))
hl.bind("SUPER + F", hl.dsp.exec_cmd(browser))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(term .. " -e btop"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("vesktop"))
hl.bind("SUPER + M", hl.dsp.exec_cmd("spotify"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("steam"))
hl.bind("CTRL + Escape", hl.dsp.exec_cmd("hyprpicker -a -f rgb &"))
hl.bind("CTRL + code:49", hl.dsp.exec_cmd("kruler"))

-- Rofi menus
hl.bind("SUPER + A", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"))
hl.bind("SUPER + Tab", hl.dsp.exec_cmd("pkill rofi || rofi -show window -modi window"))
hl.bind("SUPER + V", hl.dsp.exec_cmd(scrPath .. "/clipManager.sh"))

-- Notifications
hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Audio control
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -i m"), { locked = true })
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"),
	{ locked = true, repeating = true }
)

-- Media control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Brightness control
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh i"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh d"),
	{ locked = true, repeating = true }
)

-- Extra
hl.bind("XF86Display", hl.dsp.exec_cmd("nwg-displays"), { locked = true })
hl.bind("XF86Tools", hl.dsp.exec_cmd("cd " .. configPath .. " && " .. term .. " -e nvim"), { locked = true })
hl.bind("XF86Favorites", hl.dsp.exec_cmd(term .. " --hold -e fastfetch"), { locked = true })
hl.bind("XF86Keyboard", hl.dsp.exec_cmd("hyprctl switchxkblayout at-translated-set-2-keyboard next"), { locked = true })

-- Move between grouped windows
hl.bind("SUPER + CTRL + H", hl.dsp.group.prev())
hl.bind("SUPER + CTRL + L", hl.dsp.group.next())

-- Screenshot / Screencapture
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		'grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of the region taken" -t 1000'
	)
)
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd(
		'grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of whole screen taken" -t 1000'
	)
)

-- Move / Change window focus
hl.bind("SUPER + Left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + Right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + Up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + Down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + I", hl.dsp.layout("togglesplit"))

-- Workspaces (1 - 10)
for i = 1, 10 do
	local code = i + 9
	hl.bind("SUPER + code:" .. code, hl.dsp.focus({ workspace = tostring(i) }))
	hl.bind("SUPER + SHIFT + code:" .. code, hl.dsp.window.move({ workspace = tostring(i) }))
	hl.bind("SUPER + ALT + code:" .. code, hl.dsp.window.move({ workspace = tostring(i), silent = true }))
end

-- Relative & recent workspaces
hl.bind("SUPER + CTRL + Right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + CTRL + Left", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "previous" }))
hl.bind("SUPER + CTRL + Down", hl.dsp.focus({ workspace = "empty" }))

-- Resize windows
hl.bind("SUPER + SHIFT + Right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + Left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + Down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- Move focused window to relative workspace
hl.bind("SUPER + CTRL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind("SUPER + CTRL + ALT + Left", hl.dsp.window.move({ workspace = "r-1" }))

-- Move active window (floating vs tiled) with Super+Shift+Ctrl
local function move_active_window(dir, dx, dy)
	local win = hl.get_active_window()
	if win and win.floating then
		hl.dispatch(hl.dsp.window.move({ x = dx, y = dy, relative = true }))
	else
		hl.dispatch(hl.dsp.window.move({ direction = dir }))
	end
end

hl.bind("SUPER + SHIFT + CTRL + Left", function()
	move_active_window("left", -30, 0)
end)
hl.bind("SUPER + SHIFT + CTRL + Right", function()
	move_active_window("right", 30, 0)
end)
hl.bind("SUPER + SHIFT + CTRL + Up", function()
	move_active_window("up", 0, -30)
end)
hl.bind("SUPER + SHIFT + CTRL + Down", function()
	move_active_window("down", 0, 30)
end)

-- Scroll workspaces
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse move/resize
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + Z", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + X", hl.dsp.window.resize(), { mouse = true })

-- Special workspace (scratchpad)
hl.bind("SUPER + ALT + code:49", hl.dsp.window.move({ workspace = "special:magic", silent = true }))
hl.bind("SUPER + SHIFT + code:49", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER + code:49", hl.dsp.workspace.toggle_special("magic"))

-- Appearances
hl.bind("SUPER + O", hl.dsp.window.set_prop({ window = "active", prop = "opaque", value = "toggle" }))

local function change_zoom(factor)
	local current = hl.get_config("cursor:zoom_factor") or 1.0
	local new_zoom = math.max(1.0, math.min(10.0, current * factor))
	hl.config({ cursor = { zoom_factor = new_zoom } })
end

hl.bind("SUPER + equal", function()
	change_zoom(1.1)
end, { repeating = true })
hl.bind("SUPER + code:20", function()
	change_zoom(0.9)
end, { repeating = true })

hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("pidof hyprlock || hyprlock"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.dpms({ state = "on" }), { locked = true })
