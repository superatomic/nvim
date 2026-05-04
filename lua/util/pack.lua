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
--- @param specs (string|table)[]
return function(specs)
  specs = vim.iter(specs):map(function(spec)
    if type(spec) == 'string' then
      spec = expand_host(spec)
    elseif type(spec) == 'table' and spec.src == nil then
      spec = vim.deepcopy(spec)
      spec.src = expand_host(spec[1])
      spec[1] = nil
    end
    return spec
  end):totable()
  vim.pack.add(specs, { confirm = false })
end
