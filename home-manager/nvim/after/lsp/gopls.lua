---@type string
local goimports_local
local gomod_path = vim.fn.getcwd() .. "/go.mod"

if vim.fn.filereadable(gomod_path) == 1 then
  local f = io.open(gomod_path)

  if f then
    goimports_local = vim.split(f:read(), " ")[2]
  end
end

---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      ["local"] = goimports_local,
    },
  },
}
