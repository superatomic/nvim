local host_prefixes = {
  github = 'https://github.com/',
  gitlab = 'https://gitlab.com/',
  codeberg = 'https://codeberg.org/',
  nvim = 'https://github.com/neovim/nvim-',
  mini = 'https://github.com/nvim-mini/mini.',
}

local function expand_host(name)
  for short, long in pairs(host_prefixes) do
    if vim.startswith(name, short .. ':') then
      return (name:gsub('^' .. short .. ':', long))
    end
  end
  return name
end

--- Add plugin to current session
---
--- Simple wrapper around |vim.pack.add()|.
--- @param spec string|table
return function(spec)
  vim.validate('spec', spec, { 'string', 'table' })
  if type(spec) == 'string' then
    spec = expand_host(spec)
  elseif type(spec) == 'table' and spec.src == nil then
    spec = vim.deepcopy(spec)
    spec.src = expand_host(spec[1])
    spec[1] = nil
  end
  vim.pack.add({ spec }, { confirm = false })
end
