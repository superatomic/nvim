-- Seamless :restart
vim.api.nvim_create_user_command(
  'Reload',
  function(info)
    -- Save temporary session file
    local session_file = vim.fs.joinpath(
      vim.fn.stdpath('cache') --[[@as string]],
      'session-' .. vim.fn.getpid() .. '.tmp.vim'
    )
    vim.cmd.mksession { session_file, bang = true }

    -- Modify session file to delete itself on load
    local file = io.open(session_file, 'a')
    if file then
      file:write('call delete(expand("<script>:p"))\n')
      file:close()
    end

    local confirm = info.mods:match('confirm') ~= nil
    local cmd = ({
      [false] = 'qall',
      [true] = 'qall!',
    })[info.bang]

    -- Restart server and restore session
    local success, result = pcall(
      vim.cmd.restart,
      { '+' .. cmd, 'so', session_file, mods = { confirm = confirm } }
    )
    if not success then
      vim.notify(result, vim.log.levels.ERROR)
    end

    -- Remove session file if restart failed or is cancelled
    vim.fs.rm(session_file)
  end,
  {
    bang = true,
    desc = 'Restart neovim while restoring workspace',
  }
)
