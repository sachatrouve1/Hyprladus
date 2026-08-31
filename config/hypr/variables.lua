hl.config({

	general = {
		gaps_in = 3,
		gaps_out = 6,
		border_size = 2,

		snap = { -- snapping for floating windows
			enabled = true,
			window_gap = 10,
			monitor_gap = 10,
			border_overlap = false,
			respect_gaps = true,
		},
	},

	decoration = {
		rounding = 20,
		rounding_power = 1.0,
		dim_inactive = false,
		dim_strength = 0.1,
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 12,
			render_power = 2,
		},

		blur = {
			enabled = true,
			size = 4,
			passes = 3,
		},
	},

	input = {
		kb_layout = "fr, us",
		kb_variant = "oss,",
		kb_options = "lv3:ralt_switch",
		accel_profile = "adaptive",
		force_no_accel = 0,
		sensitivity = 0.3,
		numlock_by_default = true,

		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.5,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		vrr = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
		disable_watchdog_warning = true,
		key_press_enables_dpms = true,
		mouse_move_enables_dpms = true,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})

hl.device({
	name = "mwgradient5",
	sensitivity = -0.5,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
