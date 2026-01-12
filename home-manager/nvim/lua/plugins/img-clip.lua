---@type LazyPluginSpec
return {
  "hakonharnes/img-clip.nvim",
  cmd = {
    "PasteImage",
  },
  opts = {
    filetypes = {
      codecompanion = {
        dir_path = os.getenv "TMPDIR" .. "/img-clip.nvim/",
        prompt_for_file_name = false,
        template = "[Image]($FILE_PATH)",
        use_absolute_path = true,
      },
    },
  },
}
