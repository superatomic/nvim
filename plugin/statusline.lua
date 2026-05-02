-- ------------------------ --
-- Functions for Statusline --
-- ------------------------ --

function vim.g.stl_quickfix()
  ---@diagnostic disable-next-line: undefined-field
  return vim.w.quickfix_title or ''
end

function vim.g.stl_git()
  local success, statusline = pcall(vim.fn.FugitiveStatusline)
  if success then
    return statusline:gsub('^%[Git(.*)%]$', '%1')
  else
    return ''
  end
end

function vim.g.stl_busy()
  if vim.bo.busy ~= 0 then
    return '(busy)'
  else
    return ''
  end
end

function vim.g.stl_lsp()
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  local lsp_names = vim.tbl_map(function(client) return client.name end, clients)
  return table.concat(lsp_names, ',')
end

function vim.g.stl_indent()
  if vim.list_contains({ 'terminal', 'quickfix' }, vim.bo.buftype) then
    return ''
  elseif vim.bo.expandtab then
    if vim.bo.shiftwidth ~= 0 then
      return 'Spa:' .. vim.bo.shiftwidth
    else
      return 'Spa:' .. vim.bo.tabstop
    end
  else
    return 'Tab:' .. vim.bo.tabstop
  end
end

function vim.g.stl_encoding()
  return vim.bo.fileencoding:gsub('^utf%-8$', '')
end

function vim.g.stl_file_format()
  return ({
    unix = '', -- Display nothing
    dos = 'CRLF',
    mac = 'CR',
  })[vim.bo.fileformat]
end

-- -------------------- --
-- Construct Statusline --
-- -------------------- --

local diagnostics = table.concat {
  "%{% luaeval('",
    "(",
      "package.loaded[''vim.diagnostic''] ",
      "and #vim.diagnostic.count() ~= 0 ",
      "and vim.diagnostic.status() .. '' ''",
    ") or '''' ",
  "')%}",
}

vim.o.statusline = table.concat {
  -- Left side
  '%(%h%w %)',
  '%<%f',
  '%( %{stl_quickfix()}%)',
  '%( %m%r%)',
  '%( %{stl_git()}%)',

  -- Begin right side
  '%= ',

  -- Buffer info
  '%(%{stl_busy()} %)',
  diagnostics,
  '%(%{stl_lsp()} %)',
  '%(%y %)',
  '%(%{stl_encoding()} %)',
  '%(%{stl_file_format()} %)',
  '%(%{stl_indent()} %)',

  -- Position in file
  '%7.(%l:%c%) ',
  '%P',
}

-- ------------ --
-- Autocommands --
-- ------------ --

local statusline_group = vim.api.nvim_create_augroup('config.statusline', {})

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach' }, {
  group = statusline_group,
  callback = vim.schedule_wrap(function()
    vim.cmd.redrawstatus()
  end),
})

-- ------- --
-- Options --
-- ------- --

-- Use global statusline
vim.o.laststatus = 3

vim.g.qf_disable_statusline = true
