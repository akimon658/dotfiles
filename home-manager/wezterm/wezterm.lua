local wezterm = require "wezterm"

local config = {
  default_prog = { string.format("%s/.nix-profile/bin/fish", os.getenv "HOME"), "--login" },
  font = wezterm.font_with_fallback {
    "Roboto Mono",
    "Noto Sans JP",
  },
  font_size = 12.0,
  send_composed_key_when_right_alt_is_pressed = true,
  window_background_opacity = 0.8,
  window_decorations = "INTEGRATED_BUTTONS | RESIZE",
  window_frame = {
    font_size = 12.0,
  },
}

if string.find(wezterm.target_triple, "windows") then
  config.default_prog = { "pwsh", "-NoLogo" }
end

---@param path string
---@return string
local function trim_path(path)
  local s = string.gsub(path, "(.*[/\\])(.*)", "%2")

  return s
end

---@type { [string]: { color?: string, icon: string } }
local process_icons = {
  docker = {
    color = "#1d63ed",
    icon = wezterm.nerdfonts.md_docker,
  },
  fish = {
    icon = wezterm.nerdfonts.dev_terminal,
  },
  go = {
    color = "#79d4fd",
    icon = wezterm.nerdfonts.md_language_go,
  },
  nvim = {
    color = "#00b952",
    icon = wezterm.nerdfonts.custom_neovim,
  },
}

wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
  local pane = tab.active_pane
  local process_name = trim_path(pane.foreground_process_name)

  if not pane.current_working_dir then
    return process_name
  end
  ---@type string
  local cwd = pane.current_working_dir.file_path
  local text_color = tab.is_active and "#c0c0c0" or "#808080"
  local icon_spec = process_icons[process_name]

  return {
    {
      Foreground = {
        Color = text_color, -- For close-tab button
      },
    },
    {
      Text = utf8.char(0x200B), -- Zero-width space
    },
    {
      Foreground = {
        Color = tab.is_active and icon_spec and icon_spec.color or text_color,
      },
    },
    { Text = icon_spec and icon_spec.icon or process_name .. " on" },
    {
      Foreground = {
        Color = text_color,
      },
    },
    { Text = " " .. trim_path(cwd) },
  }
end)

wezterm.on("gui-startup", function()
  local _, _, window = wezterm.mux.spawn_window {}
  window:gui_window():maximize()
end)

if string.find(wezterm.target_triple, "apple") then
  wezterm.on("window-focus-changed", function(window, _)
    if window:is_focused() then
      os.execute "osascript -e 'tell application \"System Events\" to key code 102'"
    end
  end)
end

return config
