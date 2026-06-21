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

local restart_session_file = vim.fs.joinpath(
  vim.fn.stdpath('cache') --[[@as string]],
  'session-' .. pid .. '.tmp.vim'
)

on('VimLeave', {}, function()
  local session_file
  if vim.v.exitreason == 'restart' then
    session_file = restart_session_file
  else
    -- When exiting normally, save the current session for easy restore
    session_file = vim.fs.joinpath(
      vim.fn.stdpath('state') --[[@as string]],
      'session-last.vim'
    )
  end
  vim.cmd.mksession { session_file, bang = true }
end)

on('UIEnter', { once = true }, function()
  if vim.v.startreason == 'restart' then
    vim.cmd.source { restart_session_file }
  end
  vim.fs.rm(restart_session_file, { force = true })
end)
