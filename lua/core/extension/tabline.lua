local fn = vim.fn

local M = {}

function M.tabline()
  local t = ""
  for index = 1, fn.tabpagenr("$") do
    local winnr = fn.tabpagewinnr(index)
    local buflist = fn.tabpagebuflist(index)
    local bufnr = buflist[winnr]
    local bufname = fn.bufname(bufnr)

    if index == fn.tabpagenr() then
      t = t .. "%#TabLineSel#"
    else
      t = t .. "%#TabLine#"
    end

    t = t .. string.format(" %s:", index)

    if bufname:match("^fugitive://%g+") then
      t = t .. "fugitive "
    elseif bufname:match("^term://%g+") then
      t = t .. "terminal "
    elseif bufname ~= "" then
      t = t .. string.format("%s ", fn.fnamemodify(bufname, ":t:r")):lower()
    else
      t = t .. string.format("%s ", vim.bo.filetype):lower()
    end
  end

  t = t .. "%#TabLineFill#"
  return t
end

function M.setup()
  function _G.set_tabline()
    return M.tabline()
  end
  vim.opt.tabline = "%!v:lua.set_tabline()"
end

return M.setup()
