on('VimLeave', {}, function()
  if vim.v.exitreason == 'normal' then
    -- When exiting normally, save the current session for easy restore
    local session_file = vim.fs.joinpath(
      vim.fn.stdpath('state') --[[@as string]],
      'session-last.vim'
    )
    vim.cmd.mksession { session_file, bang = true }
  end
end)
