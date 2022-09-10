local cmp = require('cmp')
local luasnip = require('luasnip')
local function has_words_before()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup {
  mapping = {
    ['<C-n>'] = cmp.mapping(function(fallback)
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
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<Tab>'] = cmp.mapping.confirm {
      select = true
    }
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' }
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

UseDeno = vim.fn.filereadable(vim.fn.getcwd() .. '/deno.json') == 1
local tsserver = UseDeno and 'denols' or 'tsserver'

local servers = {
  'bashls',
  'clangd',
  'cssls',
  'gopls',
  'pylsp',
  'sumneko_lua',
  tsserver
}

LspConfig = require('lspconfig')
for _, lsp in ipairs(servers) do
  LspConfig[lsp].setup {
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  }
end
LspConfig.powershell_es.setup {
  bundle_path = 'C:/PowerShellEditorServices',
  capabilities = capabilities
}

require('nvim-treesitter.configs').setup {
  auto_install = true,
  highlight = {
    enable = true
  }
}

local id = vim.api.nvim_create_augroup('fmt', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  group = id,
  pattern = { '*' },
  command = 'lua vim.lsp.buf.formatting_sync()'
})

vim.g.scrollview_character = '▎'
vim.g.scrollview_column = 1
vim.g.vscode_transparent = 1
vim.cmd('colorscheme vscode')
vim.keymap.set('n', '<C-p>', '<Cmd>GFiles<CR>')
vim.keymap.set('n', '<C-g>', '<Cmd>LazyGit<CR>')
vim.opt.cmdheight = 0
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.wrap = false

if vim.fn.has('win64') == 1 then
  vim.opt.shell = 'pwsh -NoLogo'
  vim.opt.shellcmdflag = '-Command'
  vim.opt.shellxquote = ''
end
