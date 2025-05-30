local M = {}

function M.setup()
  local hl = vim.api.nvim_set_hl
  hl(0, "FastlineSeparator", { fg = "#888888" })
  hl(0, "FastlineEncoding", { fg = "#ffaa00" })
  hl(0, "FastlineInfo", { fg = "#55aaee" })
  hl(0, "FastlineArrow", { fg = "#ffaaee" })

  -- Mode-specific highlights
  hl(0, "FastlineModeNormal", { fg = "#98c379", bold = true })
  hl(0, "FastlineModeInsert", { fg = "#61afef", bold = true })
  hl(0, "FastlineModeVisual", { fg = "#c678dd", bold = true })
end

return M
