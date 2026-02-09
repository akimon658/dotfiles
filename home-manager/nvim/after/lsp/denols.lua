return {
  root_markers = { "deno.json", "deno.jsonc" },
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
      },
    },
  },
  workspace_required = true,
}
