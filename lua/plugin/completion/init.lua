return {
    {
        "saghen/blink.cmp",
        version = "v0.*",
        event = "InsertEnter",
        module = false,
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
                config = function()
                    require("plugin.completion.luasnip").setup()
                end,
            },
        },
        opts = {
            keymap = {
                preset = "default",
                ["<C-l>"] = { "select_and_accept" },
                ["<C-k>"] = { "scroll_documentation_up", "fallback" },
                ["<C-j>"] = { "scroll_documentation_down", "fallback" },
            },
            completion = {
                ghost_text = { enabled = true },
                documentation = {
                    auto_show = true,
                    window = { border = "single" },
                },
                menu = {
                    border = "single",
                    draw = {
                        treesitter = { 'lsp' },
                        columns = { { "label", "label_description" }, { "kind" }, { "source_name" } },
                    },
                },
            },
            snippets = {
                ---@diagnostic disable different-requires
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },
            sources = { default = { "lsp", "path", "luasnip", "buffer" } },
            signature = { enabled = true },
        },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            { "hrsh7th/cmp-nvim-lsp", module = false },
        },
        event = "InsertEnter",
        enabled = false,

        config = function()
            local function has_words_before()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "luasnip", group_index = 2 },
                },
                formatting = {
                    expandable_indicator = false,
                    fields = { "abbr", "kind", "menu" },
                    format = function(entry, kind)
                        kind.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                        })[entry.source.name]
                        return kind
                    end,
                },
                performance = {
                    max_view_entries = 15,
                },
                experimental = {
                    ghost_text = false,
                },
                views = {
                    entries = "native",
                },
                snippet = {
                    expand = function(args)
                        ---@diagnostic disable-next-line: different-requires
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        border = "single",
                        winhighlight = "Normal:NormalFloatAlt,CmpItemAbbr:NormalFloatAlt,FloatBorder:FloatBorderAlt,CursorLine:PmenuSel",
                        zindex = 80,
                    },
                    documentation = {
                        border = "single",
                        winhighlight = "Normal:CmpDocNormal,CmpItemAbbr:CmpDocNormal,FloatBorder:CmpDocBorder",
                        max_width = 80,
                        max_height = 30,
                        zindex = 50,
                    },
                },
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        bufs[vim.api.nvim_win_get_buf(win)] = true
                    end
                    return vim.tbl_keys(bufs)
                end,

                mapping = {
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<M-j>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "s" }),
                    ["<M-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "s" }),
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),

                    ["<C-l>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                },
            })
        end,
    },
}
