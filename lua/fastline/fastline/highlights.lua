local M = {}

function colorize(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

function M.setup()
  local colors = {
    green_pistachio = '#98c379',
    blue_argentinian = '#61afef',
    gray_paynes = '#5c6370',
  }

  local theme = {
    ['FastlineLSP'] = { fg = colors.green_pistachio, bold = true },
    ['FastlineStartup'] = { fg = colors.blue_argentinian, bold = true },
    ['FastlineSeparator'] = { fg = colors.gray_paynes },
    ['FastlineSeparator'] = { fg = colors.gray_paynes },
    ['FastlineNormal'] = {link = 'Statusline'}
  }
  for name, opts in pairs(theme) do
    colorize(name, opts)
  end
  -- vim.cmd("highlight FastlineLSP guifg=#98c379 guibg=NONE gui=bold")
  -- vim.cmd("highlight FastlineStartup guifg=#61afef guibg=NONE gui=bold")
  -- vim.cmd("highlight FastlineMode guifg=#e5c07b guibg=NONE gui=bold")
  -- vim.cmd("highlight FastlineFilename guifg=#abb2bf guibg=NONE")
  -- vim.cmd("highlight FastlineGit guifg=#ff6c6b guibg=NONE gui=bold")
  -- vim.cmd("highlight FastlineSeparator guifg=#5c6370 guibg=NONE")
end

return M
