local key = require("utils.map")
local opts = key.new_opts

key.nmap({
    { "gq", ":tabclose<CR>", opts(0) }
})
