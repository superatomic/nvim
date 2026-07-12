-- Fugitive
pack { 'github:tpope/vim-fugitive', name = 'fugitive.vim' }

-- Gitsigns
pack 'github:lewis6991/gitsigns.nvim'
pack 'github:purarue/gitsigns-yadm.nvim'

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

    local bmap = map[bufnr]

    -- Stage
    bmap('n', '<Leader>ga', gitsigns.stage_hunk, 'Stage/Unstage')
    bmap('x', '<Leader>ga', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Stage/Unstage')
    bmap('n', '<Leader>gA', gitsigns.stage_buffer, 'Stage/Unstage All')

    -- Reset
    bmap('n', '<Leader>gr', gitsigns.reset_hunk, 'Reset')
    bmap('x', '<Leader>gr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Reset')
    bmap('n', '<Leader>gR', gitsigns.reset_buffer, 'Reset All')
  end,
}
