local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s({
    trig = "def",
    dscr = "Default configs for root build",
    snippetType = "snippet",
  }, {
    t({
      "plugins {",
      "  id 'java'",
      "}",
      "",
      "jar {",
      "  manifest {",
      "    attributes 'Main-Class': 'com.amlanjlahkar.Main'",
      "  }",
      "}",
    }),
  }),
}
