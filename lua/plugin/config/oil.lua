---@class toggle_opts
---@field split? string Split direction. Values are same as supported by config.split key in `nvim_open_win`. Defaults to "right"
---@field height? number Window height (in character cells). Minimum of 1
---@field width? number Window width (in character cells). Minimum of 1

local api = vim.api
local oil = require("oil")

local centry = oil.get_cursor_entry
local cwd = oil.get_current_dir
local bufnr = vim.fn.bufnr

local is_oil_buf = function()
    return vim.bo.ft == "oil"
end

---Toggle oil buffer
---@param opts toggle_opts|nil
local function toggle_oil(opts)
    if is_oil_buf() then
        if vim.fn.winnr("$") > 1 then
            api.nvim_win_close(0, true)
        end
        return
    elseif vim.bo.ft == "fugitive" then
        return
    end

    local def = {
        split = "right",
        width = math.floor(api.nvim_win_get_width(0) / 2.85),
        height = math.floor(api.nvim_win_get_height(0) / 2),
    }

    if not opts or vim.tbl_isempty(opts) then
        opts = def
    else
        local valid_sp = { "left", "right", "above", "below" }
        assert(
            opts.split == nil or vim.tbl_contains(valid_sp, opts.split),
            "Received invalid value for split. Supported values are " .. vim.inspect(valid_sp)
        )
        for k, _ in pairs(def) do
            opts[k] = opts[k] or def[k]
        end
    end

    api.nvim_open_win(0, true, vim.tbl_extend("error", opts, { win = 0 }))
    oil.open()
end

local M = {}

function M.setup()
    oil.setup({
        columns = { "permissions", "size", "mtime" },
        keymaps = {
            ["gh"] = "actions.toggle_hidden",
            ["."] = "actions.open_cmdline",
            ["<C-y>"] = "actions.copy_entry_path",
            ["<C-j>"] = "actions.select",
        },
        win_options = { rnu = false, nu = false },
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                local pattern = { ".git", "LICENSE" }
                return vim.tbl_contains(pattern, name)
            end,
        },
        preview = { border = "single" },
        experimental_watch_for_changes = true,
        natural_sort = false,
    })

    local key = require("utils.map")
    local keyopts = key.new_opts

    key.nmap({
        {
            "\\",
            function()
                toggle_oil({})
            end,
            keyopts("Oil: Toggle oil"),
        },

        {
            "-",
            function()
                if vim.bo.ft ~= "fugitive" then
                    oil.open()
                end
            end,
            keyopts("Oil: Open parent directory"),
        },

        {
            "<leader>ob",
            function()
                if is_oil_buf then
                    local path = cwd() .. centry().name
                    if centry().type == "file" then
                        vim.cmd("Git blame " .. path)
                    else
                        vim.notify(centry .. " is not a regular file!", vim.log.levels.ERROR)
                    end
                end
            end,
            keyopts("Oil: View git blame for file under cursor"),
        },

        {
            "<leader>op",
            function()
                if is_oil_buf then
                    local fname = centry().name
                    require("utils.operate"):operate(cwd() .. fname, cwd(), string.format("On %s > ", fname), "sp")
                end
            end,
            keyopts("Oil: Perform external operation on file under cursor"),
        },

        {
            "<leader>os",
            function()
                ---@diagnostic disable-next-line: different-requires
                require("plugin.telescope.extra.oil").switch_dir(cwd())
            end,
            keyopts("Oil: Fuzzy search and switch to directory"),
        },
    })

    -- Enable cursorline in oil buffer
    if not vim.opt.cursorline:get() then
        api.nvim_create_autocmd({ "BufWinEnter", "BufWinLeave" }, {
            group = api.nvim_create_augroup("_plug.oil", { clear = true }),
            callback = function(args)
                if vim.bo[args.buf].ft == "oil" then
                    vim.wo.cursorline = true
                    return
                end
                vim.wo.cursorline = false
            end,
        })
    end
end

return M
