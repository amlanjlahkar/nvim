return {
    single_file_support = false,
    root_dir = function(fname)
        return require("lspconfig").util.root_pattern(".sqls.yml")(fname)
    end,
    cmd = { "sqls", "--config", vim.uv.cwd() .. "/.sqls.yml" },
}
