---@param name string
local function create_augroup(name)
  vim.api.nvim_create_augroup(name, {})
end

---@class autoCmdConfig
---@field group any
---@field pattern string[]|string
---@field callback function

---@class autoCmd
---@field event string
---@field config autoCmdConfig

---@param autocmd autoCmd
local function create_autocmd(autocmd)
  vim.api.nvim_create_autocmd(autocmd.event, autocmd.config)
end

return {
  create_augroup = create_augroup,
  create_autocmd = create_autocmd,
}
