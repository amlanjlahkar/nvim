local is_available, telescope = pcall(require, "telescope")
if not is_available then
  return
end

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    multi_icon = " + ",
    layout_config = {
      vertical = {
        anchor = "S",
        height = 0.7,
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
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

require("config.telescope.keymap")
telescope.load_extension("fzf")
