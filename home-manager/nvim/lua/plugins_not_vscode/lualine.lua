---@type LazyPluginSpec
local lualine = {
	"nvim-lualine/lualine.nvim",
	config = true,
	dependencies = {
		require "plugins_not_vscode.devicons",
		require "plugins_not_vscode.vscode",
	},
}

return lualine
