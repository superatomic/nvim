-- ------------------- --
-- Trailing Whitespace --
-- ------------------- --

on('BufWritePre', { group = 'config.trim_whitespace' }, function()
  if (vim.b.editorconfig or {}).trim_trailing_whitespace ~= 'false' then
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[keeppatterns %s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, pos)
  end
end)

--- Mask the EditorConfig plugin's `trim_trailing_whitespace` handling.
--- @diagnostic disable-next-line: duplicate-set-field
require('editorconfig').properties.trim_trailing_whitespace = function() end
