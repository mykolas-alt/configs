-- Pull in the wezterm API
local wezterm = require("wezterm")

local tmux_time = true

-- This will hold the configuration.
local config = wezterm.config_builder()
local mux = wezterm.mux

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({ "Fragment Mono", "FiraCode Nerd Font" })

config.hide_tab_bar_if_only_one_tab = true

if not tmux_time then
	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

	config.keys = {
		-- Pane splitting (respect working directory)
		-- Split vertically, in current pane directory
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		-- Split horizontally, in current pane directory
		{
			key = "|",
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "a",
			mods = "LEADER|CTRL",
			action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
		},
		{
			key = "[",
			mods = "LEADER",
			action = wezterm.action.ActivateCopyMode,
		},

		-- Close pane WITHOUT confirmation
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = false }),
		},

		-- move between split panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),
		-- resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),

		-- Tabs like tmux windows
		{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },

		-- Leader + number to switch tabs 1-9
		{
			key = "1",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(0),
		},
		{
			key = "2",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(1),
		},
		{
			key = "3",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(2),
		},
		{
			key = "4",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(3),
		},
		{
			key = "5",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(4),
		},
		{
			key = "6",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(5),
		},
		{
			key = "7",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(6),
		},
		{
			key = "8",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(7),
		},
		{
			key = "9",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(8),
		},

		-- Rename tab
		{
			key = ",",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = "Rename Tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
	}
end

-- Optional: make tabs look prettier like tmux's statusline
config.use_fancy_tab_bar = true
config.tab_max_width = 30

-- and finally, return the configuration to wezterm
return config
