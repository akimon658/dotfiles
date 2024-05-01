---@type LazyPluginSpec
local cmp = {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require "cmp"
		local luasnip = require "luasnip"
		---@return boolean
		local function has_words_before()
			local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and
			vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
		end
		local bordered_window = cmp.config.window.bordered()

		cmp.setup {
			formatting = { format = require "lspkind".cmp_format() },
			mapping = {
				["<C-n>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-p>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<Tab>"] = cmp.mapping.confirm {
					select = true,
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "path" },
			},
			window = {
				completion = bordered_window,
				documentation = bordered_window,
			},
		}

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources {
				{ name = "cmdline" },
				{ name = "path" },
			},
		})
	end,
	dependencies = {
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		{
			"hrsh7th/cmp-nvim-lsp",
			dependencies = { require "plugins_not_vscode.lspconfig" },
		},
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",
		{
			"saadparwaiz1/cmp_luasnip",
			dependencies = { "L3MON4D3/LuaSnip" },
		},
	},
	event = {
		"CmdlineEnter",
		require "vim_event".insert_enter,
	},
}

return cmp
