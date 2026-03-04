---@type vim.lsp.Config
return {
  mason = {
    'lua-language-server',
    version = '3.5.6', -- see <github.com/LuaLS/lua-language-server/issues/2961>
  },
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  exit_timeout = true,
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config')
          and (
          vim.uv.fs_stat(path .. '/.luarc.json')
              or vim.uv.fs_stat(path .. '/.luarc.jsonc')
          ) then
        return
      end
    end
    local additional_settings = {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      },
    }
    client.config.settings.Lua = vim.tbl_deep_extend(
      'force',
      client.config.settings.Lua,
      additional_settings
    )
  end,
  settings = {
    Lua = {},
  },
}
