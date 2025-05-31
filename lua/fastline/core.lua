local config = require("fastline.config")
local registry = require("fastline.registry")

local rendered_once = false

-- Detect and return a function that will eventually return a string (or coroutine)
local function get_module_output(entry)
    if type(entry) == "string" then
        -- Vim expression or literal spacing
        if entry:match("^%%{.*}$") or entry:match("^%s+$") then
            return function() return entry end
        end

        local mod = registry.get(entry)
        if mod and type(mod.get) == "function" then
            return mod.get
        else
            return function()
                error("Module '" .. entry .. "' could not be found or is invalid.")
            end
        end

    elseif type(entry) == "table" and entry.text then
        local hl = entry.hl and ("%#" .. entry.hl .. "#") or ""
        return function()
            return hl .. entry.text .. "%*"
        end
    end

    return function()
        return ""
    end
end

-- Handles execution of coroutines or plain providers
local function run_coroutines(module_entries)
    local results = {}

    for i, entry in ipairs(module_entries) do
        local provider = get_module_output(entry)
        local ok, value = pcall(provider)
        local label = type(entry) == "string" and entry or ("entry[" .. i .. "]")

        if not ok then
            value = "[fastline: error in '" .. label .. "']"
            vim.schedule(function()
                vim.notify("fastline.nvim: error in module '" .. label .. "':\n" .. tostring(value), vim.log.levels.ERROR)
            end)
        elseif type(value) == "thread" then
            local ok_thread, result = coroutine.resume(value, results, i)
            if not ok_thread then
                result = "[fastline: coroutine error in '" .. label .. "']"
                vim.schedule(function()
                    vim.notify("fastline.nvim: coroutine error in '" .. label .. "':\n" .. tostring(result), vim.log.levels.ERROR)
                end)
            end
            table.insert(results, result or "")
        else
            table.insert(results, value or "")
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
    local left   = render_section(sections.left or {})
    local center = render_section(sections.center or {})
    local right  = render_section(sections.right or {})

    return table.concat({
        "%#Normal#", left, "%=", center, "%=", right
    }, " ")
end

return {
    render = render,
}

