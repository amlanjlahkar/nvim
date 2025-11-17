return {
    'amlanjlahkar/cthru.nvim',
    name = 'cthru',
    enabled = false,
    -- dev = true,
    lazy = false,
    config = function()
        require('cthru').configure({
            additional_groups = {},
            excluded_groups = { 'NormalFloat', 'FloatBorder' },
            remember_state = true,
        })
    end,
}
