---@type LazyPluginSpec
return {
  "TaDaa/vimade",
  lazy = true,
  opts = {
    blocklist = {
      default = function(_, active)
        -- Enable only if the active buffer is a Telescope prompt
        if active and active.buf_opts.filetype ~= "TelescopePrompt" then
          return true
        end

        return false
      end,
    },
    recipe = {
      "default",
      {
        animate = true,
      },
    },
  },
}
