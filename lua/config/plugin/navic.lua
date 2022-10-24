local is_navic_available, navic = pcall(require, "nvim-navic")
if not is_navic_available then
  return
end

navic.setup {
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' '
  },
  highlight = true,
  separator = "  ",
  depth_limit = 6,
}

local hl = vim.api.nvim_set_hl

hl(0, "NavicIconsModule",        {default = true, link = "CmpItemKindModule"})
hl(0, "NavicIconsNamespace",     {default = true, link = "TSNamespace"})
hl(0, "NavicIconsMethod",        {default = true, link = "TSMethod"})
hl(0, "NavicIconsProperty",      {default = true, link = "TSProperty"})
hl(0, "NavicIconsField",         {default = true, link = "TSField"})
hl(0, "NavicIconsConstructor",   {default = true, link = "TSConstructor"})
hl(0, "NavicIconsEnum",          {default = true, link = "CmpItemKindEnum"})
hl(0, "NavicIconsInterface",     {default = true, link = "CmpItemKindInterface"})
hl(0, "NavicIconsFunction",      {default = true, link = "TSFunction"})
hl(0, "NavicIconsConstant",      {default = true, link = "TSConstant"})
hl(0, "NavicIconsVariable",      {default = true, link = "TSVariable"})
hl(0, "NavicIconsString",        {default = true, link = "TSString"})
hl(0, "NavicIconsNumber",        {default = true, link = "TSNumber"})
hl(0, "NavicIconsBoolean",       {default = true, link = "TSBoolean"})
hl(0, "NavicIconsArray",         {default = true, link = "CmpItemKindStruct"})
hl(0, "NavicIconsNull",          {default = true, link = "TSException"})
hl(0, "NavicIconsEnumMember",    {default = true, link = "CmpItemKindEnumMember"})
hl(0, "NavicIconsStruct",        {default = true, link = "CmpItemKindStruct"})
hl(0, "NavicIconsEvent",         {default = true, link = "CmpItemKindEvent"})
hl(0, "NavicIconsOperator",      {default = true, link = "TSOperator"})
hl(0, "NavicIconsTypeParameter", {default = true, link = "TSParameter"})
hl(0, "NavicText",               {default = true, link = "WinBar"})
hl(0, "NavicSeparator",          {default = true, link = "WinBar"})
hl(0, "NavicIconsFile",          {default = true, fg = "#787c99"})
hl(0, "NavicIconsPackage",       {default = true, fg = "#bb9af7"})
hl(0, "NavicIconsObject",        {default = true, fg = "#bb9af7"})
hl(0, "NavicIconsKey",           {default = true, fg = "#bb9af7"})
hl(0, "NavicIconsClass",         {default = true, fg = "#bb9af7"})
