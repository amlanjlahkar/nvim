local function hl_override(colorscheme, custom_hl)
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("_core.color", { clear = true }),
        pattern = colorscheme,
        callback = function()
            for _, def in ipairs(custom_hl) do
                def[2].default = false
                vim.api.nvim_set_hl(0, def[1], def[2])
            end
        end,
    })
end

local M = { default = "lunaperche", custom = "boo" }

function M:try_colorscheme(colorscheme)
    colorscheme = colorscheme or self.custom
    local is_defined, custom_hl = pcall(require, "color.custom." .. colorscheme)
    if is_defined then
        hl_override(colorscheme, custom_hl)
    end
    if not pcall(vim.cmd, "colorscheme " .. colorscheme) then
        vim.notify_once(
            string.format("Unable to load colorscheme %s. Reverting to %s", colorscheme, self.default),
            vim.log.levels.ERROR
        )
        vim.cmd.colorscheme(self.default)
        vim.cmd(
            [[ set bg=light scl=no ls=0 nonu nornu nocul noru | hi NormalFloat guibg=NONE | hi FloatBorder guibg=NONE ]]
        )
    end
end

return M
