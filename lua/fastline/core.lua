local config = require("fastline.config")
local rendered_once = false

local function get_module_output(entry)
  if type(entry) == "string" then
    if registered[entry] then
      return coroutine.create(registered[entry])
    end

    -- try to require built-in modules
    local ok, mod = pcall(require, "fastline.modules." .. entry)
    if ok and mod and mod.get then
      return coroutine.create(mod.get)
    end

    -- expression or literal
    if entry:match("^%%{.*}$") or entry:match("^%s+$") then
      return coroutine.create(function() return entry end)
    end

    return coroutine.create(function() return "[error:" .. entry .. "]" end)
  elseif type(entry) == "table" and entry.text then
    local hl = entry.hl and ("%#" .. entry.hl .. "#") or ""
    return coroutine.create(function()
      return hl .. entry.text
    end)
  end
end

local function run_coroutines(module_names)
  local results = {}
  for _, name in ipairs(module_names) do
    local co = get_module_output(name)
    local ok, result = coroutine.resume(co)
    if not ok then
      result = "[error:" .. name .. "]"
      vim.schedule(function()
        vim.notify(
          "fastline.nvim: error in module '" .. name .. "':\n" .. tostring(result),
          vim.log.levels.ERROR
        )
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
