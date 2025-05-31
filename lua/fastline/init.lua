local M = {}

function M.setup(opts)
  require("fastline.config").setup(opts or {})
  require("fastline.highlights").setup()
  vim.o.statusline = "%!v:lua.require'fastline.core'.render()"
end

function M.register(name, mod)
  require("fastline.registry").register(name, mod)
end

return M
