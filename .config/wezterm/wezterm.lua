-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.enable_tab_bar = false
config.window_padding = {
	left = 40,
	right = 40,
	top = 10,
	bottom = 0,
}
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.window_background_opacity = 1.0

config.color_scheme = "Everblush"

-- config.font_rules = {
-- 	-- For Bold-but-not-italic text, use this relatively bold font, and override
-- 	-- Normal
-- 	{
-- 		intensity = "Normal",
-- 		italic = false,
-- 		font = wezterm.font_with_fallback({
-- 			family = "JetBrains Mono NL",
-- 			weight = 600,
-- 			italic = false,
-- 		}),
-- 	},
-- 	-- Bold
-- 	{
-- 		intensity = "Bold",
-- 		italic = false,
-- 		font = wezterm.font_with_fallback({
-- 			family = "JetBrains Mono NL",
-- 			weight = "ExtraBold",
-- 			italic = false,
-- 		}),
-- 	},
--
-- 	-- Bold-and-italic
-- 	{
-- 		intensity = "Bold",
-- 		italic = true,
-- 		font = wezterm.font_with_fallback({
-- 			family = "JetBrains Mono NL",
-- 			weight = "ExtraBold",
-- 			italic = true,
-- 		}),
-- 	},
--
-- 	-- normal-and-italic
-- 	{
-- 		intensity = "Normal",
-- 		italic = true,
-- 		font = wezterm.font_with_fallback({
-- 			family = "JetBrains Mono NL",
-- 			weight = 600,
-- 			italic = true,
-- 		}),
-- 	},
--
-- 	-- half-intensity-and-italic (half-bright or dim); use a lighter weight font
-- 	{
-- 		intensity = "Half",
-- 		italic = true,
-- 		font = wezterm.font_with_fallback({
-- 			family = "JetBrains Mono NL",
-- 			weight = "Bold",
-- 			italic = true,
-- 		}),
-- 	},
--
-- 	-- half-intensity-and-not-italic
-- 	{
-- 		intensity = "Half",
-- 		italic = false,
-- 		font = wezterm.font_with_fallback({
-- 			family = "JetBrains Mono NL",
-- 			weight = "Bold",
-- 		}),
-- 	},
-- }

config.font = wezterm.font_with_fallback({
	{
		family = "JetBrains Mono NL",
		weight = "Bold",
		style = "Normal",
	},
	"JetBrains Mono",
	"Material Design Icons",
})

config.bold_brightens_ansi_colors = "BrightOnly"
config.hide_mouse_cursor_when_typing = true
config.font_size = 13
config.enable_scroll_bar = false
config.enable_wayland = true
config.freetype_load_target = "Normal"
config.front_end = "OpenGL"
config.max_fps = 60
-- config.cursor_blink_rate = 800
-- config.cursor_blink_ease_in = "EaseOut"
-- config.cursor_blink_ease_out = "EaseOut"
-- confiig.cursor_thickness = 1.0
config.default_cursor_style = "SteadyBar"
config.window_close_confirmation = "NeverPrompt"
-- and finally, return the configuration to wezterm
return config
