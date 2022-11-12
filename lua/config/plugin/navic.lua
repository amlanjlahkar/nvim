local is_navic_available, navic = pcall(require, "nvim-navic")
if not is_navic_available then
  return
end

navic.setup({
  icons = {
    File = " ",
    Module = " ",
    Namespace = " ",
    Package = " ",
    Class = " ",
    Method = " ",
    Property = " ",
    Field = " ",
    Constructor = " ",
    Enum = " ",
    Interface = " ",
    Function = " ",
    Variable = " ",
    Constant = " ",
    String = " ",
    Number = " ",
    Boolean = " ",
    Array = " ",
    Object = " ",
    Key = " ",
    Null = " ",
    EnumMember = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
  highlight = true,
  separator = "  ",
  depth_limit = 6,
})

local hl = vim.api.nvim_set_hl
local attr = require("core.util").get_hl_attr

-- stylua: ignore start
hl(0, "NavicIconsModule",         { default = false, bg = attr("WinBar", "bg"), fg = attr("CmpItemKindModule", "fg") })
hl(0, "NavicIconsNamespace",      { default = false, bg = attr("WinBar", "bg"), fg = attr("TSNamespace", "fg") })
hl(0, "NavicIconsMethod",         { default = false, bg = attr("WinBar", "bg"), fg = attr("TSMethod", "fg") })
hl(0, "NavicIconsProperty",       { default = false, bg = attr("WinBar", "bg"), fg = attr("TSProperty", "fg") })
hl(0, "NavicIconsField",          { default = false, bg = attr("WinBar", "bg"), fg = attr("TSField", "fg") })
hl(0, "NavicIconsConstructor",    { default = false, bg = attr("WinBar", "bg"), fg = attr("TSConstructor", "fg") })
hl(0, "NavicIconsEnum",           { default = false, bg = attr("WinBar", "bg"), fg = attr("CmpItemKindEnum", "fg") })
hl(0, "NavicIconsInterface",      { default = false, bg = attr("WinBar", "bg"), fg = attr("CmpItemKindInterface", "fg") })
hl(0, "NavicIconsFunction",       { default = false, bg = attr("WinBar", "bg"), fg = attr("TSFunction", "fg") })
hl(0, "NavicIconsConstant",       { default = false, bg = attr("WinBar", "bg"), fg = attr("TSConstant", "fg") })
hl(0, "NavicIconsVariable",       { default = false, bg = attr("WinBar", "bg"), fg = attr("TSVariable", "fg") })
hl(0, "NavicIconsString",         { default = false, bg = attr("WinBar", "bg"), fg = attr("TSString", "fg") })
hl(0, "NavicIconsNumber",         { default = false, bg = attr("WinBar", "bg"), fg = attr("TSNumber", "fg") })
hl(0, "NavicIconsBoolean",        { default = false, bg = attr("WinBar", "bg"), fg = attr("TSBoolean", "fg") })
hl(0, "NavicIconsArray",          { default = false, bg = attr("WinBar", "bg"), fg = attr("CmpItemKindStruct", "fg") })
hl(0, "NavicIconsNull",           { default = false, bg = attr("WinBar", "bg"), fg = attr("TSException", "fg") })
hl(0, "NavicIconsEnumMember",     { default = false, bg = attr("WinBar", "bg"), fg = attr("CmpItemKindEnumMember", "fg") })
hl(0, "NavicIconsStruct",         { default = false, bg = attr("WinBar", "bg"), fg = attr("CmpItemKindStruct", "fg") })
hl(0, "NavicIconsEvent",          { default = false, bg = attr("WinBar", "bg"), fg = attr("CmpItemKindEvent", "fg") })
hl(0, "NavicIconsOperator",       { default = false, bg = attr("WinBar", "bg"), fg = attr("TSOperator", "fg") })
hl(0, "NavicIconsTypeParameter",  { default = false, bg = attr("WinBar", "bg"), fg = attr("TSParameter", "fg") })
hl(0, "NavicIconsFile",           { default = false, bg = attr("WinBar", "bg"), fg = "#787c99" })
hl(0, "NavicIconsPackage",        { default = false, bg = attr("WinBar", "bg"), fg = "#bb9af7" })
hl(0, "NavicIconsObject",         { default = false, bg = attr("WinBar", "bg"), fg = "#bb9af7" })
hl(0, "NavicIconsKey",            { default = false, bg = attr("WinBar", "bg"), fg = "#bb9af7" })
hl(0, "NavicIconsClass",          { default = false, bg = attr("WinBar", "bg"), fg = "#bb9af7" })
hl(0, "NavicText",                { default = false, link = "WinBar" })
hl(0, "NavicSeparator",           { default = false, link = "WinBar" })
-- stylua: ignore end
