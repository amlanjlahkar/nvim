local is_avialble, wk = pcall(require, "which-key")
if not is_avialble then
  return
end

wk.setup {
  window = {
    border = "single",
  },
}
