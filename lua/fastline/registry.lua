local modules = {}

function modules.register(name, mod)
  modules[name] = mod
end

function modules.get(name)
  return modules[name]
end

-- Register built-ins
modules.register("mode", require("fastline.modules.mode"))
modules.register("filename", require("fastline.modules.filename"))
modules.register("git", require("fastline.modules.git"))
modules.register("gitinfo", require("fastline.modules.gitinfo"))
modules.register("startup", require("fastline.modules.startup"))
modules.register("lsp", require("fastline.modules.lsp"))

return modules
