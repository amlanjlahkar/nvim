local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local extras = require("luasnip.extras")
local fmta = require("luasnip.extras.fmt").fmta
local rep = extras.rep

return {
    s(
        "rlt",
        fmta(
            [[
        function rohitLikesTo(activity = '<>') {
            intensity = '<>';
            return `Rohit likes to ${activity} with ${intensity} intensity.`;
        }
        ]],
            {
                i(1, "eat"),
                c(2, {
                    t("low"),
                    t("mid"),
                    t("hard"),
                    t("extreme"),
                    i(nil, "unknown to mankind...")
                }),
            }
        )
    ),
}
