local M = {}
local redraw = require("fastline.redraw")

function M.get()
  local name = vim.fn.expand("%:t")
  return "%#FastlineFilename# " .. (name ~= "" and name or "[No Name]") .. " "
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
  callback = redraw.schedule,
})

return M

