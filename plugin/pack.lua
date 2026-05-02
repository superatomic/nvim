-- --------------------- --
-- Commands for vim.pack --
-- --------------------- --

local function complete_packages()
  return vim.iter(vim.pack.get())
    :map(function(pack) return pack.spec.name end)
    :totable()
end

vim.api.nvim_create_user_command(
  'PackUpdate',
  function(info)
    if #info.fargs ~= 0 then
      vim.pack.update(info.fargs, { force = info.bang })
    else
      vim.pack.update(nil, { force = info.bang })
    end
  end,
  {
    desc = 'Update packages',
    nargs = '*',
    bang = true,
    complete = complete_packages,
  }
)

vim.api.nvim_create_user_command(
  'PackDelete',
  function(info)
    vim.pack.del(info.fargs, { force = info.bang })
  end,
  {
    desc = 'Delete packages',
    nargs = '+',
    bang = true,
    complete = complete_packages,
  }
)

vim.api.nvim_create_user_command(
  'PackClean',
  function()
    local clean = vim.iter(vim.pack.get())
      :filter(function(pack) return not pack.active end)
      :map(function(pack) return pack.spec.name end)
      :totable()
    vim.pack.del(clean)
  end,
  { desc = 'Delete all inactive packages' }
)
