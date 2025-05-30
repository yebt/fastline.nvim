local M = {}
local startup_time = nil

function M.capture_startup_time()
  if startup_time then return end
  local start = vim.g.vim_start_time or vim.g.start_time or vim.fn.reltime()
  startup_time = vim.fn.reltimefloat(vim.fn.reltime(start))
end

function M.get()
  M.capture_startup_time()
  return startup_time and string.format("%%#FastlineStartup#Startup: %.2fms", startup_time * 1000) or ""
end

vim.api.nvim_create_autocmd("User", {
  pattern = "FastlineReady",
  callback = function()
    M.capture_startup_time()
    require("modeline.redraw").schedule()
  end,
})

return M

