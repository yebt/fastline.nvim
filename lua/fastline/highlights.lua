local M = {}

function M.setup()
  local hl = vim.api.nvim_set_hl
  -- Base
  
  -- Modules
  hl(0, "FastlineSeparator", { fg = "#888888" })
  hl(0, "FastlineEncoding", { fg = "#ffaa00" })
  hl(0, "FastlineInfo", { fg = "#55aaee" })
  hl(0, "FastlineGit",       { fg = "#ff6c6b", bold = true })
  hl(0, "FastlineArrow", { fg = "#ffaaee" })
  hl(0, "FastlineFilename", { fg = "#abb2bf", bold = true })
  hl(0, "FastlineFilenameR", { fg = "#abb2bf", reverse = true, bold = true })

  -- Mode-specific highlights
  hl(0, "FastlineModeNormal", { fg = "#98c379", bold = true })
  hl(0, "FastlineModeInsert", { fg = "#61afef", bold = true })
  hl(0, "FastlineModeVisual", { fg = "#c678dd", bold = true })

  hl(0, "FastlineModeNormalR", { fg = "#98c379", reverse = true, bold = true })
  hl(0, "FastlineModeInsertR", { fg = "#61afef", reverse = true, bold = true })
  hl(0, "FastlineModeVisualR", { fg = "#c678dd", reverse = true, bold = true })


  hl(0, "FastlinGiteHead",   {})
  hl(0, "FastlinGiteAdd",    {})
  hl(0, "FastlinGiteChange", {})
  hl(0, "FastlinGiteDelete", {})
end

return M
