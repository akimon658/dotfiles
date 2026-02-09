---@type LazyPluginSpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "codecompanion", "markdown" },
  ---@type render.md.UserConfig
  opts = {
    heading = {
      backgrounds = {
        "None",
        "None",
        "None",
        "None",
        "None",
        "None",
      },
      icons = {
        "# ", "## ", "### ", "#### ", "##### ", "###### ",
      },
      sign = false,
    },
  },
}
