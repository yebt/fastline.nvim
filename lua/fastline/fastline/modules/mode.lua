local M = {}
local redraw = require("modeline.redraw")

local mode_map = {
  n = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE", [""] = "V-BLOCK",
  c = "COMMAND", R = "REPLACE", t = "TERMINAL",
}

local mode_alias = {
  --Normal
  ['n'] = 'Normal',
  ['no'] = 'O-Pending',
  ['nov'] = 'O-Pending',
  ['noV'] = 'O-Pending',
  ['no\x16'] = 'O-Pending',
  ['niI'] = 'Normal',
  ['niR'] = 'Normal',
  ['niV'] = 'Normal',
  ['nt'] = 'Normal',
  ['ntT'] = 'Normal',
  ['v'] = 'Visual',
  ['vs'] = 'Visual',
  ['V'] = 'V-Line',
  ['Vs'] = 'V-Line',
  ['\x16'] = 'V-Block',
  ['\x16s'] = 'V-Block',
  ['s'] = 'Select',
  ['S'] = 'S-Line',
  ['\x13'] = 'S-Block',
  ['i'] = 'Insert',
  ['ic'] = 'Insert',
  ['ix'] = 'Insert',
  ['R'] = 'Replace',
  ['Rc'] = 'Replace',
  ['Rx'] = 'Replace',
  ['Rv'] = 'V-Replace',
  ['Rvc'] = 'V-Replace',
  ['Rvx'] = 'V-Replace',
  ['c'] = 'Command',
  ['cv'] = 'Ex',
  ['ce'] = 'Ex',
  ['r'] = 'Replace',
  ['rm'] = 'More',
  ['r?'] = 'Confirm',
  ['!'] = 'Shell',
  ['t'] = 'Terminal',
}


function M.get()
  local mode = vim.api.nvim_get_mode().mode
  local label = mode_map[mode] or mode
  return "%#FastlineMode# " .. label .. " "
end

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = redraw.schedule,
})

return M

