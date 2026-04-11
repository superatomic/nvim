local map = require('util.map')

-- Buffer picker
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

-- File picker |fuzzy-file-picker|
vim.cmd([[
  set findfunc=Find
  func Find(arg, _)
    if empty(s:filescache)
      let s:filescache = globpath('.', '**', 1, 1)
      call filter(s:filescache, '!isdirectory(v:val)')
      call map(s:filescache, "fnamemodify(v:val, ':.')")
    endif
    return a:arg == '' ? s:filescache : matchfuzzy(s:filescache, a:arg)
  endfunc
  let s:filescache = []
  autocmd CmdlineEnter : let s:filescache = []
]])
