local config = require("fastline.config")
local registry = require("fastline.registry")

local rendered_once = false

-- local function get_module_output(entry)
--   if type(entry) == "string" then
--     if entry:match("^%%{.*}$") or entry:match("^%s+$") then
--       return coroutine.create(function() return entry end)
--     end
--
--     local mod = registry.get(entry)
--     if mod and mod.get then
--       return coroutine.create(mod.get)
--     end
--
--     return coroutine.create(function() return "[error:load:" .. entry .. "]" end)
--   elseif type(entry) == "table" and entry.text then
--     local hl = entry.hl and ("%#" .. entry.hl .. "#") or ""
--     return coroutine.create(function()
--       return hl .. entry.text
--     end)
--   end
--
--   return coroutine.create(function() return "" end)
-- end

local function get_module_output(entry)
  if type(entry) == "string" then
    if entry:match("^%%{.*}$") or entry:match("^%s+$") then
      return coroutine.create(function() return entry end)
    end

    local ok, mod = pcall(require, "fastline.modules." .. entry)
    if ok and mod and mod.get then
      return coroutine.create(mod.get)
    else
      return coroutine.create(function()
        error("Failed to load module '" .. entry .. "': " .. tostring(mod))
      end)
    end
  elseif type(entry) == "table" and entry.text then
    local hl = entry.hl and ("%#" .. entry.hl .. "#") or ""
    return coroutine.create(function()
      return hl .. entry.text
    end)
  end

  return coroutine.create(function() return "" end)
end


-- local function run_coroutines(module_names)
--   local results = {}
--   for i, entry in ipairs(module_names) do
--     local co = get_module_output(entry)
--     local ok, result = coroutine.resume(co)
--     if not ok then
--       result = "[error:" .. tostring(entry.name or i) .. "]"
--       vim.schedule(function()
--         vim.notify("fastline.nvim: error in module:\n" .. tostring(result), vim.log.levels.ERROR)
--       end)
--     end
--     table.insert(results, result or "")
--   end
--   return results
-- end


local function run_coroutines(module_names)
  local results = {}
  for i, entry in ipairs(module_names) do
    local co = get_module_output(entry)
    local ok, result = coroutine.resume(co)
    local label = type(entry) == "string" and entry or (entry.name or tostring(i))

    if not ok then
      local error_msg = string.format("[fastline: error in '%s']", label)
      table.insert(results, error_msg)
      vim.schedule(function()
        vim.notify("fastline.nvim: error in module '" .. label .. "'\n" .. tostring(result), vim.log.levels.ERROR)
      end)
    else
      table.insert(results, result or "")
    end
  end
  return results
end

local function render_section(modules)
  return table.concat(run_coroutines(modules), " ")
end

local function render()
  if not rendered_once then
    rendered_once = true
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "FastlineReady" })
    end)
  end

  local sections = config.get_sections()
  local left = render_section(sections.left or {})
  local center = render_section(sections.center or {})
  local right = render_section(sections.right or {})

  return table.concat({ "%#Normal#", left, "%=", center, "%=", right }, " ")
end

return {
  render = render,
}
