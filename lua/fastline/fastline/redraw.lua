local M = {}
local scheduled = false

function M.schedule()
  if scheduled then return end
  scheduled = true

  vim.schedule(function()
    scheduled = false
    vim.cmd("redrawstatus")
  end)
end

return M
