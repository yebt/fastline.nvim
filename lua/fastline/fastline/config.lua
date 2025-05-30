local M = {
  sections = {
    left = {},
    center = {},
    right = {},
  }
}

function M.setup(opts)
  opts = opts or {}
  for section, modules in pairs(opts.sections or {}) do
    M.sections[section] = modules
  end
end

function M.get_sections()
  return M.sections
end

return M

