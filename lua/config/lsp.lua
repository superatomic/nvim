-- -------------------------------- --
-- Global configuration for clients --
-- -------------------------------- --

vim.lsp.config('*', {
  exit_timeout = 100,
})

-- ----------------------------------------------------- --
-- Install Mason packages for servers and enable clients --
-- ----------------------------------------------------- --

local mason = require('util.mason')

local function in_config(file)
  return vim.fs.relpath(vim.fn.stdpath('config') --[[@as string]], file) ~= nil
end

-- Handle LSP spec files
for file in vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
  local lsp_name = file:match('[^/]*.lua$'):gsub('.lua$', '')
  local success, spec = pcall(function()
    return vim.lsp.config[lsp_name]
  end)

  -- Skip if disabled or invalid
  if
    not success
    or not spec
    or spec.enabled == false
    or (spec.enabled == nil and not in_config(file))
  then
    goto continue
  end

  local package_name, version, dependencies
  if type(spec.mason) == 'table' then
    package_name = spec.mason[1]
    version = spec.mason.version
    dependencies = spec.mason.dependencies
  else
    package_name = spec.mason
    version = nil
    dependencies = nil
  end

  -- Install via Mason if needed, then enable the LSP
  if package_name then
    mason.add(
      package_name,
      { version = version },
      vim.schedule_wrap(function() vim.lsp.enable(lsp_name) end)
    )
  else
    vim.lsp.enable(lsp_name)
  end

  -- Install dependencies for spec via Mason
  for dependency_name in vim.iter(dependencies or {}) do
    mason.add(dependency_name)
  end

  ::continue::
end
