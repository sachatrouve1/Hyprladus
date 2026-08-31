-- WINDOW RULES & LAYER RULES

-- Opacity Rules
local opacity_rules = {
	{
		opacity = "0.80 0.80",
		classes = {
			"[Ff]oot",
			"code-url-handler",
			"code-insiders-url-handler",
			"org.kde.ark",
			"nwg-look",
			"qt5ct",
			"qt6ct",
			"kvantummanager",
			"com.github.tchx84.Flatseal",
			"hu.kramo.Cartridges",
			"com.obsproject.Studio",
			"gnome-boxes",
			"vesktop",
			"discord",
			"WebCord",
			"ArmCord",
			"legcord",
			"app.drey.Warp",
			"net.davidotek.pupgui2",
			"yad",
			"Signal",
			"io.github.alainm23.planify",
			"io.gitlab.theevilskeleton.Upscaler",
			"com.github.unrud.VideoDownloader",
			"io.gitlab.adhami3310.Impression",
			"io.missioncenter.MissionCenter",
			"io.github.flattool.Warehouse",
		},
	},
	{
		opacity = "0.90 0.90",
		classes = {
			"Google-chrome",
			"Brave-browser",
			"code-oss",
			"[Cc]ode",
			"sublime_text",
			"thunar",
			"com.github.rafostar.Clapper",
			"jetbrains-idea",
		},
	},
	{ opacity = "1.00 1.00", classes = { "firefox", "[Ss]team" } },
	{ opacity = "0.70 0.70", classes = { "steamwebhelper", "[Ss]potify" } },
	{
		opacity = "0.80 0.70",
		classes = {
			"org.pulseaudio.pavucontrol",
			"blueman-manager",
			"nm-applet",
			"nm-connection-editor",
			"org.kde.polkit-kde-authentication-agent-1",
			"polkit-gnome-authentication-agent-1",
			"org.freedesktop.impl.portal.desktop.gtk",
			"org.freedesktop.impl.portal.desktop.hyprland",
		},
	},
}

for _, rule in ipairs(opacity_rules) do
	for _, cls in ipairs(rule.classes) do
		hl.window_rule({
			match = { class = cls },
			opacity = rule.opacity,
		})
	end
end

hl.window_rule({
	match = { class = "foot" },
	opacity = "1.0 1.0",
})

hl.window_rule({
	match = { initial_title = "Spotify Free" },
	opacity = "0.70 0.70",
})

hl.window_rule({
	match = { initial_title = "Spotify Premium" },
	opacity = "0.70 0.70",
})

-- Jetbrains flickering fix
hl.window_rule({
	match = { class = "jetbrains-toolbox" },
	no_initial_focus = true,
	float = true,
})

hl.window_rule({
	match = { class = "(jetbrains-)(.*)", title = "^$", initial_title = "^$" },
	no_initial_focus = true,
	float = true,
})

hl.window_rule({
	match = { class = "(jetbrains-)(.*)", initial_title = "(.+)" },
	no_initial_focus = true,
	float = true,
})

hl.window_rule({
	match = { class = "(jetbrains-)(.*)" },
	no_initial_focus = true,
	float = true,
})

-- Specific window adjustments
hl.window_rule({
	match = { class = "org.kde.kruler" },
	no_shadow = true,
	border_size = 0,
	rounding = 0,
	float = true,
})

hl.window_rule({
	match = { class = "[Uu]niliste" },
	float = true,
})

-- Screen-share (XWayland Video Bridge)
hl.window_rule({
	name = "xwayland-video-bridge",
	match = { class = "xwaylandvideobridge" },
	opacity = "0.0 override",
	no_anim = true,
	no_initial_focus = true,
	max_size = "1 1",
	no_blur = true,
	no_focus = true,
})

-- Common Modals
local common_modals = {
	"Open",
	"Chose Files",
	"Save As",
	"Confirm to replace files",
	"File Operation Progress",
}

for _, modal_title in ipairs(common_modals) do
	hl.window_rule({
		match = { title = modal_title },
		float = true,
	})
end

hl.window_rule({
	match = { class = "xdg-desktop-portal-gtk" },
	float = true,
})

-- Tiled windows & emulator
hl.window_rule({
	match = { float = false },
	no_shadow = true,
})

hl.window_rule({
	match = { class = "Emulator" },
	float = true,
})

-- LAYER RULES
local blur_namespaces = { "rofi", "notifications", "logout_dialog", "waybar" }
for _, ns in ipairs(blur_namespaces) do
	hl.layer_rule({
		match = { namespace = ns },
		blur = true,
	})
end

local alpha_namespaces = { "swaync-notification-window", "swaync-control-center" }
for _, ns in ipairs(alpha_namespaces) do
	hl.layer_rule({
		match = { namespace = ns },
		blur = true,
		ignore_alpha = 0.4,
	})
end
