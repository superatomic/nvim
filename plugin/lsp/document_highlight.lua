--- Real-time Document Highlights

local clear_references = vim.lsp.buf.clear_references

local document_highlight_ns =
  vim.api.nvim_create_namespace('nvim.lsp.references')

local document_highlight_types =
  { 'identifier', 'field_identifier', 'type_identifier' }

--- @param pos? vim.Pos
--- @return boolean exists
local function extmark_exists_at_pos(pos)
  if pos == nil then
    pos = vim.pos.cursor()
  end
  local row, col = pos:to_extmark()

  local markers = vim.api.nvim_buf_get_extmarks(
    0,
    document_highlight_ns,
    { row, col },
    { row, col },
    { overlap = true, details = true }
  )
  return vim.iter(markers):find(function(m)
    return col ~= m[4].end_col -- Don't count positions directly after extmark
  end) ~= nil
end

--- Event (autocmd) callback to request document highlights
local function document_highlight()
  -- Stop early if cursor is on a document highlight group.
  if vim.fn.mode() ~= 'n' or extmark_exists_at_pos() then
    return
  end

  clear_references()

  local node = vim.treesitter.get_node()
  if node and vim.list_contains(document_highlight_types, node:type()) then
    -- Create an extmark immediately (but with no highlight group) so the LSP
    -- request is not sent repeatedly.
    local s_row, s_col, e_row, e_col = node:range()
    vim.api.nvim_buf_set_extmark(
      0,
      document_highlight_ns,
      s_row,
      s_col,
      { end_line = e_row, end_col = e_col }
    )

    vim.lsp.buf.document_highlight()
  end
end

local group = vim.api.nvim_create_augroup('config.references')

on('LspAttach', {}, function()
  on('SafeState', { buf = 0, group = group, once = true }, document_highlight)
  on('CursorMoved', { buf = 0, group = group }, document_highlight)
  on('TextChanged', { buf = 0, group = group }, function()
    clear_references()
    document_highlight()
  end)
  on('ModeChanged', { buf = 0, group = group }, function(ev)
    if ev.match:match(':n.*$') then
      document_highlight()
    elseif ev.match:match('^n.*:') then
      clear_references()
    end
  end)
end)

on('LspDetach', {}, function()
  vim.api.nvim_clear_autocmds({ buf = 0, group = group })
  clear_references()
end)

-- Override handler to filter out outdated document highlights.
vim.lsp.handlers['textDocument/documentHighlight'] = (function(orig)
  return function(err, result, ctx)
    local pos = vim.pos.cursor()
    if
      result
      and ctx.bufnr == vim.api.nvim_get_current_buf()
      and vim.fn.mode() == 'n'
      and extmark_exists_at_pos(pos)
      and vim.iter(result):find(function(ref)
        local ref_range = vim.range(
          0,
          ref.range['start'].line,
          ref.range['start'].character,
          ref.range['end'].line,
          ref.range['end'].character - 1
        )
        return ref_range:has(pos)
      end)
    then
      orig(err, result, ctx)
    end
  end
end)(vim.lsp.handlers['textDocument/documentHighlight'])
