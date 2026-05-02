-- Kitty autocommand setup
if vim.env.TERM == 'xterm-kitty' then
  local kitty_group = vim.api.nvim_create_augroup('config.kitty', {})

  -- Set terminal background color to nvim's background color
  local function set_term_bg()
    local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if normal_hl.bg ~= nil then
      local bg_hex = string.format('#%06x', normal_hl.bg)
      vim.api.nvim_ui_send('\x1b]21;background=' .. bg_hex .. '\007')
    end
  end

  vim.api.nvim_create_autocmd({ 'VimEnter', 'VimResume' }, {
    group = kitty_group,
    callback = function()
      -- Set terminal background color
      vim.api.nvim_ui_send('\x1b]30001\007') -- Push unmodified colors onto stack
      set_term_bg()

      -- Set variable `in_nvim=1` when inside neovim.
      -- See <https://sw.kovidgoyal.net/kitty/mapping/>.
      vim.api.nvim_ui_send('\x1b]1337;SetUserVar=in_nvim=MQo\007')
    end,
  })

  vim.api.nvim_create_autocmd({ 'VimLeave', 'VimSuspend' }, {
    group = kitty_group,
    callback = function()
      vim.api.nvim_ui_send('\x1b]1337;SetUserVar=in_nvim\007')
      vim.api.nvim_ui_send('\x1b]30101\007') -- Pop colors from stack
    end,
  })

  vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
    group = kitty_group,
    callback = set_term_bg,
  })
end

-- Clipboard nonsense to avoid using wl-paste
--
-- See <https://gist.github.com/superatomic/32e1962df19541877854bb0ca8276e03>
-- for `seamless-clipboard.py` source code and explanation.
if vim.env.KITTY_LISTEN_ON then
  vim.g.clipboard = {
    name = 'kitty',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = { 'kitty', '@', 'kitten', 'seamless-clipboard.py' },
      ['*'] = { 'kitty', '@', 'kitten', 'seamless-clipboard.py' },
    },
    cache_enabled = 1,
  }
end
