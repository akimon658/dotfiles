---@type vim.lsp.Config
return {
  settings = {
    -- https://scalameta.org/metals/docs/editors/user-configuration
    metals = {
      inlayHints = {
        byNameParameters = {
          enable = true,
        },
        hintsInPatternMatch = {
          enable = true,
        },
        hintsXRayMode = {
          enable = true,
        },
        implicitArguments = {
          enable = true,
        },
        implicitConversions = {
          enable = true,
        },
        inferredTypes = {
          enable = true,
        },
        namedParameters = {
          enable = true,
        },
        typeParameters = {
          enable = true,
        },
      },
    },
  },
}
