vim.opt.termguicolors = true
vim.opt.background = "dark"

local function hl_override(colorscheme, custom_hl)
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("_hlOverride", { clear = true }),
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
  if not pcall(vim.api.nvim_exec, "colorscheme " .. colorscheme, false) then
    vim.api.nvim_exec("colorscheme default", false)
  end
end

try_colorscheme("base16-tokyo-night-terminal-dark")
