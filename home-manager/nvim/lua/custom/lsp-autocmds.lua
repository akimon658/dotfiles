local any_pattern = "*"

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("fmt", {}),
  callback = function()
    vim.lsp.buf.format {
      filter = function(client)
        return client:supports_method "textDocument/formatting"
      end,
    }
  end,
  pattern = any_pattern,
})

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
-- https://zenn.dev/izumin/articles/b8046e64eaa2b5
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("organize_imports", {}),
  callback = function(args)
    local supported_clients = {
      "denols",
      "gopls",
    }

    for _, client in ipairs(vim.lsp.get_clients { bufnr = args.buf }) do
      if vim.tbl_contains(supported_clients, client.name) then
        local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
        params.context = { only = { "source.organizeImports" }, diagnostics = {} }
        local res = client:request_sync("textDocument/codeAction", params)

        for _, r in pairs(res and res.result or {}) do
          if r.edit then
            local enc = (vim.lsp.get_client_by_id(client.id) or {}).offset_encoding or "utf-16"
            vim.lsp.util.apply_workspace_edit(r.edit, enc)
          end
        end
      end
    end
  end,
  pattern = any_pattern,
})

vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("diagnostics_hover", {}),
  callback = function()
    if vim.diagnostic.is_enabled() then
      vim.diagnostic.open_float { focusable = false }
    end
  end,
  pattern = any_pattern,
})
