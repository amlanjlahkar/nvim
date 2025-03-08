local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local extras = require("luasnip.extras")
local fmt = require("luasnip.extras.fmt").fmt
local rep = extras.rep

return {
    s(
        "hinit",
        fmt(
            [[
<!DOCTYPE html>
<html lang="en">
    <head>
      <meta charset="UTF-8"/>
      <meta name="viewport" content="width=device-width,initial-scale=1" />
      <title>{}</title>
      <meta name="description" content="{}" />
    </head>
    <body>
      <h1>{}</h1>
      <footer></footer>
      <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
    </body>
</html>
            ]],
            {
                i(1, "Title"),
                i(2, "Description"),
                i(3, "Heading"),
            }
        )
    ),
    s("tw", fmt([[<script src="https://cdn.tailwindcss.com"></script>]], {})),
}
