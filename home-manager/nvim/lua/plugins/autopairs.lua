local event = require('vim_event')

---@type LazyPluginSpec
local autopairs = {
  'windwp/nvim-autopairs',
  config = function()
    local npairs = require('nvim-autopairs')
    local rule = require('nvim-autopairs.rule')
    local brackets = {
      { '(', ')' },
      { '{', '}' },
      { '[', ']' }
    }

    npairs.setup({
      map_c_h = true
    })

    -- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses
    npairs.add_rules({
      rule(' ', ' '):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({
          brackets[1][1] .. brackets[1][2],
          brackets[2][1] .. brackets[2][2],
          brackets[3][1] .. brackets[3][2]
        }, pair)
      end)
    })

    for _, bracket in ipairs(brackets) do
      npairs.add_rules({
        rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(function() return false end)
            :with_move(function(opts)
              return opts.prev_char:match('.%' .. bracket[2]) ~= nil
            end)
            :use_key(bracket[2])
      })
    end
  end,
  event = {
    event.buf_new_file,
    event.buf_read_post
  }
}

return autopairs
