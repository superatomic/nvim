-- ------------- --
-- Buffer Picker --
-- ------------- --

map('n', '<Leader>b', function()
  local bufs = vim.iter(vim.api.nvim_list_bufs())
    :filter(function(buf)
      return vim.bo[buf].buflisted and vim.bo[buf].buftype ~= 'quickfix'
    end)
    :totable()
  if #bufs < 2 then
    vim.notify('No other listed buffers', vim.log.levels.WARN)
    return
  end
  vim.ui.select(
    bufs,
    {
      prompt = 'Switch buffer to:',
      format_item = function(item)
        local path = vim.api.nvim_buf_get_name(item)
        return path == '' and '[No Name]' or vim.fn.fnamemodify(path, ':~:.')
      end,
    },
    function(item)
      vim.cmd.buffer { item }
    end
  )
end, 'Buffers')

-- ---------- --
-- 'findfunc' --
-- ---------- --

local found_files = nil
on('CmdlineEnter', {}, function() found_files = nil end)

--- @param arg string the |:find| command argument
function vim.o.findfunc(arg)
  if not found_files then
    found_files = {}
    for name, type in
      vim.fs.dir('.', {
        depth = math.huge,
        skip = function(name) return name ~= '.git' end,
      })
    do
      local _, code = vim.wait(0, nil, 0)
      if code == -2 then -- ^C
        found_files = nil
        return {}
      end
      if type ~= 'directory' then
        found_files[#found_files + 1] = name
      end
    end
  end
  return arg == '' and found_files or vim.fn.matchfuzzy(found_files, arg)
end
