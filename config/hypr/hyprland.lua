-- Add config path to Lua module search path
local config_dir = os.getenv("HOME") .. "/.config/hypr"
package.path = config_dir .. "/?.lua;" .. config_dir .. "/?/init.lua;" .. package.path

-- SOURCES

require("animations")
require("keybindings")
require("windowrules")
require("variables")
require("monitors")

local colors_path = os.getenv("HOME") .. "/.cache/hypr/colors.lua"
local f = io.open(colors_path, "r")
if f then
	f:close()
	pcall(require, colors_path)
end

-- ENV

local scrPath = os.getenv("HOME") .. "/.local/share/bin"
hl.env("PATH", (os.getenv("PATH") or "") .. ":" .. scrPath)
hl.env("XCURSOR_THEME", "Bibata-Original-Classic")
hl.env("XCURSOR_SIZE", "20")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("GDK_SCALE", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("OZONE_PLATFORM_HINT", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "x11")
hl.env("ELECTRON_ENABLE_OZONE", "1")

-- AUTOSTART

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("waybar")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("udiskie --no-automount --smart-tray")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("__GLX_VENDOR_LIBRARY_NAME=intel swaync")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("hypridle")
end)
