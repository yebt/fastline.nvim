local M = {}
local redraw = require("modeline.redraw")

function M.get()
  local filename = vim.fn.expand("%:t")
  if filename == "" then filename = "[No Name]" end
  return "%#FastlineFilename# " .. filename .. " "
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
  callback = redraw.schedule,
})

return M

