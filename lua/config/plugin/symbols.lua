local is_available, symbols = pcall(require, "symbols-outline")
if not is_available then
  return
end

symbols.setup {
  width = 30,
  symbols = {
    File = { icon = "", hl = "TSURI" },
    Module = { icon = "Mod", hl = "TSNamespace" },
    Namespace = { icon = "ns", hl = "TSNamespace" },
    Package = { icon = "Pkg", hl = "TSNamespace" },
    Class = { icon = "Cl", hl = "TSType" },
    Method = { icon = "M", hl = "TSMethod" },
    Property = { icon = "pr", hl = "TSMethod" },
    Field = { icon = "fi", hl = "TSField" },
    Constructor = { icon = "cs", hl = "TSConstructor" },
    Enum = { icon = "en", hl = "TSType" },
    Interface = { icon = "In", hl = "TSType" },
    Function = { icon = "f", hl = "TSFunction" },
    Variable = { icon = "var", hl = "TSConstant" },
    Constant = { icon = "K", hl = "TSConstant" },
    String = { icon = "str", hl = "TSString" },
    Number = { icon = "num", hl = "TSNumber" },
    Boolean = { icon = "boo", hl = "TSBoolean" },
    Array = { icon = "Arr", hl = "TSConstant" },
    Object = { icon = "Ob", hl = "TSType" },
    Key = { icon = "🔑 ", hl = "TSType" },
    Null = { icon = "NULL", hl = "TSType" },
    EnumMember = { icon = "enM", hl = "TSField" },
    Struct = { icon = "St", hl = "TSType" },
    Event = { icon = "Ev", hl = "TSType" },
    Operator = { icon = "op", hl = "TSOperator" },
    TypeParameter = { icon = "tp", hl = "TSParameter" },
  },
}

vim.keymap.set(
  "n",
  "<leader>o",
  "<cmd>SymbolsOutline<CR>",
  { silent = true, noremap = true, desc = "Open symbols' tree" }
)
