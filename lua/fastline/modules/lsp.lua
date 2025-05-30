local M = {}
function M.get()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    local names = {}
    for _, c in ipairs(clients) do
      table.insert(names, c.name)
    end
    return "  " .. table.concat(names, ", ")
  end
  return "-"
end
return M
