--- Abstraction around [nvim_create_autocmd()]
--- @param events vim.api.keyset.events|vim.api.keyset.events[]
--- @param opts vim.api.keyset.create_autocmd
--- @param fn string|fun(ev: vim.api.keyset.create_autocmd.callback_args): boolean?
--- @param desc? string
--- @return integer
return function(events, opts, fn, desc)
  vim.validate('opts', opts, 'table')
  vim.validate('fn', fn, { 'function', 'string' })
  vim.validate('desc', desc, 'string', true)
  if type(fn) == 'function' then
    opts.callback = fn
  else
    opts.command = fn
  end
  if type(opts.group) == 'string' then
    opts.group = vim.api.nvim_create_augroup(
      opts.group --[[@as string]],
      { clear = false }
    )
  end
  opts.desc = desc
  return vim.api.nvim_create_autocmd(events, opts)
end
