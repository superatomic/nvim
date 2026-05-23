local M = {}

M.registry = nil

local added_packages = {}

local config = {
  ui = {
    check_outdated_packages_on_open = true,
    icons = {
      package_installed = '\u{2713}',
      package_pending = '\u{279c}',
      package_uninstalled = '\u{2717}',
    },
  },
}

function M.ensure_mason()
  if M.registry ~= nil then
    return
  end
  require 'util.pack' {
    'github:mason-org/mason.nvim',
  }
  require('mason').setup(config)
  M.registry = require('mason-registry')
end

local function install(name, opts, callback)
  M.registry.refresh(function()
    local pack = M.registry.get_package(name)
    pack:install(opts, callback)
  end)
end

--- Add a package
--- @param package string
--- @param callback? function
local function add_one(package, callback)
  local name, version = unpack(vim.split(package, '@'))

  table.insert(added_packages, name)

  local wrong_version = (
    version
    and M.registry.get_package(name):get_installed_version() ~= version
  )

  if not M.registry.is_installed(name) or wrong_version then
    install(name, { version = version }, callback)
  elseif callback then
    callback()
  end
end

--- Add a package
---
--- @param packages string|string[] Package name or list of package names
--- @param callback? function Function to run once packages are installed
function M.add(packages, callback)
  M.ensure_mason()
  if type(packages) == 'string' then
    add_one(packages, callback)
  else
    -- Run callback only after all packages have been installed
    local installed = 0
    local wrapper_callback = function()
      installed = installed + 1
      if installed == #packages and callback then
        callback()
      end
    end

    for package in vim.iter(packages) do
      add_one(package, wrapper_callback)
    end
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
  M.ensure_mason()
  for name in vim.iter(M.registry.get_installed_package_names()) do
    if not vim.list_contains(added_packages, name) then
      M.registry.get_package(name):uninstall()
    end
  end
end

return M
