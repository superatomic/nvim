--- Tries to load the given module, otherwise notify user and continue.
---
--- @param modname string
return function(modname)
  local success, result = pcall(require, modname)
  if success then
    return result
  else
    vim.notify(result, vim.log.levels.ERROR)
  end
end
