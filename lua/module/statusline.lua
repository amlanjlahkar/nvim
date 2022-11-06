local fn = vim.fn
local api = vim.api

local M = {}

M.trunc_width = setmetatable({
  git_status = 90,
  filetype = 90,
  filename = 140,
}, {
  __index = function()
    return 80
  end,
})

M.is_truncated = function(_, width)
  local current_width = require("util").get_width({ global = true })
  return current_width < width
end

M.modes = setmetatable({
  ["n"] = "%#VimModeNormal# N %#StatusLine#",
  ["no"] = "N·P",
  ["v"] = "%#VimModeVisual# V %#StatusLine#",
  ["V"] = "%#VimModeVisual# V·L %#StatusLine#",
  [""] = "%#VimModeVisual# V·B %#StatusLine#",
  ["s"] = "S",
  ["S"] = "S·L",
  [""] = "S·B",
  ["i"] = "%#VimModeInsert# I %#StatusLine#",
  ["ic"] = "I",
  ["R"] = "R",
  ["Rv"] = "V·R",
  ["c"] = "%#VimModeCommand# C %#StatusLine#",
  ["cv"] = "V·E",
  ["ce"] = "E",
  ["r"] = "P",
  ["rm"] = "RM",
  ["r?"] = "C",
  ["!"] = "S",
  ["t"] = "%#VimModeExtra# T %#StatusLine#",
}, {
  __index = function()
    return "%#VimModeExtra# U %#StatusLine#" -- handle edge cases
  end,
})

M.get_current_mode = function(self)
  local current_mode = api.nvim_get_mode().mode
  return string.format("%s", self.modes[current_mode]):upper()
end

-- Git info
M.get_git_status = function(self)
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
  local is_head_empty = signs.head ~= ""

  if self:is_truncated(self.trunc_width.git_status) then
    return is_head_empty and string.format(" #%s ", signs.head or "") or ""
  end

  -- stylua: ignore
  return is_head_empty
      and string.format(
        "(#%s) [+%s ~%s -%s]",
        signs.head,
        signs.added,
        signs.changed,
        signs.removed
      )
      or ""
end

-- File information
M.get_filepath = function(self)
  local filepath = fn.fnamemodify(fn.expand("%"), ":.:h")

  if filepath == "" or filepath == "." or self:is_truncated(self.trunc_width.filename) then
    return " "
  end

  return string.format(" %%<%s/", filepath)
end

M.get_filename = function()
  local filename = fn.expand("%:t")
  return filename == "" and "" or filename .. " "
end

M.get_filetype = function(self)
  local filetype = vim.bo.filetype
  local is_devicons_available, devicons = pcall(require, "nvim-web-devicons")
  if self:is_truncated(self.trunc_width.filetype) then
    return ""
  elseif not is_devicons_available then
    return filetype == "" and " No FT " or string.format(" ft: %s ", filetype):lower()
  end
  local ft_icon = devicons.get_icon_by_filetype(filetype)
  return filetype == "" and " No FT " or string.format(" %s %s ", ft_icon, filetype):lower()
end

M.get_filesize = function()
  local wc = fn.wordcount()
  local size = math.floor(wc.bytes * 0.000977)
  return string.format(" %s Kb ", size)
end

M.get_fileformat = function()
  return string.format(" %s ", vim.o.fileformat):lower()
end

M.get_line_col = function()
  return " %l:%c "
end

-- LSP progress, diagnostics and treesitter status
M.lsp_progress = function()
  local lsp = vim.lsp.util.get_progress_messages()[1]

  if lsp then
    local name = lsp.name or ""
    local msg = lsp.message or ""
    local percentage = lsp.percentage or 0
    local title = lsp.title or ""
    return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
  end

  return ""
end

M.get_lsp_diagnostic = function()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#StatusLineDiagnosticError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#StatusLineDiagnosticWarn# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#StatusLineDiagnosticHint# " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#StatusLineDiagnosticInfo# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#StatusLineNC#"
end

M.treesitter_status = function()
  local buf = api.nvim_get_current_buf()
  local hl = require("vim.treesitter.highlighter")
  return hl.active[buf] and "  " or ""
end

M.set_active = function(self)
  return table.concat {
    "%#StatusLine#",
    self:get_current_mode(),
    "%#StatusLineImp#",
    self:get_filepath(),
    self:get_filename(),
    "%#StatusLine#",
    self:get_git_status(),
    self:get_lsp_diagnostic(),
    "%=",
    "%#StatusLine#",
    self:lsp_progress(),
    self:get_filetype(),
    "%#StatusLineInd#",
    self:treesitter_status(),
    "%#StatusLine#",
    self:get_fileformat(),
    self:get_line_col(),
    "%#StatusLine#",
  }
end

M.set_inactive = function()
  return "%#StatusLineNC#" .. "%= %F %="
end

M.set_explorer = function()
  return "%#StatusLineNC#"
end

Statusline = setmetatable(M, {
  __call = function(self, mode)
    return self["set_" .. mode](self)
  end,
})

local augroup = api.nvim_create_augroup("StatusLine", { clear = true })
api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = augroup,
  pattern = "*",
  command = "setlocal statusline=%!v:lua.Statusline('active')",
})
api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = augroup,
  pattern = "*",
  command = "setlocal statusline=%!v:lua.Statusline('inactive')",
})
api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "netrw", "neotree" },
  command = "setlocal statusline=%!v:lua.Statusline('explorer')",
})
