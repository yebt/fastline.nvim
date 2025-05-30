local M = {}
local startup_time = nil

function M.capture()
  if startup_time then return end
  local t0 = vim.g.vim_start_time or vim.g.start_time or vim.fn.reltime()
  startup_time = vim.fn.reltimefloat(vim.fn.reltime(t0))
end

function M.get()
  M.capture()
  if not startup_time then return "" end
  return string.format("%%#FastlineStartup#Startup: %.2fms", startup_time * 1000)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "FastlineReady",
  callback = function()
    M.capture()
    require("fastline.redraw").schedule()
  end,
})

return M
