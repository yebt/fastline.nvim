local M = {
  sections = {
    left = {},
    center = {},
    right = {},
  },
  separator = "%#FastlineSeparator# | %#Normal#",
}

function M.setup(opts)
  opts = opts or {}
  M.sections = vim.tbl_deep_extend("force", M.sections, opts.sections or {})
  if opts.separator then
    M.separator = opts.separator
  end
end

function M.get_sections()
  return M.sections
end

function M.get_separator()
  return M.separator
end

return M

