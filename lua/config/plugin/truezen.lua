local is_avail, tz = pcall(require, "true-zen")
if not is_avail then
  return
end

tz.setup {
  modes = {
    ataraxis = {
      padding = {
        left = 20,
        right = 20,
        top = 0,
        bottom = 0,
      },
    },
  },

  integrations = {
    tmux = true,
  },
}
