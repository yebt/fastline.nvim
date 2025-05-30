local M = {}
local redraw = require("fastline.redraw")

function M.get()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients == 0 then return "" end

  local names = {}
  for _, client in pairs(clients) do
    table.insert(names, client.name)
  end
  return "%#FastlineLSP#LSP: " .. table.concat(names, ", ")
end

vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
  callback = redraw.schedule,
})

return M
