local M = {}
local redraw = require("modeline.redraw")

function M.get()
  local head = vim.b.gitsigns_head
  if not head then return "" end
  return "%#FastlineGit# " .. head .. " "
end

vim.api.nvim_create_autocmd("User", {
  pattern = "GitsignsUpdate",
  callback = redraw.schedule,
})

return M

