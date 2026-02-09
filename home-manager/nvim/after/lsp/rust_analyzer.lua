---@type vim.lsp.Config
return {
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        bindingModeHints = {
          enable = true,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
        },
        closureCaptureHints = {
          enable = true,
        },
        closureReturnTypeHints = {
          enable = true,
        },
        discriminantHints = {
          enable = true,
        },
        expressionAdjustmentHints = {
          enable = true,
        },
        genericParameterHints = {
          lifetime = {
            enable = true,
          },
          type = {
            enable = true,
          },
        },
        implicitDrops = {
          enable = true,
        },
        implicitSizedBoundHints = {
          enable = true,
        },
        lifetimeElisionHints = {
          enable = true,
        },
        rangeExclusiveHints = {
          enable = true,
        },
        reborrowHints = {
          enable = true,
        },
      },
    },
  },
}
