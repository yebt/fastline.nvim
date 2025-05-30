local M = {}

local mode_map = {
  n = {"N", "FastlineModeNormal"},
  i = {"I", "FastlineModeInsert"},
  v = {"V", "FastlineModeVisual"},
  V = {"V-L", "FastlineModeVisual"},
  ['\22'] = {"V-B", "FastlineModeVisual"},
  c = {"C", "FastlineModeNormal"},
}

function M.get()
  local mode = vim.fn.mode()
  local label, hl = unpack(mode_map[mode] or {mode, "FastlineModeNormal"})
  return string.format("%%#%s# %s ", hl, label)
end

return M
