-- Originally written by elianiva
-- https://elianiva.my.id/post/neovim-lua-statusline/#result

local fn = vim.fn
local api = vim.api

local M = {}

M.trunc_width = setmetatable({
  git_status = 100,
  filetype = 100,
  filepath = 100,
}, {
  __index = function()
    return 130
  end,
})

---@param width number Width to match against
---@param is_statusglobal boolean | nil If true(i.e 'laststatus' is set to 3) then width is matched against
--all the windows' width combined, else width of the current window
function M.is_truncated(_, width, is_statusglobal)
  width = width or M.trunc_width.default
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
  local _, dircount = filepath:gsub("/", "")

  if filepath == "" or filepath == "." then
    return " "
  elseif self:is_truncated(self.trunc_width.filepath, true) or dircount > 7 then
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
  if not is_icons_available then
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
        "(#%s)[+%s ~%s -%s]",
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

function M.get_attached_sources()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local null_sources = package.loaded["null-ls"] and require("null-ls.sources").get_available(vim.bo.filetype) or {}

  local active, index = {}, nil
  for i = 1, #clients do
    if clients[i].name == "null-ls" then
      index = i
    end
    active[i] = clients[i].name
  end
  for i = 1, #null_sources do
    active[#clients + i] = null_sources[i].name
  end

  if index ~= nil then
    active[#active], active[index] = active[index], active[#active]
    active[#active] = nil
  end
  local attched = table.concat(active, ", ")
  return (#attched == 0 or M:is_truncated()) and "" or string.format(" 󰴽 { %s } ", attched)
end

function M.get_lsp_diagnostic()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }
  local signs = require("plugin.lsp.ui").signs
  local icons = {
    errors = signs.Error,
    warnings = signs.Warn,
    info = signs.Info,
    hints = signs.Hint,
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#StatusLineDiagnosticError#" .. icons["errors"] .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#StatusLineDiagnosticWarn#" .. icons["warnings"] .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#StatusLineDiagnosticHint#" .. icons["hints"] .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#StatusLineDiagnosticInfo#" .. icons["info"] .. count["info"]
  end

  return M:is_truncated(M.trunc_width.filepath) and "" or errors .. warnings .. hints .. info .. "%#StatusLineNC#"
end
-- 2}}}

-- Treesitter {{{2
function M.treesitter_status()
  local buf = api.nvim_get_current_buf()
  local hl = require("vim.treesitter.highlighter")
  return hl.active[buf] and "   " or ""
end
-- 2}}}

-- Grapple {{{2
function M.grapple_tags()
  local cwd = string.match(vim.loop.cwd(), "/([%w]+)$")
  local grapple_data = vim.fn.stdpath("data") .. "/grapple"
  for file in io.popen(string.format("ls -pa %s | grep -v /", grapple_data)):lines() do
    if string.match(file, cwd) then
      return require("grapple").exists() and " " .. require("grapple").key() .. " " or ""
    end
  end
  return ""
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
    -- self.lsp_progress(),
    "%#StatusLineInd#",
    self:grapple_tags(),
    "%#StatusLine#",
    self:get_filetype(),
    self.get_attached_sources(),
    "%#StatusLineInd#",
    self.treesitter_status(),
    "%#StatusLine#",
    -- self.get_fileformat(),
    self.get_line_col(),
    "%#StatusLine#",
  })
end

function M.set_inactive()
  return "%#StatusLineNC#"
end

function M.set_explorer()
  return "%#StatusLineNC#" .. "%= %F %="
end
-- 1}}}

function M.setup()
  Statusline = setmetatable(M, {
    __call = function(self, mode)
      return self["set_" .. mode](self)
    end,
  })
  local au = vim.api.nvim_create_autocmd
  local augroup = api.nvim_create_augroup("_ext", { clear = true })
  au({ "WinEnter", "BufEnter" }, {
    group = augroup,
    pattern = "*",
    command = "setlocal statusline=%!v:lua.Statusline('active')",
  })
  au({ "WinLeave", "BufLeave" }, {
    group = augroup,
    pattern = "*",
    command = "setlocal statusline=%!v:lua.Statusline('inactive')",
  })
  au("FileType", {
    group = augroup,
    pattern = "netrw",
    command = "setlocal statusline=%!v:lua.Statusline('explorer')",
  })
end

return M.setup()
