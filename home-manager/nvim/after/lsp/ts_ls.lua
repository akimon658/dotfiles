return {
  root_dir = function()
  end, -- Prevent lspconfig from automatically setting root_dir
  root_markers = { "tsconfig.json" },
  workspace_required = true,
}
