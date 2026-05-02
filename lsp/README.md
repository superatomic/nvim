LSP configurations adapted from <https://github.com/neovim/nvim-lspconfig>.

In addition to the standard `vim.lsp.Config` fields, these configurations
support two additional fields, implemented by `plugin/lsp.lua`. These are:

- `mason`: Details about the mason package that should be installed to use the
  language server. Can be a string (the name of the mason package) or a table
  containing the following fields:
  - `[1]`: The name of the mason package.
  - `version`: The version of the mason package.
  - `dependencies`: Non-language server mason packages that should be installed
    in addition to the language server.
- `enabled`: Whether to automatically enable the LSP. Defaults to true for
  configurations which exist in `vim.fn.stdpath('config')`, false otherwise.
  Also skips installing via mason if disabled.
