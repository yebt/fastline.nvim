local M = {}

local user_modules = {}

function M.setup(opts)
  require("fastline.config").setup(opts)
  require("fastline.highlights").setup()
  vim.o.statusline = "%!v:lua.require'fastline.core'.render()"
end

function M.register(name, provider_fn)
  if type(name) == "string" and type(provider_fn) == "function" then
    user_modules[name] = provider_fn
  else
    vim.notify("[fastline] Invalid module registration: " .. tostring(name), vim.log.levels.ERROR)
  end
end

function M.get_user_modules()
  return user_modules
end

return M
