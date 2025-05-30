local api = vim.api
local redraw = require("fastline.redraw")

local M = {}

local alias = { "Head", "Add", "Change", "Delete" }
local order = { "head", "added", "changed", "removed" }
local signs = { "Git:", "+", "~", "-" }

-- Setup highlights once per session
local function setup_git_highlight()
  for i = 2, 4 do
    local ok, color = pcall(api.nvim_get_hl, 0, { name = "Diff" .. alias[i] })
    if ok and color and color.bg then
      api.nvim_set_hl(0, "FastlineGit" .. alias[i], { fg = color.bg })
    end
  end
end

local function fetch_default_branch(callback)
  vim.system({ "git", "config", "--get", "init.defaultBranch" }, { text = true }, function(result)
    callback(vim.trim(result.stdout))
  end)
end

function M.get()
  setup_git_highlight()

  return coroutine.create(function()
    local ok, dict = pcall(api.nvim_buf_get_var, 0, "gitsigns_status_dict")
    if not ok or vim.tbl_isempty(dict) then
      return ""
    end

    -- Fill in default branch name if missing
    if dict["head"] == "" then
      local co = coroutine.running()
      fetch_default_branch(function(branch)
        coroutine.resume(co, branch or "main")
      end)
      dict["head"] = coroutine.yield()
    end

    local parts = {}
    for i = 1, 4 do
      local value = dict[order[i]]
      if i == 1 or (type(value) == "number" and value > 0) then
        local hl = "%#FastlineGit" .. alias[i] .. "#"
        local seg = ("%s%s"):format(signs[i], value)
        table.insert(parts, hl .. seg .. "%*")
      end
    end

    return table.concat(parts, " ")
  end)
end

return M
