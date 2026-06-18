-- Seamless :restart
local first_ui = vim.api.nvim_list_uis()[1]
local pid = vim.api.nvim_get_chan_info(first_ui.chan).client.attributes.pid
if not pid then
  vim.notify(
    'UI does not support seamless :restart: No provided pid',
    vim.log.levels.WARN
  )
  return
end

local session_file = vim.fs.joinpath(
  vim.fn.stdpath('cache') --[[@as string]],
  'session-' .. pid .. '.tmp.vim'
)

on('VimLeave', {}, function()
  if vim.v.exitreason == 'restart' then
    vim.cmd.mksession { session_file, bang = true }
  end
end)

on('UIEnter', { once = true }, function()
  if vim.v.startreason == 'restart' then
    vim.cmd.source { session_file }
  end
  vim.fs.rm(session_file, { force = true })
end)
