local fn = vim.fn
local api = vim.api

local M = {}

M.trunc_width = setmetatable({
  git_status = 100,
  filetype = 100,
  filepath = 100,
}, {
  __index = function()
    return 80
  end,
})

function M.is_truncated(_, width, is_statusglobal)
  is_statusglobal = is_statusglobal or true
  local current_width = require("core.util").get_width({ combined = is_statusglobal })
  return current_width < width
end

-- Components {{{1
-- Mode {{{2
M.modes = setmetatable({
  ["n"] = "%#VimModeNormal# N %#StatusLine#",
  ["i"] = "%#VimModeInsert# I %#StatusLine#",
  ["v"] = "%#VimModeVisual# V %#StatusLine#",
  ["V"] = "%#VimModeVisual# V·L %#StatusLine#",
  [""] = "%#VimModeVisual# V·B %#StatusLine#",
  ["c"] = "%#VimModeCommand# C %#StatusLine#",
  ["t"] = "%#VimModeExtra# T %#StatusLine#",
  ["no"] = "N·P",
  ["s"] = "S",
  ["S"] = "S·L",
  [""] = "S·B",
  ["ic"] = "I",
  ["R"] = "R",
  ["Rv"] = "V·R",
  ["cv"] = "V·E",
  ["ce"] = "E",
  ["r"] = "P",
  ["rm"] = "RM",
  ["r?"] = "C",
  ["!"] = "S",
}, {
  __index = function()
    return "%#VimModeExtra# U %#StatusLine#" -- handle edge cases
  end,
})

function M:get_current_mode()
  local current_mode = api.nvim_get_mode().mode
  return string.format("%s", self.modes[current_mode]):upper()
end
-- 2}}}

-- FileInfo {{{2
function M:get_filepath()
  local filepath = fn.fnamemodify(fn.expand("%"), ":.:h")

  if filepath == "" or filepath == "." then
    return " "
  elseif self:is_truncated(self.trunc_width.filepath, false) then
    return string.format(" %s/", fn.pathshorten(filepath, 2))
  end

  return string.format(" %%<%s/", filepath)
end

function M.get_filename()
  local filename = fn.expand("%:t")
  return filename == "" and "" or filename .. " "
end

function M:get_filetype()
  local filetype = vim.bo.filetype
  local is_icons_available, icons = pcall(require, "nvim-web-devicons")
  if self:is_truncated(self.trunc_width.filetype) then
    return ""
  elseif not is_icons_available then
    return filetype == "" and " No FT " or string.format(" ft: %s ", filetype):lower()
  end
  local ft_icon = icons.get_icon_by_filetype(filetype)
  return filetype == "" and " No FT " or string.format(" %s %s ", ft_icon, filetype):lower()
end

function M.get_filesize()
  local wc = fn.wordcount()
  local size = math.floor(wc.bytes * 0.000977)
  return string.format(" %s Kb ", size)
end

function M.get_fileformat()
  return string.format(" %s ", vim.o.fileformat):lower()
end

function M.get_line_col()
  return " %l:%c "
end
-- 2}}}

-- GitInfo {{{2
function M:get_git_status()
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
-- 2}}}

-- LSP {{{2
function M.lsp_progress()
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

function M.get_lsp_diagnostic()
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
    errors = " %#StatusLineDiagnosticError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#StatusLineDiagnosticWarn# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#StatusLineDiagnosticHint# " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#StatusLineDiagnosticInfo# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#StatusLineNC#"
end
-- 2}}}

-- Treesitter {{{2
function M.treesitter_status()
  local buf = api.nvim_get_current_buf()
  local hl = require("vim.treesitter.highlighter")
  return hl.active[buf] and "   " or ""
end
-- 2}}}
-- 1}}}

-- Modes {{{1
function M.set_active(self)
  return table.concat({
    "%#StatusLine#",
    self:get_current_mode(),
    "%#StatusLineImp#",
    self:get_filepath(),
    self.get_filename(),
    "%#StatusLine#",
    self:get_git_status(),
    self.get_lsp_diagnostic(),
    "%=",
    "%#StatusLine#",
    self.lsp_progress(),
    self:get_filetype(),
    "%#StatusLineInd#",
    self.treesitter_status(),
    "%#StatusLine#",
    self.get_fileformat(),
    self.get_line_col(),
    "%#StatusLine#",
  })
end

function M.set_inactive()
  return "%#StatusLineNC#" .. "%= %F %="
end

function M.set_explorer()
  return "%#StatusLineNC#"
end
-- 1}}}

function M.setup()
  Statusline = setmetatable(M, {
    __call = function(self, mode)
      return self["set_" .. mode](self)
    end,
  })

  local mode_listen = {
    { "active", { "WinEnter", "BufEnter" } },
    { "inactive", { "WinLeave", "BufLeave" } },
    { "explorer", { "netrw" } },
  }

  for _, v in pairs(mode_listen) do
    local mode = v[1]
    local event = v[2]
    local pattern = "*"
    if mode == "explorer" then
      pattern = event[2]
      event = { "FileType" }
    end

    local augroup = api.nvim_create_augroup("_ext", { clear = false })
    api.nvim_create_autocmd(event, {
      group = augroup,
      pattern = pattern,
      command = string.format("setlocal statusline=%%!v:lua.Statusline('%s')", mode),
    })
  end
end

return M.setup()
