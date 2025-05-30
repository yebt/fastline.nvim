local M = {}
local registered = {}

function M.setup(opts)
  require("fastline.config").setup(opts)
  require("fastline.highlights").setup()
  vim.o.statusline = "%!v:lua.require'fastline.core'.render()"
end

function M.register(name, fn)
  if type(name) == "string" and type(fn) == "function" then
    registered[name] = fn
  else
    vim.notify("[fastline] Invalid provider registration for " .. tostring(name), vim.log.levels.WARN)
  end
end
return M
