require 'util.pack' {
  -- Fugitive
  { 'github:tpope/vim-fugitive', name = 'fugitive.vim' },

  -- Gitsigns
  'github:lewis6991/gitsigns.nvim',
  'github:purarue/gitsigns-yadm.nvim',
  'github:nvim-lua/plenary.nvim',
}

require('gitsigns').setup {
  sign_priority = 100,
  numhl = true,
  _on_attach_pre = function(bufnr, callback)
    -- Only hook in gitsigns-yadm when working in an environment where
    -- vim's config directory is inside of HOME.
    local xdg_config = vim.fn.stdpath('config') --[[@as string]]
    if vim.fs.relpath(vim.env.HOME, xdg_config) then
      require('gitsigns-yadm').yadm_signs(callback, { bufnr = bufnr })
    end
  end,
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')
    local map = require('util.map')

    local git_map = map.leader_group('g', 'Git', { buffer = bufnr })

    -- Stage
    git_map('n', 'a', gitsigns.stage_hunk, 'Stage/Unstage')
    git_map('v', 'a', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Stage/Unstage')
    git_map('n', 'A', gitsigns.stage_buffer, 'Stage/Unstage All')

    -- Reset
    git_map('n', 'r', gitsigns.reset_hunk, 'Reset')
    git_map('v', 'r', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Reset')
    git_map('n', 'R', gitsigns.reset_buffer, 'Reset All')
  end,
}
