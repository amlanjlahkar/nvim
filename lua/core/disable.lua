local default_plugins = {
  "gzip",
  "tar",
  "zip",
  "getscript",
  "vimball",
  "tarPlugin",
  "zipPlugin",
  "getscriptPlugin",
  "vimballPlugin",
  "2htmlPlugin",
  "matchit",
  -- "matchparen",
  "spec",
  "logiPat",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
}
local providers = { "ruby", "node", "perl", "python3" }

for _, p in pairs(default_plugins) do
  vim.g["loaded_" .. p] = 1
end

for _, p in pairs(providers) do
  vim.g["loaded_" .. p .. "_provider"] = 0
end

