local M = {}
function M.get()
  local branch = vim.b.gitsigns_head or ""
  if branch ~= "" then
    return " " .. branch
  end
  return ""
end
return M
