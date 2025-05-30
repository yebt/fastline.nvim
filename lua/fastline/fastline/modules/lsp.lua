local M = {}
local redraw = require("modeline.redraw")

function M.get()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return #names > 0 and ("%#FastlineLSP#LSP: " .. table.concat(names, ", ")) or ""
end

vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
  callback = redraw.schedule,
})

return M

