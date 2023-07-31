local fn = vim.fn

local M = {}

function M.buf_preview_maker(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    require("plenary.job")
        :new({
            command = "file",
            args = { "--mime-type", "-b", filepath },
            on_exit = function(j)
                local mime_type = vim.split(j:result()[1], "/")[1]
                if mime_type == "text" or mime_type == "application" then
                    require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
                else
                    vim.schedule(function()
                        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                    end)
                end
            end,
        })
        :sync()
end

function M.use_theme(picker_opts)
    local theme = "dropdown"
    local opts = {
        layout_config = {
            anchor = "N",
            width = 0.5,
            height = 0.5,
        },
    }
    if picker_opts then
        for k, v in pairs(picker_opts) do
            opts[k] = v
        end
    end
    return require("telescope.themes")["get_" .. theme](opts)
end

function M.pick(type)
    local t = setmetatable({}, {
        __index = function(_, picker)
            return function(use, opts)
                local picker_opts = use == false and opts or M.use_theme(opts)
                require(type)[picker](picker_opts)
            end
        end,
    })
    return t
end

local tb = M.pick("telescope.builtin")

function M.get_nvim_conf()
    local opts = {
        prompt_title = "Neovim Config",
        cwd = fn.stdpath("config"),
    }
    tb.find_files(_, opts)
end

function M.get_relative_file()
    local cwd = fn.expand("%:p:h")
    local sp_buf = { "oil", "fugitive", "term" }
    for _, b in pairs(sp_buf) do
        local _, i = string.find(cwd, string.format("^%s://%%g+", b))
        if i then
            cwd = string.sub(cwd, i + 1)
            break
        end
    end
    local opts = {
        prompt_title = "Relative Files",
        cwd = cwd,
        preview = true,
        no_ignore = true,
    }
    tb.find_files(_, opts)
end

function M.get_dwots()
    local dothome = fn.finddir("~/dwots/")
    local opts = {
        prompt_title = "Dotfiles",
        cwd = dothome,
        find_command = { "fd", "--hidden", "--exclude", ".git", "--type", "file" },
    }
    if dothome == "" then
        vim.notify("Direcetory dwots not found!", vim.log.levels.ERROR)
    else
        tb.find_files(_, opts)
    end
end

return M
