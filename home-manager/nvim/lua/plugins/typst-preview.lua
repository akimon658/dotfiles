---@type LazyPluginSpec
return {
  "chomosuke/typst-preview.nvim",
  build = function()
    require "typst-preview".update()
  end,
  ft = "typst",
  opts = {
    dependencies_bin = {
      tinymist = "tinymist",
    },
  },
}
