local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end
local cmp = prequire("cmp")
local ls = prequire("luasnip")

local kind_icons = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

local border = {
    { "╭", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╮", "CmpBorder" },
    { "│", "CmpBorder" },
    { "╯", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╰", "CmpBorder" },
    { "│", "CmpBorder" },
}

cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    mapping = {
        -- general cmp mappings
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "s" }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "s" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "s" }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({
           behavior = cmp.ConfirmBehavior.Replace,
           select = false,
        }),

        -- luasnip mappings
        ["<Tab>"] = cmp.mapping(function(fallback)
            if ls.expand_or_locally_jumpable() then
                ls.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s", silent = true }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if ls.jumpable(-1) then
                ls.jump(-1)
            else
                fallback()
            end
        end, { "i", "s", silent = true }),

        ["<C-l>"] = cmp.mapping(function(fallback)
            if ls.choice_active() then
                ls.change_choice()
            else
                fallback()
            end
        end, { "i", "s", silent = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip'  },
        { name = 'buffer'   },
        { name = 'path'     },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end
    },
    window = {
      documentation = {
        border = nil,
      },
    },
    experimental = {
      ghost_text = true,
    },
    get_bufnrs = function()
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
        end
        return vim.tbl_keys(bufs)
    end
})
