local is_avail, neorg = pcall(require, "neorg")
if not is_avail then
  return
end

neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.completion"] = {
      config = { engine = "nvim-cmp" },
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes_vault = "~/documents/notes/neorg",
        },
      },
    },
  },
}
