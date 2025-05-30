local M = {
  sections = {
    left = {},
    center = {},
    right = {},
  },
}

function M.setup(opts)
  M.sections = vim.tbl_deep_extend("force", M.sections, opts.sections or {})
end

function M.get_sections()
  return M.sections
end

return M

