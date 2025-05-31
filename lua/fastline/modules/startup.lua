local M = {}
local startup_time = nil

function M.capture()
  if startup_time then return end
   
  local ok, lz = pcall(require,"lazy")
  if ok then
      startup_time = lz.stats().startuptime
  end
  -- local t0 = vim.g.vim_start_time or vim.g.start_time or vim.fn.reltime()
  -- startup_time = vim.fn.reltimefloat(vim.fn.reltime(t0))
end

function M.get()
  M.capture()
  if not startup_time then return "" end
  -- return startup_time
  return string.format("%%#FastlineStartup#󱐋 %.3fms", startup_time)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "FastlineReady",
  callback = function()
    M.capture()
    require("fastline.redraw").schedule()
  end,
})

return M
