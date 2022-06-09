LspConfig.denols.setup {
  capabilities = Capabilities,
  root_dir = function (fname)
    return LspConfig.util.root_pattern('deno.json')(fname)
  end
}
