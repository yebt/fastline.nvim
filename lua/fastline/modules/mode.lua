local M = {}
local redraw = require("fastline.redraw")

local mode_map = {
  n = { "NOR", "FastlineModeNormal" },
  i = { "INS", "FastlineModeInsert" },
  v = { "VIS", "FastlineModeVisual" },
  V = { "V-L", "FastlineModeVisual" },
  [""] = { "V-B", "FastlineModeVisual" },
  c = { "CMD", "FastlineModeCommand" },
  R = { "REP", "FastlineModeReplace" },
  t = { "TER", "FastlineModeTerminal" },
}

function M.get()
  local mode = vim.api.nvim_get_mode().mode
  local data = mode_map[mode] or { mode, "FastlineMode" }
  --return ("%#%s# %s "):format(data[2], data[1])
  return ("%%#%s# %s %%*"):format(data[2], data[1])
end

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = redraw.schedule,
})

return M

