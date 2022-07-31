local is_available, btline = pcall(require, "buftabline")
if not is_available then
  return
end

btline.setup({
  tab_format = "  #{i} #{b}#{f}  ",
  buffer_id_index = false,
  icon_colors = true,
  start_hidden = false,
  auto_hide = false,
  disable_commands = false,
  go_to_maps = true,
  flags = {
      modified = " ●",
      not_modifiable = " ",
      readonly = " [RO]",
  },
  hlgroups = {
      current = "TabLineSel",
      normal = "TabLine",
  },
  show_tabpages = true,
  tabpage_format = " #{n} ",
  tabpage_position = "right",
})
