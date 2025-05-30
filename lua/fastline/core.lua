local config = require("fastline.config")
local rendered_once = false
local user_modules = require("fastline").get_user_modules()

local function get_module_output(name)
  if type(name) == "table" and name.text then
    local hl = name.hl and ("%#" .. name.hl .. "#") or ""
    return coroutine.create(function()
      return hl .. name.text
    end)
  end

  if type(name) ~= "string" then
    return coroutine.create(function()
      return ""
    end)
  end

  if name:match("^%%{.*}$") or name:match("^%s+$") then
    return coroutine.create(function()
      return name
    end)
  end

  if user_modules[name] then
    return coroutine.create(user_modules[name])
  end

  local ok, mod = pcall(require, "fastline.modules." .. name)
  if ok and mod and mod.get then
    return coroutine.create(mod.get)
  end

  return coroutine.create(function()
    return "[error:load:" .. name .. "]"
  end)
end

local function run_coroutines(modules)
  local results = {}
  for _, name in ipairs(modules) do
    local co = get_module_output(name)
    local ok, result = coroutine.resume(co)
    if not ok then
      result = "[error:" .. name .. "]"
      vim.schedule(function()
        vim.notify("fastline.nvim: error in module '" .. name .. "':\n" .. tostring(result), vim.log.levels.ERROR)
      end)
    end
    table.insert(results, result or "")
  end
  return results
end

local function render_section(modules, separator)
  local parts = run_coroutines(modules)
  return table.concat(parts, separator or "%#FastlineSeparator# | %#Normal#")
end

local function render()
  if not rendered_once then
    rendered_once = true
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "FastlineReady" })
    end)
  end

  local sections = config.get_sections()
  local left = render_section(sections.left)
  local center = render_section(sections.center)
  local right = render_section(sections.right)

  return table.concat({ "%#Normal#", left, "%=", center, "%=", right }, " ")
end

return {
  render = render,
}


