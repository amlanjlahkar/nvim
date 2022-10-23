local is_available, telescope = pcall(require, "telescope")
if not is_available then
  return
end

telescope.setup {
  defaults = {
    prompt_prefix = " 🔎 ",
    multi_icon = " + ",
    layout_config = {
      center = {
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
    file_ignore_patterns = { "vendor" },
  },
}

require("config.telescope.keymap")
