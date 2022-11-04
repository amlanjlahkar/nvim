local is_available, telescope = pcall(require, "telescope")
if not is_available then
  return
end

telescope.setup {
  defaults = {
    prompt_prefix = " 🔎 ",
    selection_caret = "  ",
    multi_icon = " + ",
    layout_config = {
      center = {
        anchor = "S",
        height = 0.6,
        width = 0.4,
        prompt_position = "bottom",
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--trim",
    },
    file_ignore_patterns = {
      "vendor/*",
      "node_modules/*",
      "spell/*",
      "**/*.bin",
      "**/*.class",
      "**/*.jar",
    },
  },
}

require("config.telescope.keymap")
