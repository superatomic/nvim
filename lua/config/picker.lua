local map = require('util.map')

-- Buffer picker
map.leader_map('n', 'b', function()
  local bufs = vim.iter(vim.api.nvim_list_bufs())
    :filter(function(buf)
      return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
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
