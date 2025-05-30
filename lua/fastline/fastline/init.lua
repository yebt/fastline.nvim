local M = {}

function M.setup(opts)
  require("fastline.config").setup(opts)
  require("fastline.highlights").setup()
  vim.o.statusline = "%!v:lua.require'fastline.core'.render()"
end

return M
