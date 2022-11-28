vim.opt.termguicolors = true
vim.opt.background = "dark"

local is_avail, transparent = pcall(require, "transparent")
if is_avail then
  transparent.setup({
    enable = false,
    extra_groups = {
      "NormalFloat",
      "FloatBorder",
      "WinBar",
      "WinBarNC",
      "CursorLine",
      "GitGutterAdd",
      "GitGutterChange",
      "GitGutterDelete",
      "DiffLine",
      "CmpItemAbbr",
      "StatusLine",
      "StatusLineNC",
      "StatusLineImp",
      "StatusLineInd",
      "StatusLineDiagnosticError",
      "StatusLineDiagnosticWarn",
      "StatusLineDiagnosticHint",
      "StatusLineDiagnosticInfo",
    },
  })
end

local augroup = vim.api.nvim_create_augroup("_color", { clear = true })
local function hl_override(colorscheme, custom_hl)
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    pattern = colorscheme,
    callback = function()
      for _, def in ipairs(custom_hl) do
        def[2].default = false
        vim.api.nvim_set_hl(0, def[1], def[2])
      end
    end,
  })
end

local function try_colorscheme(colorscheme)
  local is_defined, custom_hl = pcall(require, "color.custom." .. colorscheme)
  if is_defined then
    hl_override(colorscheme, custom_hl)
  end
  if not pcall(vim.cmd, "colorscheme " .. colorscheme) then
    vim.cmd([[
      set bg=dark scl=no ls=0 nonu nornu nocul
      colorscheme quiet
      hi Normal guibg=NONE
      hi NormalFloat guibg=NONE
      hi FloatBorder guibg=NONE guifg=NONE
    ]])
  end
end

try_colorscheme("base16-tokyo-night-terminal-dark")
