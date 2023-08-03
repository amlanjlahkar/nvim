return {
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("plugin.completion.luasnip").setup()
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            { "hrsh7th/cmp-nvim-lsp", module = false },
        },
        event = "InsertEnter",

        config = function()
            local function has_words_before()
                local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                formatting = {
                    expandable_indicator = false,
                    fields = { "abbr", "kind", "menu" },
                    format = function(entry, kind)
                        kind.kind = string.format("%s", kind.kind)
                        kind.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                        })[entry.source.name]
                        return kind
                    end,
                },
                performance = {
                    max_view_entries = 10,
                },
                experimental = {
                    ghost_text = false,
                },
                views = {
                    entries = "native",
                },
                snippet = {
                    expand = function(args)
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

                    ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "s" }),
                    ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "s" }),
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
