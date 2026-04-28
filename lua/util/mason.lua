local M = {}

M.registry = nil

local added_packages = {}

function M._ensure_mason()
  if M.registry ~= nil then
    return
  end
  require 'util.pack' {
    'github:mason-org/mason.nvim',
  }
  require('mason').setup()
  M.registry = require('mason-registry')
end

--- Setup mason
function M.setup(...)
  M._ensure_mason()
  return require('mason').setup(...)
end

local function install(name, opts, callback)
  M.registry.refresh(function()
    local pack = M.registry.get_package(name)
    pack:install(opts, callback)
  end)
end

--- Add a package
---
--- @param name string Name of the package
--- @param opts table|nil Options to pass into `package:install()`
--- @param callback function|nil Function to run once package is installed
function M.add(name, opts, callback)
  M._ensure_mason()
  opts = opts or {}

  table.insert(added_packages, name)

  local wrong_version = (
    opts.version
    and M.registry.get_package(name):get_installed_version() ~= opts.version
  )

  if not M.registry.is_installed(name) or wrong_version then
    install(name, opts, callback)
  elseif callback then
    callback()
  end
end

--- Get added packages
---
--- @return table
function M.get_added()
  return vim.deepcopy(added_packages)
end

--- Remove unused packages
function M.clean()
  M._ensure_mason()
  for name in vim.iter(M.registry.get_installed_package_names()) do
    if not vim.list_contains(added_packages, name) then
      M.registry.get_package(name):uninstall()
    end
  end
end

return M
